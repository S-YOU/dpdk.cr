require "../dpdk_minimal"
require "./fixtures"
require "./packets"
require "./tap"
require "../dpdk/arg_parse"

lib LibPerf
  struct AppParams
    mac : UInt64
    pool : LibDpdk::RteMempool*
    port : LibDpdk::PortT
  end
end

module BasePerf
  APP_STATS      = 1_000_000
  REQUIRED_CORES =         3
  REQUIRED_PORTS =         2

  RING_SIZE         =  65536_u32
  MAX_PKTS_BURST    =     32_u32
  RX_DESC_PER_QUEUE =   1024_u16
  TX_DESC_PER_QUEUE =   4096_u16
  MBUF_PER_POOL     = 262143_u32
  ETHER_MAX_LEN     =       1600
  ETHER_MTU         = ETHER_MAX_LEN - 18

  macro included
    RTE_LOGTYPE_{{ @type.name.upcase.id }} = RTE_LOGTYPE_USER1

    alias AppParams = LibPerf::AppParams

    @portmask = 1_u32
    @quit_signal = false
    @app_params = uninitialized AppParams[REQUIRED_PORTS]
    @port_conf = uninitialized RteEthConf

    def parse_args(name, argc, argv) : Void
      ArgParse.parse(argc, argv) do |opts|
        opts << "\nsudo "
        opts << name
        opts << " [EAL options] -- -p PORTMASK\n"
        opts.on("-p PORTMASK", "Hexadecimal bitmask of ports to configure (default: #{@portmask})") do |portmask|
          @portmask = portmask.sub("0x", "").to_u32(base: 16) { 1_u32 }
        end
        opts.on("--tap-host", "Enable host tap interface") { @tap_host_fd = -1 }
        opts.on("--tap-mirror", "Enable tap mirror interface") { @tap_mirror = true }
        opts.on("-h", "--help", "Show this help message") { opts.print_help; LibC.exit(0) }
        self.options(opts) if self.responds_to?(:options)
        opts.invalid_option do |arg|
          opts.print_help
          fail("Invalid arguments: %s\n", arg)
        end
      end
    end

    def port_init(index, port) : Void
      pool = pool_create("mbuf_pool#{port}", MBUF_PER_POOL, RTE_MEMPOOL_CACHE_MAX_SIZE)
      @app_params.pointer_at(index).value.pool = pool
      @app_params.pointer_at(index).value.port = port
      rx_rings = tx_rings = 1_u16
      nb_rxd = RX_DESC_PER_QUEUE
      nb_txd = TX_DESC_PER_QUEUE

      pointerof(@port_conf).clear
      @port_conf.rxmode.max_rx_pkt_len = ETHER_MAX_LEN
      @port_conf.rxmode.flags = RteEthRxmodeFlags::IgnoreOffloadBitfield
      {% if LibDpdk::HAS_OFFLOAD %}
        @port_conf.rxmode.offloads = DEV_RX_OFFLOAD_CHECKSUM | DEV_RX_OFFLOAD_CRC_STRIP
      {% end %}

      nb_ports = rte_eth_dev_count
      fail("Not enough ports: %hu\n", port) if port >= nb_ports

      dev_info = uninitialized RteEthDevInfo
      LibDpdk.rte_eth_dev_info_get(port, pointerof(dev_info))
      rxconf_ptr = pointerof(dev_info.@default_rxconf)
      {% if LibDpdk::HAS_OFFLOAD %}
        rxconf_ptr.value.offloads = @port_conf.rxmode.offloads
      {% end %}
      txconf_ptr = configure_tx_offload(@port_conf, dev_info)

      rte_eth_dev_configure(port, rx_rings, tx_rings, pointerof(@port_conf))

      rte_eth_dev_adjust_nb_rx_tx_desc(port, pointerof(nb_rxd), pointerof(nb_txd))

      rte_eth_macaddr_get(port, @app_params.pointer_at(index).as(EtherAddr*))

      # Allocate and set up 1 RX queue per Ethernet port.
      rx_rings.times do |q|
        rte_eth_rx_queue_setup(port, q, nb_rxd, rte_eth_dev_socket_id(port), rxconf_ptr, pool)
      end

      # Allocate and set up 1 TX queue per Ethernet port.
      tx_rings.times do |q|
        rte_eth_tx_queue_setup(port, q, nb_txd, rte_eth_dev_socket_id(port), txconf_ptr)
        # rte_eth_tx_queue_setup(port, q, nb_txd, rte_eth_dev_socket_id(port), nil)
      end

      rte_eth_dev_set_mtu(port, ETHER_MTU)

      # Start the Ethernet port.
      rte_eth_dev_start(port)

      # Display the port MAC address.
      printf("Port %hu MAC: ", port)
      print_macaddr(port)
      puts("")

      # Enable RX in promiscuous mode for the Ethernet device.
      rte_eth_promiscuous_enable(port)
    end

    def wait_link_up : Void
      link = uninitialized RteEthLink
      nb_ports = rte_eth_dev_count

      printf("Waiting for Link up on all enabled ports ")
      fflush(stdout)
      until @quit_signal
        printf(".")
        fflush(stdout)
        all_up = true
        nb_ports.times do |port|
          next if (@portmask & (1 << port)) == 0

          rte_eth_link_get_nowait(port, pointerof(link))
          next unless link.link_flags.none?
          all_up = false
        end
        break if all_up
        usleep 500_000
      end
      printf(" done\n")
    end

    def signal_handler(signum) : Void
      if signum == LibC::SIGINT
        @quit_signal = true
      elsif signum == LibC::SIGUSR1
        @tap_mirror ^= true
      end
    end

    def main(argc, argv) : Void
      # catch ctrl-c so we can print on exit
      signal(SIGINT, signal_handler)
      signal(SIGUSR1, signal_handler)

      # Initialize EAL
      ret = rte_eal_init(argc, argv)
      argc -= ret + 1
      argv += ret + 1

      # Parse the application  arguments
      parse_args String.new(argv[0]), argc, argv

      # fail("Error: no ethernet ports detected\n") if rte_eth_dev_count == 0

      lcore_count = rte_lcore_count
      fail("Error, This application needs %d cores\n", REQUIRED_CORES) if lcore_count < REQUIRED_CORES

      index, nb_ports = 0, rte_eth_dev_count
      nb_ports.times do |port|
        next if (@portmask & (1 << port)) == 0
        printf("Initializing port %u... done\n", port)

        port_init(index, port)

        index += 1
        break if index >= REQUIRED_PORTS
      end

      if REQUIRED_PORTS > 0
        wait_link_up
      else
        pool = pool_create(MBUF_PER_POOL, RTE_MEMPOOL_CACHE_MAX_SIZE)
        @app_params = uninitialized AppParams[1]
        @app_params.pointer_at(0).value.pool = pool
      end

      fail("Error, This application needs %d ports, provided %d\n", REQUIRED_PORTS, index) if index < REQUIRED_PORTS
    end
  end

  private macro option(long, desc, var, unit)
    opts.on({{long}}, {{desc}} + " (default: #{to_{{unit}}({{var}})})") {|x| apply_from_{{unit}}({{var}}, x)}
  end

  private macro option(long, desc, var)
    opts.on({{long}}, {{desc}} + " (default: #{{{var}}})") { {{var}} = true }
  end

  private macro options
    def options(opts) : Void
      {{yield}}
    end
  end

  macro wait_tap_host
    until @tap_host_fd > 0
      usleep 10000
      return if @quit_signal
    end
  end

  private macro tap?
    @tap_host_fd != 0 || @tap_mirror
  end

  private macro main(&block)
    def main(argc, argv) : Void
      previous_def

      {{ yield }}

      rte_lcore_foreach_slave do |lcore_id|
        return if rte_eal_wait_lcore(lcore_id) < 0
      end

      nb_ports = rte_eth_dev_count
      nb_ports.times do |port|
        rte_eth_dev_stop port
      end

      {% if LibDpdk::IS_18_2 %}
        rte_eal_cleanup
      {% end %}
    end
  end

  private macro thread(name, &block)
    def {{name}}(arg_ptr : Void*) : Void
      params = arg_ptr.as(AppParams*)
      port = params.value.port
      pool = params.value.pool
      mac = params.value.mac
      pkts = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
      printf("{{@type.name.upcase.id}}: {{name}}() started on lcore %u, port: %hu\n", rte_lcore_id, port)

      {{ yield params }}
    end
  end

  private macro ring_thread(name, &block)
    thread {{name}} do
      ring = rte_ring_create("ring_{{name}}", RING_SIZE, rte_socket_id, RING_F_SP_ENQ | RING_F_SC_DEQ)
      mbuf = rte_pktmbuf_alloc(pool)
      {{ yield }}
    end
  end

  private macro thread(&block)
    thread main_thread do
      {{ yield }}
    end
  end

  private macro rte_ring_lookup(*args)
    {% for arg in args %}
      ring_{{arg}} = Dpdk.rte_ring_lookup("ring_{{arg}}")
    {% end %}
  end

  private macro rte_ring_dequeue_burst(name)
    nb_rx = rte_ring_dequeue_burst(ring_{{name}}, pkts, MAX_PKTS_BURST, nil).to_u16
  end

  private macro rte_ring_dequeue_burst!
    nb_rx = rte_ring_dequeue_burst(ring, pkts, MAX_PKTS_BURST, nil).to_u16
    next if nb_rx == 0
  end

  private macro rte_ring_enqueue_burst?(name, pkts, n)
    if {{n}} > 0
      %m = rte_ring_enqueue_burst(ring_{{name}}, {{pkts}}, {{n}}, nil)
      while %m < {{n}}
        rte_pktmbuf_free(({{pkts}})[%m])
        %m += 1
      end
    end
  end

  private macro rte_eth_rx_burst!
    nb_rx = rte_eth_rx_burst(port, 0_u16, pkts, MAX_PKTS_BURST)
    next if nb_rx == 0
  end

  private macro rte_eth_rx_burst(&block)
    nb_rx = rte_eth_rx_burst(port, 0_u16, pkts, MAX_PKTS_BURST)
    if nb_rx > 0
      {{yield}}
    end
  end

  private macro rte_eth_tx_burst!
    if nb_rx > 0
      nb_tx = rte_eth_tx_burst(port, 0_u16, pkts, nb_rx)
      while unlikely(nb_tx < nb_rx)
        nb_tx += rte_eth_tx_burst(port, 0_u16, pkts + nb_tx, nb_rx - nb_tx)
      end
    else
      nb_tx = 0
    end
    nb_tx
  end

  private macro rte_eth_tx_burst?
    if nb_rx > 0
      nb_tx = rte_eth_tx_burst(port, 0_u16, pkts, nb_rx)
      # printf("tx packets dropped: rx: %hu, tx: %hu\n", nb_rx, nb_tx) if nb_rx > nb_tx
      while nb_tx < nb_rx
        rte_pktmbuf_free(pkts[nb_tx])
        nb_tx += 1
      end
    end
  end

  private macro rte_pktmbuf_free!
    nb_rx.times do |i|
      LibDpdk.rte_pktmbuf_free(pkts[i])
    end
  end

  private macro rte_ring_enqueue_burst?(ring, name)
    rte_ring_enqueue_burst?({{ring}}, pkts_{{name}}, nb_{{name}})
  end

  private macro rte_ring_create(name)
    ring_{{name}} = rte_ring_create("ring_{{name}}", RING_SIZE, rte_socket_id, RING_F_SP_ENQ | RING_F_SC_DEQ)
  end

  private macro rte_eal_remote_launch(thread)
    rte_eal_remote_launch({{thread}}, @app_params.pointer_at(worker_id).as(Void*), lcore_id)
  end

  private macro rte_eal_remote_launch(thread, port_id)
    rte_eal_remote_launch({{thread}}, @app_params.pointer_at({{port_id}}).as(Void*), lcore_id)
  end

  private macro rte_eal_remote_launch
    rte_eal_remote_launch(main_thread, @app_params.pointer_at(0).as(Void*), lcore_id)
  end
end

macro dpdk(&block)
  class Perf < Dpdk
    include BasePerf
    include Packets
    include Tap

    {{yield}}
  end
  {% if flag?(:release) %}
    fun main(argc : Int32, argv : UInt8**) : Int32
      Perf.instance.main(argc, argv); 0
    end
  {% else %}
    Perf.run
  {% end %}
end
