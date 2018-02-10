lib LibDpdk
  fun rte_gso_segment(pkt : RteMbuf*, ctx : RteGsoCtx*, pkts_out : RteMbuf**, nb_pkts_out : Uint16T) : LibC::Int

  struct RteGsoCtx
    direct_pool : RteMempool*
    indirect_pool : RteMempool*
    flag : Uint64T
    gso_types : Uint32T
    gso_size : Uint16T
  end
end
