lib LibDpdk
  alias RteFlowClassifier = Void
  alias RteFlowClassifyRule = Void
  enum RteFlowClassifyTableType
    RteFlowClassifyTableTypeNone = 0
    RteFlowClassifyTableTypeAcl  = 1
  end
  fun rte_flow_classifier_create(params : RteFlowClassifierParams*) : RteFlowClassifier*
  fun rte_flow_classifier_free(cls : RteFlowClassifier*) : LibC::Int
  fun rte_flow_classifier_query(cls : RteFlowClassifier*, table_id : Uint32T, pkts : RteMbuf**, nb_pkts : Uint16T, rule : RteFlowClassifyRule*, stats : RteFlowClassifyStats*) : LibC::Int
  fun rte_flow_classify_table_create(cls : RteFlowClassifier*, params : RteFlowClassifyTableParams*, table_id : Uint32T*) : LibC::Int
  fun rte_flow_classify_table_entry_add(cls : RteFlowClassifier*, table_id : Uint32T, key_found : LibC::Int*, attr : RteFlowAttr*, pattern : RteFlowItem*, actions : RteFlowAction*, error : RteFlowError*) : RteFlowClassifyRule*
  fun rte_flow_classify_table_entry_delete(cls : RteFlowClassifier*, table_id : Uint32T, rule : RteFlowClassifyRule*) : LibC::Int

  struct RteFlowClassifierParams
    name : LibC::Char*
    socket_id : LibC::Int
    type : RteFlowClassifyTableType
  end

  struct RteFlowClassifyIpv45tuple
    dst_ip : Uint32T
    dst_ip_mask : Uint32T
    src_ip : Uint32T
    src_ip_mask : Uint32T
    dst_port : Uint16T
    dst_port_mask : Uint16T
    src_port : Uint16T
    src_port_mask : Uint16T
    proto : Uint8T
    proto_mask : Uint8T
  end

  struct RteFlowClassifyIpv45tupleStats
    counter1 : Uint64T
    ipv4_5tuple : RteFlowClassifyIpv45tuple
  end

  struct RteFlowClassifyStats
    stats : Void*
  end

  struct RteFlowClassifyTableParams
    ops : RteTableOps*
    arg_create : Void*
  end
end
