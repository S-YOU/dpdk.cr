lib LibDpdk
  # alias RteDistributorV20 = Void
  fun rte_distributor_clear_returns_v20(d : RteDistributorV20*)
  fun rte_distributor_create_v20(name : LibC::Char*, socket_id : LibC::UInt, num_workers : LibC::UInt) : RteDistributorV20*
  fun rte_distributor_flush_v20(d : RteDistributorV20*) : LibC::Int
  fun rte_distributor_get_pkt_v20(d : RteDistributorV20*, worker_id : LibC::UInt, oldpkt : RteMbuf*) : RteMbuf*
  fun rte_distributor_poll_pkt_v20(d : RteDistributorV20*, worker_id : LibC::UInt) : RteMbuf*
  fun rte_distributor_process_v20(d : RteDistributorV20*, mbufs : RteMbuf**, num_mbufs : LibC::UInt) : LibC::Int
  fun rte_distributor_request_pkt_v20(d : RteDistributorV20*, worker_id : LibC::UInt, oldpkt : RteMbuf*)
  fun rte_distributor_return_pkt_v20(d : RteDistributorV20*, worker_id : LibC::UInt, mbuf : RteMbuf*) : LibC::Int
  fun rte_distributor_returned_pkts_v20(d : RteDistributorV20*, mbufs : RteMbuf**, max_mbufs : LibC::UInt) : LibC::Int
end
