lib LibDpdk
  fun rte_flow_error_set(error : RteFlowError*, code : LibC::Int, type : RteFlowErrorType, cause : Void*, message : LibC::Char*) : LibC::Int
  fun rte_flow_ops_get(port_id : Uint8T, error : RteFlowError*) : RteFlowOps*

  struct RteFlowActionRss
    rss_conf : RteEthRssConf*
    num : Uint16T
    queue : Uint16T*
  end

  struct RteFlowOps
    validate : (RteEthDev*, RteFlowAttr*, RteFlowItem*, RteFlowAction*, RteFlowError* -> LibC::Int)
    create : (RteEthDev*, RteFlowAttr*, RteFlowItem*, RteFlowAction*, RteFlowError* -> RteFlow*)
    destroy : (RteEthDev*, RteFlow*, RteFlowError* -> LibC::Int)
    flush : (RteEthDev*, RteFlowError* -> LibC::Int)
    query : (RteEthDev*, RteFlow*, RteFlowActionType, Void*, RteFlowError* -> LibC::Int)
    isolate : (RteEthDev*, LibC::Int, RteFlowError* -> LibC::Int)
  end
end
