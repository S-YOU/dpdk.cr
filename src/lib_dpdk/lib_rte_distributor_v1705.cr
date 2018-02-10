lib LibDpdk
  fun rte_distributor_clear_returns_v1705(d : RteDistributor*)
  fun rte_distributor_create_v1705(name : LibC::Char*, socket_id : LibC::UInt, num_workers : LibC::UInt, alg_type : LibC::UInt) : RteDistributor*
  fun rte_distributor_flush_v1705(d : RteDistributor*) : LibC::Int
  fun rte_distributor_get_pkt_v1705(d : RteDistributor*, worker_id : LibC::UInt, pkts : Void**, oldpkt : Void**, retcount : LibC::UInt) : LibC::Int
  fun rte_distributor_poll_pkt_v1705(d : RteDistributor*, worker_id : LibC::UInt, mbufs : Void**) : LibC::Int
  fun rte_distributor_process_v1705(d : RteDistributor*, mbufs : Void**, num_mbufs : LibC::UInt) : LibC::Int
  fun rte_distributor_request_pkt_v1705(d : RteDistributor*, worker_id : LibC::UInt, oldpkt : Void**, count : LibC::UInt)
  fun rte_distributor_return_pkt_v1705(d : RteDistributor*, worker_id : LibC::UInt, oldpkt : Void**, num : LibC::Int) : LibC::Int
  fun rte_distributor_returned_pkts_v1705(d : RteDistributor*, mbufs : Void**, max_mbufs : LibC::UInt) : LibC::Int
end
