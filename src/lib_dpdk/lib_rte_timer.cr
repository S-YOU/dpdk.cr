@[Link(ldflags: "-lrte_timer")]
lib LibDpdk
  alias RteTimerCbT = (RteTimer*, Void* -> Void)
  enum RteTimerType
    Single     = 0
    Periodical = 1
  end
  fun rte_timer_dump_stats(f : Void*)
  fun rte_timer_init(tim : RteTimer*)
  fun rte_timer_manage
  fun rte_timer_pending(tim : RteTimer*) : LibC::Int
  fun rte_timer_reset(tim : RteTimer*, ticks : Uint64T, type : RteTimerType, tim_lcore : LibC::UInt, fct : RteTimerCbT, arg : Void*) : LibC::Int
  fun rte_timer_reset_sync(tim : RteTimer*, ticks : Uint64T, type : RteTimerType, tim_lcore : LibC::UInt, fct : RteTimerCbT, arg : Void*)
  fun rte_timer_stop(tim : RteTimer*) : LibC::Int
  fun rte_timer_stop_sync(tim : RteTimer*)
  fun rte_timer_subsystem_init

  struct RteTimer
    expire : Uint64T
    sl_next : RteTimer*[10]
    status : RteTimerStatus
    period : Uint64T
    f : RteTimerCbT
    arg : Void*
  end

  union RteTimerStatus
    u32 : Uint32T
  end
end
