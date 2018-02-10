require "../src/lib/base"

module IpBlockingMethods
  private macro target_addresses?
    src = pkt.u32(IP_SRC_OFS)
    blocking_ips.any? { |x| x == src }
  end

  private macro process_per_type
    mark_drop_and_next if ipv4? && target_addresses?
  end
end

module ProcessPacketsMethods
  private macro process_each_packets
    each_packet do
      process_per_type
    end
  end
end

module MainMethods
  macro main_loop
    until @quit_signal
      rte_eth_rx_burst!
      process_each_packets
      drop_unsupported
      rte_eth_tx_burst?
    end
  end
end

dpdk do
  REQUIRED_CORES = 1
  REQUIRED_PORTS = 1

  include MainMethods
  include ProcessPacketsMethods
  include IpBlockingMethods

  thread ip_blocking do
    blocking_ips = [
      ipv4(10, 0, 0, 2),
      ipv4(10, 0, 0, 4),
      ipv4(10, 0, 0, 6),
    ]
    main_loop
  end

  main do
    rte_lcore_foreach_worker(1) do |lcore_id, worker_id|
      if worker_id == 0
        rte_eal_remote_launch ip_blocking
      end
    end
  end
end

# # Run the program
# # sudo build/ip_blocking -l 1-2 -- -p 1
