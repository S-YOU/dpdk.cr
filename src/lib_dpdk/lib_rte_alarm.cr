lib LibDpdk
  alias RteEalAlarmCallback = (Void* -> Void)
  fun rte_eal_alarm_cancel(cb_fn : RteEalAlarmCallback, cb_arg : Void*) : LibC::Int
  fun rte_eal_alarm_set(us : Uint64T, cb : RteEalAlarmCallback, cb_arg : Void*) : LibC::Int
end
