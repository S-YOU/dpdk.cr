require "option_parser"
require "../src/dpdk"

lib LibL2fwd
  MAX_RX_QUEUE_PER_LCORE = 16

  struct LcoreQueueConf
    n_rx_port : LibC::UInt
    rx_port_list : LibC::UInt[MAX_RX_QUEUE_PER_LCORE]
  end

  # Per-port statistics struct
  struct PortStatistics
    tx : LibC::UInt64T
    rx : LibC::UInt64T
    dropped : LibC::UInt64T
  end
end

class L2fwd < Dpdk
  BURST_TX_DRAIN_US  = 100_u64 # TX drain every ~100us
  MAX_PKT_BURST      =  32_u16
  MEMPOOL_CACHE_SIZE = 256_u32
  # Configurable number of RX/TX ring descriptors
  RTE_TEST_RX_DESC_DEFAULT = 1024_u16
  RTE_TEST_TX_DESC_DEFAULT = 1024_u16
  RTE_LOGTYPE_L2FWD        = RTE_LOGTYPE_USER1
  MAX_TIMER_PERIOD         = 86400 # 1 day max

  @lcore_queue_conf = uninitialized LibL2fwd::LcoreQueueConf[RTE_MAX_LCORE]
  @port_statistics = uninitialized LibL2fwd::PortStatistics[RTE_MAX_ETHPORTS]
  @tx_buffer = uninitialized RteEthDevTxBuffer*[RTE_MAX_ETHPORTS]
  @l2fwd_dst_ports = uninitialized UInt32[RTE_MAX_ETHPORTS]                  # list of enabled ports
  @l2fwd_ports_eth_addr = uninitialized LibDpdk::EtherAddr[RTE_MAX_ETHPORTS] # thernet addresses of ports
  @pkts_burst = uninitialized RteMbuf*[MAX_PKT_BURST]
  @port_conf = uninitialized RteEthConf
  @mbuf_pool = Pointer(RteMempool).new(0)

  @force_quit = false
  @mac_updating = true              # MAC updating enabled by default
  @timer_period = 10_u64            # T
  @portmask = 0_u32                 # -p - mask of enabled ports
  @l2fwd_rx_queue_per_lcore = 1_u32 # -q
  @nb_rxd = RTE_TEST_RX_DESC_DEFAULT
  @nb_txd = RTE_TEST_TX_DESC_DEFAULT

  def print_stats
    total_packets_dropped = 0
    total_packets_tx = 0
    total_packets_rx = 0
    nb_ports = rte_eth_dev_count
    eth_stats = uninitialized RteEthStats

    clr = "\x1b[2J"
    topLeft = "\x1b[1;1H"

    # Clear screen and move to top left
    printf("%s%s", clr, topLeft)

    printf("\nPort statistics ====================================")

    RTE_MAX_ETHPORTS.times do |port|
      # skip disabled ports
      next if (@portmask & (1 << port)) == 0
      printf("
Statistics for port %u ------------------------------
Packets sent: %24u
Packets received: %20u
Packets dropped: %21u",
        port,
        @port_statistics[port].tx,
        @port_statistics[port].rx,
        @port_statistics[port].dropped)

      total_packets_dropped += @port_statistics[port].dropped
      total_packets_tx += @port_statistics[port].tx
      total_packets_rx += @port_statistics[port].rx
    end

    printf("
Aggregate statistics ===============================
Total packets sent: %18u
Total packets received: %14u
Total packets dropped: %15u",
      total_packets_tx,
      total_packets_rx,
      total_packets_dropped)
    printf("\n====================================================\n")
  end

  private macro l2fwd_mac_updating(m, dest_portid)
    eth = rte_pktmbuf_mtod({{m}})

    # d_addr = 02:00:00:00:00:xx
    eth.as(UInt64*).value = 2_u64 + ({{dest_portid}}.to_u64 << 40)

    # s_addr
    eth.offset_at(6).as(LibDpdk::EtherAddr*).value = @l2fwd_ports_eth_addr[{{dest_portid}}]
  end

  private macro l2fwd_simple_forward(m, port)
    dst_port = @l2fwd_dst_ports[{{port}}]

    l2fwd_mac_updating({{m}}, dst_port) if @mac_updating

    sent = rte_eth_tx_buffer(dst_port.to_u16, 0_u16, @tx_buffer[dst_port], m)
    @port_statistics.pointer_at(dst_port).as(UInt64*).value += sent if sent > 0
  end

  def l2fwd_main_loop
    drain_tsc = (rte_get_tsc_hz + US_PER_S - 1) / US_PER_S * BURST_TX_DRAIN_US
    prev_tsc = timer_tsc = 0_u64

    lcore_id = rte_lcore_id
    qconf = @lcore_queue_conf.pointer_at(lcore_id)
    n_rx_port = qconf.as(UInt32*).value
    rx_port_list_ptr = qconf.offset_at(4).as(UInt32*)

    if n_rx_port == 0
      rte_log(INFO, L2FWD, "lcore %u has nothing to do\n", lcore_id)
      return
    end

    rte_log(INFO, L2FWD, "entering main loop on lcore %u\n", lcore_id)

    n_rx_port.times do |i|
      port = rx_port_list_ptr[i]
      rte_log(INFO, L2FWD, " -- lcoreid=%u port=%u\n", lcore_id, port)
    end

    pkts_burst_ptr = @pkts_burst.to_unsafe

    until @force_quit
      cur_tsc = rte_rdtsc

      # TX burst queue drain
      diff_tsc = cur_tsc - prev_tsc
      if unlikely(diff_tsc > drain_tsc)
        n_rx_port.times do |i|
          port = @l2fwd_dst_ports[rx_port_list_ptr[i]]

          sent = rte_eth_tx_buffer_flush(port.to_u16, 0_u16, @tx_buffer[port])
          # .tx += sent
          @port_statistics.pointer_at(port).as(UInt64*).value += sent if sent > 0
        end

        # if timer is enabled
        if @timer_period > 0
          # advance the timer
          timer_tsc += diff_tsc

          # if timer has reached its timeout
          if unlikely(timer_tsc >= @timer_period)
            # do this only on master core
            if lcore_id == rte_get_master_lcore
              print_stats
              # reset the timer
              timer_tsc = 0_u64
            end
          end
        end

        prev_tsc = cur_tsc
      end

      # Read packet from RX queues
      n_rx_port.times do |i|
        port = rx_port_list_ptr[i]

        nb_rx = rte_eth_rx_burst(port.to_u16, 0_u16, pkts_burst_ptr, MAX_PKT_BURST)
        # .rx += nb_rx
        @port_statistics.pointer_at(port).offset_at(8).as(UInt64*).value += nb_rx if nb_rx > 0

        nb_rx.times do |j|
          m = pkts_burst_ptr[j]

          rte_prefetch0(rte_pktmbuf_mtod(m))
          l2fwd_simple_forward(m, port)
        end
      end
    end
  end

  def print_usage
    printf("
%s [EAL options] -- -p PORTMASK [-q NQ]
  -p PORTMASK: hexadecimal bitmask of ports to configure
  -q NQ: number of queue (=ports) per lcore (default is 1)
  -T PERIOD: statistics will be refreshed each PERIOD seconds (0 to disable, 10 default, 86400 maximum)
  --[no-]mac-updating: Enable or disable MAC addresses updating (enabled by default)
      When enabled:
        - The source MAC address is replaced by the TX port MAC address
        - The destination MAC address is replaced by 02:00:00:00:00:TX_PORT_ID
", PROGRAM_NAME)
  end

  def parse_args
    OptionParser.parse! do |opts|
      opts.on("-p PORTMASK", "hexadecimal bitmask of ports to configure") do |portmask|
        @portmask = portmask.sub("0x", "").to_u32(base: 16)
      end
      opts.on("-q NQ", "number of queue (=ports) per lcore (default is 1)") do |nq|
        @l2fwd_rx_queue_per_lcore = nq.to_u32
      end
      opts.on("-T PERIOD", "statistics will be refreshed each PERIOD seconds (0 to disable, 10 default, 86400 maximum)") do |period|
        @timer_period = period.to_u64
        fail("timer_period too large\n") if @timer_period >= MAX_TIMER_PERIOD
      end
      opts.on("--mac-updating", "Enable MAC addresses updating") { @mac_updating = true }
      opts.on("--no-mac-updating", "Disable MAC addresses updating") { @mac_updating = false }
      opts.invalid_option do |arg|
        print_usage
        fail("Invalid arguments: %s\n", arg)
      end
    end
  end

  def check_all_ports_link_status(nb_ports, port_mask)
    link = uninitialized RteEthLink
    check_interval = 100 # 100ms
    max_check_time = 90  # 9s (90 * 100ms) in total
    print_flag = 0_u8

    STDOUT << "\nChecking link status"
    STDOUT.flush

    max_check_time.times do |count|
      return if @force_quit
      all_ports_up = 1_u8

      nb_ports.times do |port|
        return if @force_quit
        next if (port_mask & (1 << port)) == 0

        rte_eth_link_get_nowait(port, pointerof(link))

        # print link status if flag set
        if print_flag == 1
          if link.link_flags.status_up?
            printf("Port%d Link Up. Speed %u Mbps - %s\n", port, link.link_speed,
              link.link_flags.full_duplex? ? "full-duplex" : "half-duplex\n")
          else
            printf("Port %d Link Down\n", port)
          end
          next
        end

        # clear all_ports_up flag if any link down
        if link.link_flags.none?
          all_ports_up = 0
          break
        end
      end

      # after finally printing all link status, get out
      break if print_flag == 1

      if all_ports_up == 0
        STDOUT << "."
        STDOUT.flush
        rte_delay_us_block(check_interval * 1000)
      end

      # set the print_flag if all ports up or timeout
      if all_ports_up == 1 || count == max_check_time - 1
        print_flag = 1
        printf("done\n")
      end
    end
  end

  def signal_handler(signum)
    if signum == LibC::SIGINT || signum == LibC::SIGTERM
      printf("\n\nSignal %d received, preparing to exit...\n", signum)
      @force_quit = true
    end
  end

  def port_init(port)
    @port_conf.rxmode.flags = RteEthRxmodeFlags::IgnoreOffloadBitfield
    {% if LibDpdk::HAS_OFFLOAD %}
      @port_conf.rxmode.offloads = DEV_RX_OFFLOAD_CRC_STRIP
    {% end %}

    STDOUT << "Initializing port #{port}... "
    STDOUT.flush

    dev_info = rte_eth_dev_info_get(port)
    txconf_ptr = configure_tx_offload(@port_conf, dev_info)

    rte_eth_dev_configure(port, 1_u16, 1_u16, pointerof(@port_conf))

    rte_eth_dev_adjust_nb_rx_tx_desc(port, pointerof(@nb_rxd), pointerof(@nb_txd))

    rte_eth_macaddr_get(port, @l2fwd_ports_eth_addr.pointer_at(port))

    # init one RX queue
    STDOUT.flush
    rxq_conf = dev_info.default_rxconf
    {% if LibDpdk::HAS_OFFLOAD %}
      rxq_conf.offloads = @port_conf.rxmode.offloads
    {% end %}
    rte_eth_rx_queue_setup(port, 0_u16, @nb_rxd, rte_eth_dev_socket_id(port), pointerof(rxq_conf), @mbuf_pool)

    # init one TX queue on each port
    STDOUT.flush
    rte_eth_tx_queue_setup(port, 0_u16, @nb_txd, rte_eth_dev_socket_id(port), txconf_ptr)

    # Initialize TX buffers
    STDOUT.flush
    @tx_buffer[port] = rte_zmalloc_socket("tx_buffer", rte_eth_tx_buffer_size(MAX_PKT_BURST), 0_u32, rte_eth_dev_socket_id(port)).as(RteEthDevTxBuffer*)
    fail("Cannot allocate buffer for tx on port %u\n", port) if @tx_buffer[port].null?

    rte_eth_tx_buffer_init(@tx_buffer[port], MAX_PKT_BURST)

    ret = rte_eth_tx_buffer_set_err_callback(@tx_buffer[port], ->LibDpdk.rte_eth_tx_buffer_count_callback, @port_statistics.pointer_at(port).offset_at(16))
    fail("Cannot set error callback for tx buffer on port %u\n", port) if ret < 0

    # Start device
    rte_eth_dev_start(port)

    STDOUT << "done: \n"

    rte_eth_promiscuous_enable(port)

    printf("Port %u, MAC address: %s\n\n", port, mac_to_s(@l2fwd_ports_eth_addr[port].addr_bytes.to_unsafe))
  end

  def main(argc, argv)
    ARGV.shift rte_eal_init(argc, argv)
    parse_args

    signal(SIGINT, signal_handler)
    signal(SIGTERM, signal_handler)

    printf("MAC updating %s\n", @mac_updating ? "enabled" : "disabled")

    # convert to number of cycles
    @timer_period *= rte_get_timer_hz

    nb_ports = rte_eth_dev_count
    fail("No Ethernet ports - bye\n") if nb_ports == 0

    # reset l2fwd_dst_ports
    pointerof(@l2fwd_dst_ports).clear

    nb_ports_in_mask = last_port = 0_u32

    # Each logical core is assigned a dedicated TX queue on each port.
    nb_ports.to_u32.times do |port|
      # skip ports that are not enabled
      next if (@portmask & (1 << port)) == 0

      if nb_ports_in_mask.odd?
        @l2fwd_dst_ports[port] = last_port
        @l2fwd_dst_ports[last_port] = port
      else
        last_port = port
      end

      nb_ports_in_mask += 1
    end
    if nb_ports_in_mask.odd?
      printf("Notice: odd number of ports in portmask.\n")
      @l2fwd_dst_ports[last_port] = last_port
    end

    rx_lcore_id = nb_lcores = 0_u32
    qconf = Pointer(LibL2fwd::LcoreQueueConf).new(0)
    pointerof(@lcore_queue_conf).clear

    # Initialize the port/queue configuration of each logical core
    nb_ports.times do |port|
      # skip ports that are not enabled
      next if (@portmask & (1 << port)) == 0

      # get the lcore_id for this port
      while !rte_lcore_is_enabled(rx_lcore_id) ||
            @lcore_queue_conf[rx_lcore_id].n_rx_port == @l2fwd_rx_queue_per_lcore
        rx_lcore_id += 1
        fail("Not enough cores\n") if rx_lcore_id >= RTE_MAX_LCORE
      end

      # Assigned a new logical core in the loop above.
      while qconf != @lcore_queue_conf.pointer_at(rx_lcore_id)
        qconf = @lcore_queue_conf.pointer_at(rx_lcore_id)
        nb_lcores += 1
      end
      n_rx_port_ptr = qconf.as(UInt32*)
      rx_port_list_ptr = qconf.offset_at(4).as(UInt32*)

      rx_port_list_ptr[n_rx_port_ptr.value] = port.to_u32
      n_rx_port_ptr.value += 1
      printf("Lcore %u: RX port %u\n", rx_lcore_id, port)
    end

    nb_ports_available = nb_ports

    nb_mbufs = rte_max(nb_ports * (@nb_rxd + @nb_txd + MAX_PKT_BURST + nb_lcores * MEMPOOL_CACHE_SIZE), 8192_u32)

    @mbuf_pool = pool_create(nb_mbufs, MEMPOOL_CACHE_SIZE)

    # Initialise each port
    nb_ports.times do |port|
      # skip ports that are not enabled
      if (@portmask & (1 << port)) == 0
        printf("Skipping disabled port %u\n", port)
        nb_ports_available -= 1
        next
      end

      port_init(port)
    end

    fail("All available ports are disabled. Please set portmask.\n") if nb_ports_available.zero?

    check_all_ports_link_status(nb_ports, @portmask)

    # launch per-lcore init on every lcore
    rte_eal_mp_remote_launch(l2fwd_main_loop)
    rte_lcore_foreach_slave do |lcore_id|
      return if rte_eal_wait_lcore(lcore_id) < 0
    end

    nb_ports.times do |port|
      next if (@portmask & (1 << port)) == 0
      printf("Closing port %d...", port)
      rte_eth_dev_stop(port)
      rte_eth_dev_close(port)
      printf(" Done\n")
    end
    printf("Bye...\n")
  end
end

L2fwd.run

# # Run the program
# # sudo build/l2fwd -l 0 -n 4 -- -q 8 -p 3 -T 1
# # sudo build/l2fwd -l 1 -n 4 -- -q 8 -p 3 -T 1
