lib LibDpdk
  $rte_port_sched_reader_ops : RtePortInOps
  $rte_port_sched_writer_ops : RtePortOutOps

  struct RtePortSchedReaderParams
    sched : RteSchedPort*
  end

  struct RtePortSchedWriterParams
    sched : RteSchedPort*
    tx_burst_sz : Uint32T
  end
end
