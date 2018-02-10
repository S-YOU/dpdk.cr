lib LibDpdk
  fun rte_distributor_clear_returns(d : RteDistributor*)
  fun rte_distributor_create(name : LibC::Char*, socket_id : LibC::UInt, num_workers : LibC::UInt, alg_type : LibC::UInt) : RteDistributor*
  fun rte_distributor_flush(d : RteDistributor*) : LibC::Int
  fun rte_distributor_get_pkt(d : RteDistributor*, worker_id : LibC::UInt, pkts : RteMbuf**, oldpkt : RteMbuf**, retcount : LibC::UInt) : LibC::Int
  fun rte_distributor_poll_pkt(d : RteDistributor*, worker_id : LibC::UInt, mbufs : RteMbuf**) : LibC::Int
  fun rte_distributor_process(d : RteDistributor*, mbufs : RteMbuf**, num_mbufs : LibC::UInt) : LibC::Int
  fun rte_distributor_request_pkt(d : RteDistributor*, worker_id : LibC::UInt, oldpkt : RteMbuf**, count : LibC::UInt)
  fun rte_distributor_return_pkt(d : RteDistributor*, worker_id : LibC::UInt, oldpkt : RteMbuf**, num : LibC::Int) : LibC::Int
  fun rte_distributor_returned_pkts(d : RteDistributor*, mbufs : RteMbuf**, max_mbufs : LibC::UInt) : LibC::Int
end
