lib LibDpdk
  alias RteTmCapabilitiesGetT = (RteEthDev*, RteTmCapabilities*, RteTmError* -> LibC::Int)
  alias RteTmHierarchyCommitT = (RteEthDev*, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmLevelCapabilitiesGetT = (RteEthDev*, Uint32T, RteTmLevelCapabilities*, RteTmError* -> LibC::Int)
  alias RteTmMarkIpDscpT = (RteEthDev*, LibC::Int, LibC::Int, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmMarkIpEcnT = (RteEthDev*, LibC::Int, LibC::Int, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmMarkVlanDeiT = (RteEthDev*, LibC::Int, LibC::Int, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmNodeAddT = (RteEthDev*, Uint32T, Uint32T, Uint32T, Uint32T, Uint32T, RteTmNodeParams*, RteTmError* -> LibC::Int)
  alias RteTmNodeCapabilitiesGetT = (RteEthDev*, Uint32T, RteTmNodeCapabilities*, RteTmError* -> LibC::Int)
  alias RteTmNodeCmanUpdateT = (RteEthDev*, Uint32T, RteTmCmanMode, RteTmError* -> LibC::Int)
  alias RteTmNodeDeleteT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeParentUpdateT = (RteEthDev*, Uint32T, Uint32T, Uint32T, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeResumeT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeShaperUpdateT = (RteEthDev*, Uint32T, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeSharedShaperUpdateT = (RteEthDev*, Uint32T, Uint32T, Int32T, RteTmError* -> LibC::Int)
  alias RteTmNodeSharedWredContextUpdateT = (RteEthDev*, Uint32T, Uint32T, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmNodeStatsReadT = (RteEthDev*, Uint32T, RteTmNodeStats*, Uint64T*, LibC::Int, RteTmError* -> LibC::Int)
  alias RteTmNodeStatsUpdateT = (RteEthDev*, Uint32T, Uint64T, RteTmError* -> LibC::Int)
  alias RteTmNodeSuspendT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeTypeGetT = (RteEthDev*, Uint32T, LibC::Int*, RteTmError* -> LibC::Int)
  alias RteTmNodeWfqWeightModeUpdateT = (RteEthDev*, Uint32T, LibC::Int*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmNodeWredContextUpdateT = (RteEthDev*, Uint32T, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmShaperProfileAddT = (RteEthDev*, Uint32T, RteTmShaperParams*, RteTmError* -> LibC::Int)
  alias RteTmShaperProfileDeleteT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmSharedShaperAddUpdateT = (RteEthDev*, Uint32T, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmSharedShaperDeleteT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmSharedWredContextAddUpdateT = (RteEthDev*, Uint32T, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmSharedWredContextDeleteT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  alias RteTmWredProfileAddT = (RteEthDev*, Uint32T, RteTmWredParams*, RteTmError* -> LibC::Int)
  alias RteTmWredProfileDeleteT = (RteEthDev*, Uint32T, RteTmError* -> LibC::Int)
  fun rte_tm_error_set(error : RteTmError*, code : LibC::Int, type : RteTmErrorType, cause : Void*, message : LibC::Char*) : LibC::Int
  fun rte_tm_ops_get(port_id : Uint8T, error : RteTmError*) : RteTmOps*

  struct RteTmOps
    node_type_get : RteTmNodeTypeGetT
    capabilities_get : RteTmCapabilitiesGetT
    level_capabilities_get : RteTmLevelCapabilitiesGetT
    node_capabilities_get : RteTmNodeCapabilitiesGetT
    wred_profile_add : RteTmWredProfileAddT
    wred_profile_delete : RteTmWredProfileDeleteT
    shared_wred_context_add_update : RteTmSharedWredContextAddUpdateT
    shared_wred_context_delete : RteTmSharedWredContextDeleteT
    shaper_profile_add : RteTmShaperProfileAddT
    shaper_profile_delete : RteTmShaperProfileDeleteT
    shared_shaper_add_update : RteTmSharedShaperAddUpdateT
    shared_shaper_delete : RteTmSharedShaperDeleteT
    node_add : RteTmNodeAddT
    node_delete : RteTmNodeDeleteT
    node_suspend : RteTmNodeSuspendT
    node_resume : RteTmNodeResumeT
    hierarchy_commit : RteTmHierarchyCommitT
    node_parent_update : RteTmNodeParentUpdateT
    node_shaper_update : RteTmNodeShaperUpdateT
    node_shared_shaper_update : RteTmNodeSharedShaperUpdateT
    node_stats_update : RteTmNodeStatsUpdateT
    node_wfq_weight_mode_update : RteTmNodeWfqWeightModeUpdateT
    node_cman_update : RteTmNodeCmanUpdateT
    node_wred_context_update : RteTmNodeWredContextUpdateT
    node_shared_wred_context_update : RteTmNodeSharedWredContextUpdateT
    node_stats_read : RteTmNodeStatsReadT
    mark_vlan_dei : RteTmMarkVlanDeiT
    mark_ip_ecn : RteTmMarkIpEcnT
    mark_ip_dscp : RteTmMarkIpDscpT
  end
end
