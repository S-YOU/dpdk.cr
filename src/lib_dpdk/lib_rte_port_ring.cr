lib LibDpdk
  $rte_port_ring_multi_reader_ops : RtePortInOps
  $rte_port_ring_multi_writer_nodrop_ops : RtePortOutOps
  $rte_port_ring_multi_writer_ops : RtePortOutOps
  $rte_port_ring_reader_ops : RtePortInOps
  $rte_port_ring_writer_nodrop_ops : RtePortOutOps
  $rte_port_ring_writer_ops : RtePortOutOps

  struct RtePortRingReaderParams
    ring : RteRing*
  end

  struct RtePortRingWriterNodropParams
    ring : RteRing*
    tx_burst_sz : Uint32T
    n_retries : Uint32T
  end

  struct RtePortRingWriterParams
    ring : RteRing*
    tx_burst_sz : Uint32T
  end
end
