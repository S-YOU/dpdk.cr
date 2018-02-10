require "../src/dpdk_minimal"
require "../src/lib_dpdk/lib_rte_distributor_private"
require "../src/lib_dpdk/lib_rte_distributor"
require "../src/dpdk/arg_parse"

lib LibDistributor
  struct Rx
    rx_pkts : UInt64
    returned_pkts : UInt64
    enqueued_pkts : UInt64
    enqdrop_pkts : UInt64
    __padding : UInt64[4]
  end

  struct Dist
    in_pkts : UInt64
    ret_pkts : UInt64
    sent_pkts : UInt64
    enqdrop_pkts : UInt64
    __padding : UInt64[4]
  end

  struct Tx
    dequeue_pkts : UInt64
    tx_pkts : UInt64
    enqdrop_pkts : UInt64
    __padding : UInt64[4]
  end

  struct AppStats
    rx : Rx
    dist : Dist
    tx : Tx
    pad1 : UInt64[8]

    worker_pkts : UInt64[64]
    worker_bursts : UInt64[64][8]
    port_rx_pkts : UInt64[64]
    port_tx_pkts : UInt64[64]
  end

  struct OutputBuffer
    count : UInt32
    mbufs : LibDpdk::RteMbuf*[64]
  end
end

class Distributor < Dpdk
  alias RteDistributor = LibDpdk::RteDistributor

  RX_RING_SIZE = 1024_u16
  TX_RING_SIZE = 1024_u16

  BURST_SIZE      =  64_u32
  BURST_SIZE_RX   = 128_u32
  BURST_SIZE_DIST = 256_u32
  BURST_SIZE_TX   =  32_u32
  NUM_MBUFS       =    8192

  SCHED_RX_RING_SZ =  8192
  SCHED_TX_RING_SZ = 65536

  RTE_LOGTYPE_DISTRAPP = RTE_LOGTYPE_USER1

  ANSI_COLOR_RED   = "\x1b[31m"
  ANSI_COLOR_RESET = "\x1b[0m"

  @port_conf = uninitialized RteEthConf

  @portmask = 0_u32
  @quit_signal = false
  @quit_signal_rx = false
  @quit_signal_dist = false
  @quit_signal_work = false
  @app_stats = uninitialized LibDistributor::AppStats
  @prev_app_stats = uninitialized LibDistributor::AppStats

  @mbuf_pool = Pointer(RteMempool).new(0)
  @dist_params = Pointer(RteDistributor).new(0)
  @dist_tx_ring = Pointer(RteRing).new(0)
  @rx_dist_ring = Pointer(RteRing).new(0)

  def print_usage
    printf("
%s [EAL options] -- -p PORTMASK
  -p PORTMASK: hexadecimal bitmask of ports to configure
", ARGV_UNSAFE[0])
  end

  def parse_args(argc, argv)
    ArgParse.parse(argc, argv) do |opts|
      opts.on("-p PORTMASK", "hexadecimal bitmask of ports to configure") do |portmask|
        @portmask = portmask.sub("0x", "").to_u32(base: 16)
      end
      opts.invalid_option do |arg|
        print_usage
        fail("Invalid arguments: %s\n", arg)
      end
    end
  end

  def port_init(port)
    rx_rings = 1_u16
    tx_rings = 1_u16 # rte_lcore_count - 1 # fail on VBox
    nb_rxd, nb_txd = RX_RING_SIZE, TX_RING_SIZE

    @port_conf.rxmode.max_rx_pkt_len = ETHER_MAX_LEN
    @port_conf.rxmode.mq_mode = RteEthRxMqMode::EthMqRxRss
    @port_conf.rxmode.flags = RteEthRxmodeFlags::IgnoreOffloadBitfield
    @port_conf.rx_adv_conf.rss_conf.rss_hf = ETH_RSS_IP | ETH_RSS_UDP | ETH_RSS_TCP | ETH_RSS_SCTP

    fail("Not enough ports: %hu\n", port) if port >= rte_eth_dev_count

    dev_info = uninitialized RteEthDevInfo
    LibDpdk.rte_eth_dev_info_get(port, pointerof(dev_info))
    txconf_ptr = configure_tx_offload(@port_conf, dev_info)

    rte_eth_dev_configure(port, rx_rings, tx_rings, pointerof(@port_conf))

    rte_eth_dev_adjust_nb_rx_tx_desc(port, pointerof(nb_rxd), pointerof(nb_txd))

    rx_rings.times do |q|
      rte_eth_rx_queue_setup(port, q, nb_rxd, rte_eth_dev_socket_id(port), nil, @mbuf_pool)
    end

    tx_rings.times do |q|
      rte_eth_tx_queue_setup(port, q, nb_txd, rte_eth_dev_socket_id(port), txconf_ptr)
    end

    rte_eth_dev_start(port)

    link = uninitialized RteEthLink
    rte_eth_link_get_nowait(port, pointerof(link))
    while link.link_flags.none?
      printf("Waiting for Link up on port %hu\n", port)
      usleep 1_000_000
      rte_eth_link_get_nowait(port, pointerof(link))
    end

    printf("Port %hu MAC: ", port)
    print_macaddr(port)
    puts("")

    rte_eth_promiscuous_enable(port)
  end

  def print_stats
    eth_stats = uninitialized RteEthStats
    nb_ports = rte_eth_dev_count
    num_workers = rte_lcore_count - 4

    nb_ports.times do |i|
      rte_eth_stats_get(i, pointerof(eth_stats))
      @app_stats.port_rx_pkts[i] = eth_stats.ipackets
      @app_stats.port_tx_pkts[i] = eth_stats.opackets
    end

    printf("\n\nRX Thread:\n")
    nb_ports.times do |i|
      printf("Port %u Pktsin : %5.2f\n", i,
        (@app_stats.port_rx_pkts[i] -
         @prev_app_stats.port_rx_pkts[i])/1000000.0)
      @prev_app_stats.port_rx_pkts[i] = @app_stats.port_rx_pkts[i]
    end

    printf(" - Received:    %5.2f\n",
      (@app_stats.rx.rx_pkts -
       @prev_app_stats.rx.rx_pkts)/1000000.0)
    printf(" - Returned:    %5.2f\n",
      (@app_stats.rx.returned_pkts -
       @prev_app_stats.rx.returned_pkts)/1000000.0)
    printf(" - Enqueued:    %5.2f\n",
      (@app_stats.rx.enqueued_pkts -
       @prev_app_stats.rx.enqueued_pkts)/1000000.0)
    printf(" - Dropped:     %s%5.2f%s\n", ANSI_COLOR_RED,
      (@app_stats.rx.enqdrop_pkts -
       @prev_app_stats.rx.enqdrop_pkts)/1000000.0,
      ANSI_COLOR_RESET)

    printf("Distributor thread:\n")
    printf(" - In:          %5.2f\n",
      (@app_stats.dist.in_pkts -
       @prev_app_stats.dist.in_pkts)/1000000.0)
    printf(" - Returned:    %5.2f\n",
      (@app_stats.dist.ret_pkts -
       @prev_app_stats.dist.ret_pkts)/1000000.0)
    printf(" - Sent:        %5.2f\n",
      (@app_stats.dist.sent_pkts -
       @prev_app_stats.dist.sent_pkts)/1000000.0)
    printf(" - Dropped      %s%5.2f%s\n", ANSI_COLOR_RED,
      (@app_stats.dist.enqdrop_pkts -
       @prev_app_stats.dist.enqdrop_pkts)/1000000.0,
      ANSI_COLOR_RESET)

    printf("TX thread:\n")
    printf(" - Dequeued:    %5.2f\n",
      (@app_stats.tx.dequeue_pkts -
       @prev_app_stats.tx.dequeue_pkts)/1000000.0)
    nb_ports.times do |i|
      printf("Port %u Pktsout: %5.2f\n",
        i, (@app_stats.port_tx_pkts[i] -
            @prev_app_stats.port_tx_pkts[i])/1000000.0)
      @prev_app_stats.port_tx_pkts[i] = @app_stats.port_tx_pkts[i]
    end
    printf(" - Transmitted: %5.2f\n",
      (@app_stats.tx.tx_pkts -
       @prev_app_stats.tx.tx_pkts)/1000000.0)
    printf(" - Dropped:     %s%5.2f%s\n", ANSI_COLOR_RED,
      (@app_stats.tx.enqdrop_pkts -
       @prev_app_stats.tx.enqdrop_pkts)/1000000.0,
      ANSI_COLOR_RESET)

    @prev_app_stats.rx.rx_pkts = @app_stats.rx.rx_pkts
    @prev_app_stats.rx.returned_pkts = @app_stats.rx.returned_pkts
    @prev_app_stats.rx.enqueued_pkts = @app_stats.rx.enqueued_pkts
    @prev_app_stats.rx.enqdrop_pkts = @app_stats.rx.enqdrop_pkts
    @prev_app_stats.dist.in_pkts = @app_stats.dist.in_pkts
    @prev_app_stats.dist.ret_pkts = @app_stats.dist.ret_pkts
    @prev_app_stats.dist.sent_pkts = @app_stats.dist.sent_pkts
    @prev_app_stats.dist.enqdrop_pkts = @app_stats.dist.enqdrop_pkts
    @prev_app_stats.tx.dequeue_pkts = @app_stats.tx.dequeue_pkts
    @prev_app_stats.tx.tx_pkts = @app_stats.tx.tx_pkts
    @prev_app_stats.tx.enqdrop_pkts = @app_stats.tx.enqdrop_pkts

    num_workers.times do |i|
      printf("Worker %02u Pkts: %5.2f. Bursts(1-8): ", i,
        (@app_stats.worker_pkts[i] -
         @prev_app_stats.worker_pkts[i])/1000000.0)
      8.times do |j|
        printf("%lu ", @app_stats.worker_bursts[i][j])
        @app_stats.worker_bursts[i][j] = 0_u64
      end
      printf("\n")
      @prev_app_stats.worker_pkts[i] = @app_stats.worker_pkts[i]
    end
  end

  def signal_handler(signum)
    printf("Exiting on signal %d\n", signum)
    @quit_signal_dist = true
  end

  def lcore_rx(arg_ptr : Void*)
    nb_ports = rte_eth_dev_count
    socket_id = rte_socket_id
    bufs = uninitialized_ptr RteMbuf*[BURST_SIZE_RX]

    nb_ports.times do |port|
      next if (@portmask & (1 << port)) == 0

      if rte_eth_dev_socket_id(port) > 0 && rte_eth_dev_socket_id(port) != socket_id
        printf("WARNING, port %u is on remote NUMA node to RX thread.
    Performance will not be optimal.\n", port)
      end
    end

    printf("\nCore %u doing packet RX.\n", rte_lcore_id)
    port = 0
    until @quit_signal_rx
      if (@portmask & (1 << port)) == 0
        port += 1
        port = 0 if port == nb_ports
        next
      end
      nb_rx = rte_eth_rx_burst(port, 0_u16, bufs, BURST_SIZE)
      if unlikely(nb_rx == 0)
        port += 1
        port = 0 if port == nb_ports
        next
      end
      pointerof(@app_stats.@rx.@rx_pkts).value += nb_rx

      ###

      nb_ret = nb_rx
      # Swap the following two lines if you want the rx traffic
      # to go directly to tx, no distribution.
      out_ring = @rx_dist_ring

      sent = rte_ring_enqueue_burst(out_ring, bufs, nb_ret, NULL)
      pointerof(@app_stats.@rx.@enqueued_pkts).value += sent
      if unlikely(sent < nb_ret)
        @app_stats.rx.enqdrop_pkts += nb_ret - sent
        rte_log(DEBUG, DISTRAPP, "lcore_rx:Packet loss due to full ring\n")
        while sent < nb_ret
          rte_pktmbuf_free(bufs[sent])
          sent += 1
        end
      end
      port += 1
      port = 0 if port == nb_ports
    end
    # set worker & tx threads quit flag
    printf("\nCore %u exiting rx task.\n", rte_lcore_id)
    @quit_signal = true
  end

  def flush_one_port(outbuf, outp)
    nb_tx = rte_eth_tx_burst(outp, 0_u16, outbuf.value.mbufs, outbuf.value.count)
    pointerof(@app_stats.@tx.@tx_pkts).value += outbuf.value.count

    if unlikely(nb_tx < outbuf.value.count)
      pointerof(@app_stats.@tx.@enqdrop_pkts).value += outbuf.value.count - nb_tx
      while nb_tx < outbuf.value.count
        rte_pktmbuf_free(outbuf.value.mbufs[nb_tx])
        nb_tx += 1
      end
    end
    outbuf.value.count = 0
  end

  def flush_all_ports(tx_buffers, nb_ports)
    nb_ports.times do |outp|
      # skip ports that are not enabled
      next if (@portmask & (1 << outp)) == 0

      next if tx_buffers[outp].count == 0

      flush_one_port(tx_buffers + outp, outp)
    end
  end

  def lcore_distributor(arg_ptr : Void*)
    in_r = @rx_dist_ring
    out_r = @dist_tx_ring
    d = @dist_params
    bufs = uninitialized_ptr RteMbuf*[BURST_SIZE_DIST]

    printf("\nCore %u acting as distributor core.\n", rte_lcore_id)
    until @quit_signal_dist
      nb_rx = rte_ring_dequeue_burst(in_r, bufs, BURST_SIZE*1, NULL)
      if nb_rx > 0
        pointerof(@app_stats.@dist.@in_pkts).value += nb_rx

        # Distribute the packets
        rte_distributor_process(d, bufs, nb_rx)
        # Handle Returns
        nb_ret = rte_distributor_returned_pkts(d, bufs, BURST_SIZE*2)

        next if (unlikely(nb_ret == 0))
        @app_stats.dist.ret_pkts += nb_ret

        sent = rte_ring_enqueue_burst(out_r, bufs, nb_ret, NULL)
        @app_stats.dist.sent_pkts += sent

        if unlikely(sent < nb_ret)
          @app_stats.dist.enqdrop_pkts += nb_ret - sent
          rte_log(DEBUG, DISTRAPP, "lcore_distributor:Packet loss due to full out ring\n")
          while sent < nb_ret
            rte_pktmbuf_free(bufs[sent])
            sent += 1
          end
        end
      end
    end
    printf("\nCore %u exiting distributor task.\n", rte_lcore_id)
    @quit_signal_work = 1

    rte_distributor_flush(d)
    # Unblock any returns so workers can exit
    rte_distributor_clear_returns(d)
    @quit_signal_rx = 1
  end

  def lcore_tx(arg_ptr : Void*)
    in_r = arg_ptr.as(RteRing*)
    tx_buffers = uninitialized_ptr LibDistributor::OutputBuffer[RTE_MAX_ETHPORTS]
    nb_ports = rte_eth_dev_count
    socket_id = rte_socket_id

    nb_ports.times do |port|
      # skip ports that are not enabled
      next if (@portmask & (1 << port)) == 0

      if rte_eth_dev_socket_id(port) > 0 && rte_eth_dev_socket_id(port) != socket_id
        printf("WARNING, port %u is on remote NUMA node to TX thread.
    Performance will not be optimal.\n", port)
      end
    end

    bufs = uninitialized_ptr RteMbuf*[BURST_SIZE_TX]
    printf("\nCore %u doing packet TX.\n", rte_lcore_id)
    until @quit_signal
      nb_ports.times do |port|
        # skip ports that are not enabled
        next if (@portmask & (1 << port)) == 0

        nb_rx = rte_ring_dequeue_burst(in_r, bufs, BURST_SIZE_TX, NULL)
        pointerof(@app_stats.@tx.@dequeue_pkts).value += nb_rx

        # if we get no traffic, flush anything we have
        if unlikely(nb_rx == 0)
          flush_all_ports(tx_buffers, nb_ports)
          next
        end

        # for traffic we receive, queue it up for transmit
        rte_prefetch_non_temporal(bufs[0])
        rte_prefetch_non_temporal(bufs[1])
        rte_prefetch_non_temporal(bufs[2])
        nb_rx.times do |i|
          rte_prefetch_non_temporal(bufs[i + 3])
          # workers should update in_port to hold the
          # output port value
          outp = bufs[i].value.port
          # skip ports that are not enabled
          next if (@portmask & (1 << outp)) == 0

          outbuf = tx_buffers + outp
          outbuf.value.mbufs[outbuf.value.count] = bufs[i]
          outbuf.value.count = outbuf.value.count + 1
          if outbuf.value.count == BURST_SIZE_TX
            flush_one_port(outbuf, outp)
          end
        end
      end
    end
    printf("\nCore %u exiting tx task.\n", rte_lcore_id)
  end

  def lcore_worker(arg_ptr : Void*)
    buf = uninitialized_ptr RteMbuf*[8]
    d = @dist_params
    worker_id = arg_ptr.unsafe_as(UInt64)
    num = 0_u32

    # for single port, xor_val will be zero so we won't modify the output
    # port, otherwise we send traffic from 0 to 1, 2 to 3, and vice versa
    xor_val = rte_eth_dev_count > 1 ? 1 : 0

    worker_pkts_ptr = @app_stats.worker_pkts.pointer_at(worker_id)
    worker_bursts_ptr = @app_stats.worker_bursts.pointer_at(worker_id)

    worker_pkts_ptr.value = 1_u64

    printf("\nCore %u acting as worker core.\n", rte_lcore_id)
    until @quit_signal_work
      num = rte_distributor_get_pkt(d, worker_id, buf, buf, num)
      # Do a little bit of work for each packet
      num.times do |i|
        t = rte_rdtsc + 100

        while rte_rdtsc < t
          rte_pause
        end
        buf[i].value.port = buf[i].value.port ^ xor_val
      end

      worker_pkts_ptr.value += num
      if num > 0
        worker_bursts_ptr.value.pointer_at(num - 1).value += 1
      end
    end
  end

  def main(argc, argv)
    # catch ctrl-c so we can print on exit
    signal(SIGINT, signal_handler)

    # Initialize EAL
    ret = rte_eal_init(argc, argv)
    argc -= ret + 1
    argv += ret + 1

    worker_id, lcore_count = 0, rte_lcore_count

    # Parse the application  arguments
    parse_args argc, argv

    # Check if we have enought cores
    if lcore_count < 5
      fail("Error, This application needs at
least 5 logical cores to run:
1 lcore for stats (can be core 0)
1 lcore for packet RX
1 lcore for distribution
1 lcore for packet TX
and at least 1 lcore for worker threads
")
    end

    nb_ports = rte_eth_dev_count
    fail("Error: no ethernet ports detected\n") if nb_ports == 0
    fail("Error: number of ports must be even, except when using a single port\n") if nb_ports != 1 && nb_ports.odd?

    @mbuf_pool = pool_create(NUM_MBUFS * nb_ports, RTE_MEMPOOL_CACHE_MAX_SIZE)

    nb_ports_available = nb_ports

    # initialize all ports
    nb_ports.times do |port|
      # skip ports that are not enabled
      if (@portmask & (1 << port)) == 0
        printf("\nSkipping disabled port %d\n", port)
        nb_ports_available -= 1
        next
      end
      # init port
      printf("Initializing port %u... done\n", port)

      port_init(port)
    end

    fail("All available ports are disabled. Please set portmask.\n") if nb_ports_available.zero?

    @dist_params = distributor_create(lcore_count - 4)

    # scheduler ring is read by the transmitter core, and written to by scheduler core
    @dist_tx_ring = rte_ring_create("Output_ring", SCHED_RX_RING_SZ, rte_socket_id, RING_F_SC_DEQ | RING_F_SP_ENQ)
    @rx_dist_ring = rte_ring_create("Input_ring", SCHED_TX_RING_SZ, rte_socket_id, RING_F_SC_DEQ | RING_F_SP_ENQ)

    rte_lcore_foreach_slave do |lcore_id|
      if worker_id == lcore_count - 3
        printf("Starting distributor on lcore_id %d\n", lcore_id)
        rte_eal_remote_launch(lcore_distributor, Pointer(Void).new(worker_id), lcore_id)
      elsif worker_id == lcore_count - 4
        printf("Starting tx  on worker_id %d, lcore_id %d\n", worker_id, lcore_id)
        rte_eal_remote_launch(lcore_tx, @dist_tx_ring.as(Void*), lcore_id)
      elsif worker_id == lcore_count - 2
        printf("Starting rx on worker_id %d, lcore_id %d\n", worker_id, lcore_id)
        rte_eal_remote_launch(lcore_rx, Pointer(Void).new(worker_id), lcore_id)
      else
        printf("Starting worker on worker_id %d, lcore_id %d\n", worker_id, lcore_id)
        rte_eal_remote_launch(lcore_worker, Pointer(Void).new(worker_id), lcore_id)
      end

      worker_id += 1
    end

    freq = rte_get_timer_hz
    t = rte_rdtsc + freq
    until @quit_signal_dist
      if t < rte_rdtsc
        print_stats
        t = rte_rdtsc + freq
      end
      usleep(1000)
    end

    rte_lcore_foreach_slave do |lcore_id|
      return if rte_eal_wait_lcore(lcore_id) < 0
    end

    print_stats
  end
end

Distributor.run

# # Run the program
# # sudo build/distributor -l 0-7 -n 4 -- -p 3
# # sudo build/distributor -l 1,3,5,7,9 -n 4 -- -p 3
# # sudo build/distributor -l 1,3,5,7,9,11 -n 4 -- -p 3
