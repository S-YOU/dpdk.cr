lib LibDpdk
  fun rte_flow_ops_get(port_id : Uint16T, error : RteFlowError*) : RteFlowOps*

  struct RteFlowOps
    validate : (RteEthDev*, RteFlowAttr*, RteFlowItem*, RteFlowAction*, RteFlowError* -> LibC::Int)
    create : (RteEthDev*, RteFlowAttr*, RteFlowItem*, RteFlowAction*, RteFlowError* -> RteFlow*)
    destroy : (RteEthDev*, RteFlow*, RteFlowError* -> LibC::Int)
    flush : (RteEthDev*, RteFlowError* -> LibC::Int)
    query : (RteEthDev*, RteFlow*, RteFlowActionType, Void*, RteFlowError* -> LibC::Int)
    isolate : (RteEthDev*, LibC::Int, RteFlowError* -> LibC::Int)
  end
end
