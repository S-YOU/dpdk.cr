lib LibDpdk
  $rte_port_ring_writer_ipv4_ras_ops : RtePortOutOps
  $rte_port_ring_writer_ipv6_ras_ops : RtePortOutOps

  struct RtePortRingWriterRasParams
    ring : RteRing*
    tx_burst_sz : Uint32T
  end
end
