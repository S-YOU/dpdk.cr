lib LibDpdk
  $rte_port_ethdev_reader_ops : RtePortInOps
  $rte_port_ethdev_writer_nodrop_ops : RtePortOutOps
  $rte_port_ethdev_writer_ops : RtePortOutOps

  struct RtePortEthdevReaderParams
    port_id : Uint16T
    queue_id : Uint16T
  end

  struct RtePortEthdevWriterNodropParams
    port_id : Uint16T
    queue_id : Uint16T
    tx_burst_sz : Uint32T
    n_retries : Uint32T
  end

  struct RtePortEthdevWriterParams
    port_id : Uint16T
    queue_id : Uint16T
    tx_burst_sz : Uint32T
  end
end
