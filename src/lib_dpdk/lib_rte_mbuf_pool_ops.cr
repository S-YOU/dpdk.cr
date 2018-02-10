lib LibDpdk
  fun rte_mbuf_best_mempool_ops : LibC::Char*
  fun rte_mbuf_platform_mempool_ops : LibC::Char*
  fun rte_mbuf_set_platform_mempool_ops(ops_name : LibC::Char*) : LibC::Int
  fun rte_mbuf_set_user_mempool_ops(ops_name : LibC::Char*) : LibC::Int
  fun rte_mbuf_user_mempool_ops : LibC::Char*
end
