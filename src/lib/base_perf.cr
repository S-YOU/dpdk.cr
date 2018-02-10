require "option_parser"
require "../dpdk"
require "./fixtures"

module BasePerf
  APP_STATS      = 1_000_000
  REQUIRED_CORES =         3
  REQUIRED_PORTS =         2

  macro included
    RX_DESC_PER_QUEUE    =  4096_u16
    TX_DESC_PER_QUEUE    =  4096_u16
    RING_SIZE            = 16384_u32
    MAX_PKTS_BURST       =    32_u32
    MBUF_PER_POOL        = 65535_u32
    MBUF_POOL_CACHE_SIZE =   250_u32

    RTE_LOGTYPE_{{ @type.name.upcase.id }} = RTE_LOGTYPE_USER1

    record AppParams, port : PortT, pool : RteMempool*

    @portmask = 3_u32
    @quit_signal = false
    @app_params = uninitialized AppParams[RTE_MAX_ETHPORTS]
    @port_conf = uninitialized RteEthConf

    def parse_args
      OptionParser.parse! do |opts|
        opts.banner = "\nsudo #{PROGRAM_NAME} [EAL options] -- -p PORTMASK"
        opts.on("-p PORTMASK", "Hexadecimal bitmask of ports to configure (default: #{@portmask})") do |portmask|
          @portmask = portmask.sub("0x", "").to_u32(base: 16)
        end
        opts.on("-h", "--help", "Show this help message") { puts opts; exit }
        self.options(opts) if self.responds_to?(:options)
        opts.invalid_option do |arg|
          puts opts
          fail("Invalid arguments: %s\n", arg)
        end
      end
    end

    def port_init(port, pool)
      rx_rings = tx_rings = 1_u16
      nb_rxd = RX_DESC_PER_QUEUE
      nb_txd = TX_DESC_PER_QUEUE

      @port_conf.rxmode.flags = RteEthRxmodeFlags::IgnoreOffloadBitfield

      nb_ports = rte_eth_dev_count
      fail("Not enough ports: %hu\n", port) if port >= nb_ports

      dev_info = rte_eth_dev_info_get(port)
      txconf_ptr = configure_tx_offload(@port_conf, dev_info)

      rte_eth_dev_configure(port, rx_rings, tx_rings, pointerof(@port_conf))

      rte_eth_dev_adjust_nb_rx_tx_desc(port, pointerof(nb_rxd), pointerof(nb_txd))

      # Allocate and set up 1 RX queue per Ethernet port.
      rx_rings.times do |q|
        rte_eth_rx_queue_setup(port, q, nb_rxd, rte_eth_dev_socket_id(port), nil, pool)
      end

      # Allocate and set up 1 TX queue per Ethernet port.
      tx_rings.times do |q|
        rte_eth_tx_queue_setup(port, q, nb_txd, rte_eth_dev_socket_id(port), txconf_ptr)
      end

      # Start the Ethernet port.
      rte_eth_dev_start(port)

      # Display the port MAC address.
      printf("Port %hu MAC: %s\n", port, macaddr_get(port))

      # Enable RX in promiscuous mode for the Ethernet device.
      rte_eth_promiscuous_enable(port)
    end

    def wait_link_up
      link = uninitialized RteEthLink
      nb_ports = rte_eth_dev_count

      STDOUT << "Waiting for Link up on all enabled ports "
      STDOUT.flush
      until @quit_signal
        STDOUT << "."
        STDOUT.flush
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

    def signal_handler(signum)
      @quit_signal = true
    end

    def main(argc, argv)
      # catch ctrl-c so we can print on exit
      signal(SIGINT, signal_handler)

      # Initialize EAL
      ARGV.shift rte_eal_init(argc, argv)

      # Parse the application  arguments
      parse_args

      fail("Error: no ethernet ports detected\n") if rte_eth_dev_count == 0

      lcore_count = rte_lcore_count
      fail("Error, This application needs %d cores\n", REQUIRED_CORES) if lcore_count < REQUIRED_CORES

      index, nb_ports = 0, rte_eth_dev_count
      nb_ports.times do |port|
        next if (@portmask & (1 << port)) == 0
        printf("Initializing port %u... done\n", port)

        pool = pool_create("mbuf_pool#{port}", MBUF_PER_POOL, MBUF_POOL_CACHE_SIZE)
        @app_params[index] = AppParams.new port, pool
        port_init(port, pool)

        index += 1
        break if index >= REQUIRED_PORTS
      end

      wait_link_up

      fail("Error, This application needs %d ports, provided %d\n", REQUIRED_PORTS, index) if index < REQUIRED_PORTS
    end
  end

  private macro option(long, desc, var, unit)
    opts.on({{long}}, {{desc}} + " (default: #{to_{{unit}}({{var}})})") {|x| apply_from_{{unit}}({{var}}, x)}
  end

  private macro options
    def options(opts)
      {{yield}}
    end
  end

  private macro main(&block)
    def main(argc, argv)
      previous_def

      {{ yield }}

      rte_lcore_foreach_slave do |lcore_id|
        return if rte_eal_wait_lcore(lcore_id) < 0
      end

      {% if LibDpdk::IS_18_2 %}
        rte_eal_cleanup
      {% end %}
    end
  end

  private macro thread(name, &block)
    def {{name}}(arg_ptr : Void*)
      params = arg_ptr.as(AppParams*)
      port = params.value.port
      pool = params.value.pool
      pkts = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
      rte_log(INFO, {{@type.name.upcase.id}}, "{{name}}() started on lcore %u, port: %hu\n", rte_lcore_id, port)
      measure_init
      {{ yield params }}
      measure_output({{name.name.upcase}})
    end
  end

  private macro ring_thread(name, &block)
    thread {{name}} do
      ring = rte_ring_create("ring_{{name}}", RING_SIZE, rte_socket_id, RING_F_SP_ENQ | RING_F_SC_DEQ)
      pkts_out = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
      {{ yield }}
    end
  end

  private macro rte_eal_remote_launch(thread)
    rte_eal_remote_launch({{thread}}, @app_params.pointer_at(worker_id).as(Void*), lcore_id)
  end
end

macro perf(name, &block)
  class {{name}} < Dpdk
    include BasePerf
    {{yield}}
  end
  {{name}}.run
end
