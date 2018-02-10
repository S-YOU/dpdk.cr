lib LibDpdk
  fun rte_gro_ctx_create(param : RteGroParam*) : Void*
  fun rte_gro_ctx_destroy(ctx : Void*)
  fun rte_gro_get_pkt_count(ctx : Void*) : Uint64T
  fun rte_gro_reassemble(pkts : RteMbuf**, nb_pkts : Uint16T, ctx : Void*) : Uint16T
  fun rte_gro_reassemble_burst(pkts : RteMbuf**, nb_pkts : Uint16T, param : RteGroParam*) : Uint16T
  fun rte_gro_timeout_flush(ctx : Void*, timeout_cycles : Uint64T, gro_types : Uint64T, out : RteMbuf**, max_nb_out : Uint16T) : Uint16T

  struct RteGroParam
    gro_types : Uint64T
    max_flow_num : Uint16T
    max_item_per_flow : Uint16T
    socket_id : Uint16T
  end
end
