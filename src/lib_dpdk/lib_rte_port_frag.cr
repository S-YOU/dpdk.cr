lib LibDpdk
  $rte_port_ring_reader_ipv4_frag_ops : RtePortInOps
  $rte_port_ring_reader_ipv6_frag_ops : RtePortInOps

  struct RtePortRingReaderFragParams
    ring : RteRing*
    mtu : Uint32T
    metadata_size : Uint32T
    pool_direct : RteMempool*
    pool_indirect : RteMempool*
  end
end
