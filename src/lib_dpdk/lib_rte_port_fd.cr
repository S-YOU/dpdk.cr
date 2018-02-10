lib LibDpdk
  $rte_port_fd_reader_ops : RtePortInOps
  $rte_port_fd_writer_nodrop_ops : RtePortOutOps
  $rte_port_fd_writer_ops : RtePortOutOps

  struct RtePortFdReaderParams
    fd : LibC::Int
    mtu : Uint32T
    mempool : RteMempool*
  end

  struct RtePortFdWriterNodropParams
    fd : LibC::Int
    tx_burst_sz : Uint32T
    n_retries : Uint32T
  end

  struct RtePortFdWriterParams
    fd : LibC::Int
    tx_burst_sz : Uint32T
  end
end
