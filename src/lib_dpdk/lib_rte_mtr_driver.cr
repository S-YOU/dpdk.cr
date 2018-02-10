lib LibDpdk
  alias RteMtrCapabilitiesGetT = (RteEthDev*, RteMtrCapabilities*, RteMtrError* -> LibC::Int)
  alias RteMtrCreateT = (RteEthDev*, Uint32T, RteMtrParams*, LibC::Int, RteMtrError* -> LibC::Int)
  alias RteMtrDestroyT = (RteEthDev*, Uint32T, RteMtrError* -> LibC::Int)
  alias RteMtrMeterDisableT = (RteEthDev*, Uint32T, RteMtrError* -> LibC::Int)
  alias RteMtrMeterDscpTableUpdateT = (RteEthDev*, Uint32T, RteMtrColor*, RteMtrError* -> LibC::Int)
  alias RteMtrMeterEnableT = (RteEthDev*, Uint32T, RteMtrError* -> LibC::Int)
  alias RteMtrMeterProfileAddT = (RteEthDev*, Uint32T, RteMtrMeterProfile*, RteMtrError* -> LibC::Int)
  alias RteMtrMeterProfileDeleteT = (RteEthDev*, Uint32T, RteMtrError* -> LibC::Int)
  alias RteMtrMeterProfileUpdateT = (RteEthDev*, Uint32T, Uint32T, RteMtrError* -> LibC::Int)
  alias RteMtrPolicerActionsUpdateT = (RteEthDev*, Uint32T, Uint32T, RteMtrPolicerAction*, RteMtrError* -> LibC::Int)
  alias RteMtrStatsReadT = (RteEthDev*, Uint32T, RteMtrStats*, Uint64T*, LibC::Int, RteMtrError* -> LibC::Int)
  alias RteMtrStatsUpdateT = (RteEthDev*, Uint32T, Uint64T, RteMtrError* -> LibC::Int)
  fun rte_mtr_error_set(error : RteMtrError*, code : LibC::Int, type : RteMtrErrorType, cause : Void*, message : LibC::Char*) : LibC::Int
  fun rte_mtr_ops_get(port_id : Uint16T, error : RteMtrError*) : RteMtrOps*

  struct RteMtrOps
    capabilities_get : RteMtrCapabilitiesGetT
    meter_profile_add : RteMtrMeterProfileAddT
    meter_profile_delete : RteMtrMeterProfileDeleteT
    create : RteMtrCreateT
    destroy : RteMtrDestroyT
    meter_enable : RteMtrMeterEnableT
    meter_disable : RteMtrMeterDisableT
    meter_profile_update : RteMtrMeterProfileUpdateT
    meter_dscp_table_update : RteMtrMeterDscpTableUpdateT
    policer_actions_update : RteMtrPolicerActionsUpdateT
    stats_update : RteMtrStatsUpdateT
    stats_read : RteMtrStatsReadT
  end
end
