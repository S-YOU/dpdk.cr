require "option_parser"
require "../src/dpdk"

lib LibPacketOrdering
  struct WorkerThreadArgs
    ring_in : LibDpdk::RteRing*
    ring_out : LibDpdk::RteRing*
  end

  struct SendThreadArgs
    ring_in : LibDpdk::RteRing*
    buffer : LibDpdk::RteReorderBuffer*
  end

  struct Rx
    rx_pkts : UInt64
    enqueue_pkts : UInt64
    enqueue_failed_pkts : UInt64
    __padding : LibC::Char[40]
  end

  struct Wkr
    dequeue_pkts : UInt64
    enqueue_pkts : UInt64
    enqueue_failed_pkts : UInt64
    __padding : LibC::Char[40]
  end

  struct Tx
    dequeue_pkts : UInt64
    # Too early pkts transmitted directly w/o reordering
    early_pkts_txtd_woro : UInt64
    # Too early pkts failed from direct transmit
    early_pkts_tx_failed_woro : UInt64
    ro_tx_pkts : UInt64
    ro_tx_failed_pkts : UInt64
    __padding : LibC::Char[24]
  end

  struct AppStats
    rx : Rx
    wkr : Wkr
    tx : Tx
  end
end

class PacketOrdering < Dpdk
  RX_DESC_PER_QUEUE = 1024_u16
  TX_DESC_PER_QUEUE = 1024_u16

  MAX_PKTS_BURST       =    32_u32
  REORDER_BUFFER_SIZE  =  8192_u32
  MBUF_PER_POOL        = 65535_u32
  MBUF_POOL_CACHE_SIZE =   250_u32

  RING_SIZE = 16384_u32

  # Macros for printing using RTE_LOG
  RTE_LOGTYPE_REORDERAPP = RTE_LOGTYPE_USER1

  alias WorkerThreadArgs = LibPacketOrdering::WorkerThreadArgs
  alias SendThreadArgs = LibPacketOrdering::SendThreadArgs

  @mbuf_pool = Pointer(RteMempool).new(0)
  @port_conf = uninitialized RteEthConf

  @portmask = 0_u32
  @disable_reorder = false
  @quit_signal = false
  @app_stats = uninitialized LibPacketOrdering::AppStats

  def get_last_lcore_id : UInt32
    (RTE_MAX_LCORE.to_u32 - 1_u32).downto(0_u32) do |i|
      return i if rte_lcore_is_enabled(i)
    end
    0_u32
  end

  def get_previous_lcore_id(id : UInt32) : UInt32
    (id - 1_u32).downto(0_u32) do |i|
      return i.to_u32 if rte_lcore_is_enabled(i)
    end
    id
  end

  macro pktmbuf_free_bulk(mbuf_table, n)
    mbuf_table_offset = {{mbuf_table}}
    ({{n}}).times do |i|
      rte_pktmbuf_free(mbuf_table_offset[i])
    end
  end

  def print_usage
    printf("
%s [EAL options] -- -p PORTMASK
  -p PORTMASK: hexadecimal bitmask of ports to configure
", PROGRAM_NAME)
  end

  def parse_args
    OptionParser.parse! do |opts|
      opts.on("-p PORTMASK", "hexadecimal bitmask of ports to configure") do |portmask|
        @portmask = portmask.sub("0x", "").to_u32(base: 16)
      end
      opts.on("--disable-reorder", "Disable reordering") do
        printf("reorder disabled\n")
        @disable_reorder = true
      end
      opts.invalid_option do |arg|
        print_usage
        fail("Invalid arguments: %s\n", arg)
      end
    end
  end

  # Tx buffer error callback
  def flush_tx_error_callback(unsent : RteMbuf**, count : UInt16, _userdata : Void*)
    # free the mbufs which failed from transmit
    pointerof(@app_stats.@tx.@ro_tx_failed_pkts).value += count
    # log_dp(DEBUG, REORDERAPP, "flush_tx_error_callback:Packet loss with tx_burst\n")
    pktmbuf_free_bulk(unsent, count)
  end

  def free_tx_buffers(tx_buffer : RteEthDevTxBuffer**)
    nb_ports = rte_eth_dev_count
    # initialize buffers for all ports
    nb_ports.times do |port_id|
      next if (@portmask & (1 << port_id)) == 0
      rte_free(tx_buffer[port_id])
    end
  end

  def configure_tx_buffers(tx_buffer : RteEthDevTxBuffer**)
    nb_ports = rte_eth_dev_count
    nb_ports.times do |port_id|
      next if (@portmask & (1 << port_id)) == 0

      # Initialize TX buffers
      tx_buffer[port_id] = rte_zmalloc_socket("tx_buffer", rte_eth_tx_buffer_size(MAX_PKTS_BURST), 0, rte_eth_dev_socket_id(port_id)).as(RteEthDevTxBuffer*)

      rte_eth_tx_buffer_init(tx_buffer[port_id], MAX_PKTS_BURST)

      ret = rte_eth_tx_buffer_set_err_callback(tx_buffer[port_id], ->(unsent : RteMbuf**, count : UInt16, userdata : Void*) {
        PacketOrdering.instance.flush_tx_error_callback(unsent, count, userdata)
      }, nil)
      fail("Cannot set error callback for tx buffer on port %u\n", port_id) if ret < 0
    end
  end

  def port_init(port) : Void
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
      rte_eth_rx_queue_setup(port, q, nb_rxd, rte_eth_dev_socket_id(port), nil, @mbuf_pool)
    end

    # Allocate and set up 1 TX queue per Ethernet port.
    tx_rings.times do |q|
      rte_eth_tx_queue_setup(port, q, nb_txd, rte_eth_dev_socket_id(port), txconf_ptr)
    end

    # Start the Ethernet port.
    rte_eth_dev_start(port)

    # Display the port MAC address.
    printf("Port %u MAC: %s\n", port, macaddr_get(port))

    # Enable RX in promiscuous mode for the Ethernet device.
    rte_eth_promiscuous_enable(port)
  end

  def print_stats
    eth_stats = uninitialized RteEthStats
    nb_ports = rte_eth_dev_count

    printf("\nRX thread stats:\n")
    printf(" - Pkts rxd:				%lu\n",
      @app_stats.rx.rx_pkts)
    printf(" - Pkts enqd to workers ring:		%lu\n",
      @app_stats.rx.enqueue_pkts)
    printf(" - Pkts enq to workers failed:		%lu\n",
      @app_stats.rx.enqueue_failed_pkts)

    printf("\nWorker thread stats:\n")
    printf(" - Pkts deqd from workers ring:		%lu\n",
      @app_stats.wkr.dequeue_pkts)
    printf(" - Pkts enqd to tx ring:		%lu\n",
      @app_stats.wkr.enqueue_pkts)
    printf(" - Pkts enq to tx failed:		%lu\n",
      @app_stats.wkr.enqueue_failed_pkts)

    printf("\nTX stats:\n")
    printf(" - Pkts deqd from tx ring:		%lu\n",
      @app_stats.tx.dequeue_pkts)
    printf(" - Ro Pkts transmitted:			%lu\n",
      @app_stats.tx.ro_tx_pkts)
    printf(" - Ro Pkts tx failed:			%lu\n",
      @app_stats.tx.ro_tx_failed_pkts)
    printf(" - Pkts transmitted w/o reorder:	%lu\n",
      @app_stats.tx.early_pkts_txtd_woro)
    printf(" - Pkts tx failed w/o reorder:		%lu\n",
      @app_stats.tx.early_pkts_tx_failed_woro)

    nb_ports.times do |i|
      rte_eth_stats_get(i, pointerof(eth_stats))
      printf("\nPort %u stats:\n", i)
      printf(" - Pkts in:   %lu\n", eth_stats.ipackets)
      printf(" - Pkts out:  %lu\n", eth_stats.opackets)
      printf(" - In Errs:   %lu\n", eth_stats.ierrors)
      printf(" - Out Errs:  %lu\n", eth_stats.oerrors)
      printf(" - Mbuf Errs: %lu\n", eth_stats.rx_nombuf)
    end
  end

  def signal_handler(signum)
    @quit_signal = true
  end

  # This thread receives mbufs from the port and affects them an internal
  # sequence number to keep track of their order of arrival through an
  # mbuf structure.
  # The mbufs are then passed to the worker threads via the rx_to_workers
  # ring.
  def rx_thread(ring_out : RteRing*) : Void
    recv_pkts = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
    nb_ports = rte_eth_dev_count
    seqn = 0_u32

    rte_log(INFO, REORDERAPP, "rx_thread() started on lcore %u\n", rte_lcore_id)

    portmask = @portmask
    rx_pkts_ptr, enqueue_pkts_ptr, enqueue_failed_pkts_ptr = pointerof(@app_stats.@rx.@rx_pkts), pointerof(@app_stats.@rx.@enqueue_pkts), pointerof(@app_stats.@rx.@enqueue_failed_pkts)

    until @quit_signal
      nb_ports.times do |port_id|
        next if (portmask & (1 << port_id)) == 0

        # receive packets
        nb_rx_pkts = rte_eth_rx_burst(port_id, 0_u16, recv_pkts, MAX_PKTS_BURST.to_u16)
        if nb_rx_pkts == 0
          # log_dp(DEBUG, REORDERAPP, "rx_thread():Received zero packets\n")
          next
        end
        rx_pkts_ptr.value += nb_rx_pkts

        # mark sequence number
        nb_rx_pkts.times do |i|
          recv_pkts[i].value.seqn = seqn
          seqn += 1
        end

        # enqueue to rx_to_workers ring
        ret = rte_ring_enqueue_burst(ring_out, recv_pkts.as(Void**), nb_rx_pkts, nil)
        enqueue_pkts_ptr.value += ret if ret > 0
        if unlikely(ret < nb_rx_pkts)
          # printf("enqueue failed: nb_rx_pkts: %hu, ret: %hu\n", nb_rx_pkts, ret)
          enqueue_failed_pkts_ptr.value += nb_rx_pkts - ret if ret > 0
          pktmbuf_free_bulk(recv_pkts + ret, nb_rx_pkts.to_u32 - ret)
        end
      end
    end
  end

  # This thread takes bursts of packets from the rx_to_workers ring and
  # Changes the input port value to output port value. And feds it to
  # workers_to_tx
  def worker_thread(arg_ptr : Void*) : Void
    burst_buffer = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
    nb_ports = rte_eth_dev_count
    burst_size = 0_u16
    xor_val = nb_ports > 1 ? 1_u32 : 0_u32

    args = arg_ptr.as(WorkerThreadArgs*)
    ring_in = args.value.ring_in
    ring_out = args.value.ring_out

    rte_log(INFO, REORDERAPP, "worker_thread() started on lcore %u\n", rte_lcore_id)

    dequeue_pkts = AtomicPointer.new(pointerof(@app_stats.@wkr.@dequeue_pkts))
    enqueue_pkts = AtomicPointer.new(pointerof(@app_stats.@wkr.@enqueue_pkts))
    enqueue_failed_pkts = AtomicPointer.new(pointerof(@app_stats.@wkr.@enqueue_failed_pkts))

    until @quit_signal
      # dequeue the mbufs from rx_to_workers ring
      burst_size = rte_ring_dequeue_burst(ring_in, burst_buffer, MAX_PKTS_BURST, nil)
      next if unlikely(burst_size == 0)

      dequeue_pkts.add(burst_size.to_u64)

      # just do some operation on mbuf
      burst_size.times do |i|
        # burst_buffer[i].port ^= xor_val
        burst_buffer[i].offset_at(22).as(UInt16*).value ^= xor_val
      end

      # enqueue the modified mbufs to workers_to_tx ring
      ret = rte_ring_enqueue_burst(ring_out, burst_buffer, burst_size, nil)
      enqueue_pkts.add(ret.to_u64)

      if unlikely(ret < burst_size)
        # Return the mbufs to their respective pool, dropping packets
        # printf("lcore_id: %u, enqueue failed: burst_size: %hu, ret: %hu\n", lcore_id, burst_size, ret)
        enqueue_failed_pkts.add((burst_size.to_i32 - ret).to_u64)
        pktmbuf_free_bulk(burst_buffer + ret, burst_size - ret)
      end
    end
  end

  # Dequeue mbufs from the workers_to_tx ring and reorder them before
  # transmitting.
  def send_thread(arg_ptr : Void*) : Void
    args = arg_ptr.as(SendThreadArgs*)
    send_mbufs = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
    send_rombufs = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
    send_tx_buffer = uninitialized_ptr RteEthDevTxBuffer*[RTE_MAX_ETHPORTS]

    rte_log(INFO, REORDERAPP, "send_thread() started on lcore %u\n", rte_lcore_id)

    configure_tx_buffers(send_tx_buffer)

    ring_in = args.value.ring_in
    buffer = args.value.buffer

    until @quit_signal
      # deque the send_mbufs from workers_to_tx ring
      nb_dq_mbufs = rte_ring_dequeue_burst(ring_in, send_mbufs.as(Void**), MAX_PKTS_BURST, NULL)
      next if unlikely(nb_dq_mbufs == 0)

      pointerof(@app_stats.@tx.@dequeue_pkts).value += nb_dq_mbufs

      nb_dq_mbufs.times do |i|
        # send dequeued send_mbufs for reordering
        ret = rte_reorder_insert(buffer, send_mbufs[i])

        errno = rte_errno
        if ret == -1 && errno == LibC::ERANGE
          # Too early pkts should be transmitted out directly
          # log_dp(DEBUG, REORDERAPP, "send_thread():Cannot reorder early packet direct enqueuing to TX\n")
          outp = send_mbufs[i].value.port
          if (@portmask & (1 << outp)) == 0
            rte_pktmbuf_free(send_mbufs[i])
            next
          end
          if rte_eth_tx_burst(outp, 0_u16, send_mbufs[i].as(RteMbuf**), 1_u16) != 1_u16
            rte_pktmbuf_free(send_mbufs[i])
            pointerof(@app_stats.@tx.@early_pkts_tx_failed_woro).value += 1
          else
            pointerof(@app_stats.@tx.@early_pkts_txtd_woro).value += 1
          end
        elsif ret == -1 && errno == LibC::ENOSPC
          # printf("rte_errno: %d, ENOSPC: %d\n", rte_errno, LibC::ENOSPC.to_i)
          # Too early pkts should be transmitted out directly
          # Early pkts just outside of window should be dropped
          rte_pktmbuf_free(send_mbufs[i])
        end
      end

      # drain MAX_PKTS_BURST of reordered
      # send_mbufs for transmit
      dret = rte_reorder_drain(buffer, send_rombufs, MAX_PKTS_BURST)
      dret.times do |i|
        outp1 = send_rombufs[i].value.port
        # skip ports that are not enabled
        if (@portmask & (1 << outp1)) == 0
          rte_pktmbuf_free(send_rombufs[i])
          next
        end

        outbuf = send_tx_buffer[outp1]
        sent = rte_eth_tx_buffer(outp1, 0_u16, outbuf, send_rombufs[i])
        pointerof(@app_stats.@tx.@ro_tx_pkts).value += sent if sent > 0
      end
    end

    free_tx_buffers(send_tx_buffer)
  end

  # Dequeue mbufs from the workers_to_tx ring and transmit them
  def tx_thread(arg_ptr : Void*) : Void
    ring_in = arg_ptr.as(RteRing*)
    tx_mbufs = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
    tx_buffer = uninitialized_ptr RteEthDevTxBuffer*[RTE_MAX_ETHPORTS]
    rte_log(INFO, REORDERAPP, "tx_thread() started on lcore %u\n", rte_lcore_id)

    configure_tx_buffers(tx_buffer)

    portmask = @portmask
    dequeue_pkts_ptr, ro_tx_pkts_ptr = pointerof(@app_stats.@tx.@dequeue_pkts), pointerof(@app_stats.@tx.@ro_tx_pkts)

    until @quit_signal
      # deque the tx_mbufs from workers_to_tx ring
      dqnum = rte_ring_dequeue_burst(ring_in, tx_mbufs.as(Void**), MAX_PKTS_BURST, nil)
      next if unlikely(dqnum == 0)

      dequeue_pkts_ptr.value += dqnum

      dqnum.times do |i|
        outp = tx_mbufs[i].value.port
        # skip ports that are not enabled
        if (portmask & (1 << outp)) == 0
          printf("skipping port: %u\n", outp)
          rte_pktmbuf_free(tx_mbufs[i])
          next
        end

        tx_outbuf = tx_buffer[outp]
        sent = rte_eth_tx_buffer(outp, 0_u16, tx_outbuf, tx_mbufs[i])
        ro_tx_pkts_ptr.value += sent if sent > 0
      end
    end
  end

  def main(argc, argv)
    worker_args = uninitialized WorkerThreadArgs
    send_args = uninitialized SendThreadArgs

    # catch ctrl-c so we can print on exit
    signal(SIGINT, signal_handler)

    # Initialize EAL
    ARGV.shift rte_eal_init(argc, argv)

    # Parse the application specific arguments
    parse_args

    # Check if we have enought cores
    if rte_lcore_count < 3
      fail("Error, This application needs at
least 3 logical cores to run:
1 lcore for packet RX
1 lcore for packet TX
and at least 1 lcore for worker threads
")
    end

    nb_ports = rte_eth_dev_count
    fail("Error: no ethernet ports detected\n") if nb_ports == 0
    fail("Error: number of ports must be even, except when using a single port\n") if nb_ports != 1 && nb_ports.odd?

    @mbuf_pool = pool_create(MBUF_PER_POOL, MBUF_POOL_CACHE_SIZE)

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

    # Create rings for inter core communication
    rx_to_workers = rte_ring_create("rx_to_workers", RING_SIZE, rte_socket_id, RING_F_SP_ENQ)
    workers_to_tx = rte_ring_create("workers_to_tx", RING_SIZE, rte_socket_id, RING_F_SC_DEQ)

    unless @disable_reorder
      send_args.buffer = rte_reorder_create("PKT_RO", rte_socket_id, REORDER_BUFFER_SIZE)
      fail("%s\n", rte_strerror(rte_errno)) if send_args.buffer.null?
    end

    last_lcore_id = get_last_lcore_id
    master_lcore_id = rte_get_master_lcore

    worker_args.ring_in = rx_to_workers
    worker_args.ring_out = workers_to_tx

    # Start worker_thread() on all the available slave cores but the last 1
    0.upto(get_previous_lcore_id(last_lcore_id)) do |lcore_id|
      if rte_lcore_is_enabled(lcore_id) && lcore_id != master_lcore_id
        rte_eal_remote_launch(worker_thread, pointerof(worker_args).as(Void*), lcore_id)
      end
    end

    if @disable_reorder
      # Start tx_thread() on the last slave core
      rte_eal_remote_launch(tx_thread, workers_to_tx.as(Void*), last_lcore_id)
    else
      send_args.ring_in = workers_to_tx
      # Start send_thread() on the last slave core
      rte_eal_remote_launch(send_thread, pointerof(send_args).as(Void*), last_lcore_id)
    end

    # Start rx_thread() on the master core
    rx_thread(rx_to_workers)

    rte_lcore_foreach_slave do |lcore_id|
      return if rte_eal_wait_lcore(lcore_id) < 0
    end

    print_stats
  end
end

PacketOrdering.run

# # Run the program
# # sudo build/packet_ordering -l 0-2 -- -p 3 --disable-reorder
# # sudo build/packet_ordering -l 1,3,5 -- -p 3 --disable-reorder
