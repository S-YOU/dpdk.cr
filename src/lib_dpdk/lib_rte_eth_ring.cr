lib LibDpdk
  fun rte_eth_from_ring(r : RteRing*) : LibC::Int
  fun rte_eth_from_rings(name : LibC::Char*, rx_queues : RteRing**, nb_rx_queues : LibC::UInt, tx_queues : RteRing**, nb_tx_queues : LibC::UInt, numa_node : LibC::UInt) : LibC::Int
end
