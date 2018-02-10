require "../src/dpdk"

class RxtxCallbacks < Dpdk
  RX_RING_SIZE    = 1024_u16
  TX_RING_SIZE    = 1024_u16
  NUM_MBUFS       = 8191_u32
  MBUF_CACHE_SIZE = 250_u32
  BURST_SIZE      = 32_u16

  @bufs = uninitialized LibDpdk::RteMbuf*[BURST_SIZE]
  @port_conf = uninitialized LibDpdk::RteEthConf
  @mbuf_pool = Pointer(LibDpdk::RteMempool).new(0)
  @total_cycles = 0_u64
  @total_pkts = 0_u64

  def add_timestamps(pkts : LibDpdk::RteMbuf**, nb_pkts : UInt16)
    now = rte_rdtsc
    nb_pkts.times do |i|
      # pkts[i].udata64 = now
      pkts[i].offset_at(64).as(UInt64*).value = now
    end
    nb_pkts
  end

  def calc_latency(pkts : LibDpdk::RteMbuf**, nb_pkts : UInt16)
    cycles = 0_u64
    now = rte_rdtsc

    nb_pkts.times do |i|
      cycles += now - pkts[i].value.userdata
    end
    @total_cycles += cycles
    @total_pkts += nb_pkts

    if @total_pkts > 100_000_u64
      printf("Latency = %lu cycles, pkts: %lu\n", @total_cycles / @total_pkts, @total_pkts)
      @total_cycles = @total_pkts = 0_u64
    end
    nb_pkts
  end

  def port_init(port)
    rx_rings = tx_rings = 1_u16
    nb_rxd = RX_RING_SIZE
    nb_txd = TX_RING_SIZE

    fail("Not enough ports: %hu\n", port) if port >= rte_eth_dev_count

    @port_conf.rxmode.max_rx_pkt_len = ETHER_MAX_LEN
    @port_conf.rxmode.flags = LibDpdk::RteEthRxmodeFlags::IgnoreOffloadBitfield

    dev_info = rte_eth_dev_info_get(port)
    txconf_ptr = configure_tx_offload(@port_conf, dev_info)

    # Configure the Ethernet device.
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

    rte_eth_add_rx_callback(port, 0, ->(port : LibDpdk::PortT, qidx : UInt16, pkts : LibDpdk::RteMbuf**, nb_pkts : UInt16, max_pkts : UInt16, _1 : Void*) {
      RxtxCallbacks.instance.add_timestamps(pkts, nb_pkts)
    }, nil)
    rte_eth_add_tx_callback(port, 0, ->(port : LibDpdk::PortT, qidx : UInt16, pkts : LibDpdk::RteMbuf**, nb_pkts : UInt16, _1 : Void*) {
      RxtxCallbacks.instance.calc_latency(pkts, nb_pkts)
    }, nil)
  end

  def lcore_main
    nb_ports = rte_eth_dev_count

    # Check that the port is on the same NUMA node as the polling thread
    # for best performance.
    nb_ports.times do |port|
      if rte_eth_dev_socket_id(port) > 0 && rte_eth_dev_socket_id(port) != rte_socket_id
        printf("WARNING, port %u is on remote NUMA node to polling thread.
\tPerformance will not be optimal.\n", port)
      end
    end

    printf("\nCore %u forwarding packets. [Ctrl+C to quit]\n", rte_lcore_id)

    # Run until the application is quit or killed.
    while true
      # Receive packets on a port and forward them on the paired
      # port. The mapping is 0 -> 1, 1 -> 0, 2 -> 3, 3 -> 2, etc.
      nb_ports.times do |port|
        # Get burst of RX packets, from first port of pair.
        nb_rx = rte_eth_rx_burst(port, 0_u16, @bufs.to_unsafe, BURST_SIZE)

        next if unlikely(nb_rx == 0)

        # Send burst of TX packets, to second port of pair.
        nb_tx = rte_eth_tx_burst(port ^ 1, 0_u16, @bufs.to_unsafe, nb_rx)

        # Free any unsent packets.
        if unlikely(nb_tx < nb_rx)
          printf("Free any unsent packets: rx: %hu, tx: %hu\n", nb_rx, nb_tx)
          (nb_tx...nb_rx).each do |buf|
            rte_pktmbuf_free(@bufs[buf])
          end
        end
      end
    end
  end

  # Main function, does initialisation and calls the per-lcore functions
  def main(argc, argv)
    # Initialize the Environment Abstraction Layer (EAL).
    rte_eal_init(argc, argv)

    # Check that there is an even number of ports to send/receive on.
    nb_ports = rte_eth_dev_count
    fail("Error: number of ports must be even\n") if nb_ports < 2 || nb_ports.odd?

    # Creates a new mempool in memory to hold the mbufs.
    @mbuf_pool = pool_create(NUM_MBUFS * nb_ports, MBUF_CACHE_SIZE)

    # Initialize all ports.
    nb_ports.times do |port|
      port_init(port)
    end

    printf("\nWARNING: Too many lcores enabled. Only 1 used.\n") if rte_lcore_count > 1

    # Call lcore_main on the master core only.
    lcore_main
  end
end

RxtxCallbacks.run

## Run the program
## sudo build/rxtx_callbacks -l 1 -n 4
