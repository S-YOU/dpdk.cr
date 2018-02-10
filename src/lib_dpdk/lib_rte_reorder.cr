@[Link(ldflags: "-lrte_reorder")]
lib LibDpdk
  alias RteReorderBuffer = Void
  fun rte_reorder_create(name : LibC::Char*, socket_id : LibC::UInt, size : LibC::UInt) : RteReorderBuffer*
  fun rte_reorder_drain(b : RteReorderBuffer*, mbufs : RteMbuf**, max_mbufs : LibC::UInt) : LibC::UInt
  fun rte_reorder_find_existing(name : LibC::Char*) : RteReorderBuffer*
  fun rte_reorder_free(b : RteReorderBuffer*)
  fun rte_reorder_init(b : RteReorderBuffer*, bufsize : LibC::UInt, name : LibC::Char*, size : LibC::UInt) : RteReorderBuffer*
  fun rte_reorder_insert(b : RteReorderBuffer*, mbuf : RteMbuf*) : LibC::Int
  fun rte_reorder_reset(b : RteReorderBuffer*)
end
