lib LibDpdk
  alias RteLatencyStatsFlowTypeFn = (RteMbuf*, Void* -> Uint16T)
  fun rte_latencystats_get(values : RteMetricValue*, size : Uint16T) : LibC::Int
  fun rte_latencystats_get_names(names : RteMetricName*, size : Uint16T) : LibC::Int
  fun rte_latencystats_init(samp_intvl : Uint64T, user_cb : RteLatencyStatsFlowTypeFn) : LibC::Int
  fun rte_latencystats_uninit : LibC::Int
  fun rte_latencystats_update : Int32T
end
