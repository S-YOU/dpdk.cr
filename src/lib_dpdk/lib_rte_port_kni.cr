lib LibDpdk
  $rte_port_kni_reader_ops : RtePortInOps
  $rte_port_kni_writer_nodrop_ops : RtePortOutOps
  $rte_port_kni_writer_ops : RtePortOutOps

  struct RtePortKniReaderParams
    kni : RteKni*
  end

  struct RtePortKniWriterNodropParams
    kni : RteKni*
    tx_burst_sz : Uint32T
    n_retries : Uint32T
  end

  struct RtePortKniWriterParams
    kni : RteKni*
    tx_burst_sz : Uint32T
  end
end
