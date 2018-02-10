lib LibDpdk
  $rte_port_sink_ops : RtePortOutOps
  $rte_port_source_ops : RtePortInOps

  struct RtePortSinkParams
    file_name : LibC::Char*
    max_n_pkts : Uint32T
  end

  struct RtePortSourceParams
    mempool : RteMempool*
    file_name : LibC::Char*
    n_bytes_per_pkt : Uint32T
  end
end
