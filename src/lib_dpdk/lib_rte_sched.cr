lib LibDpdk
  alias X__PidT = LibC::Int
  fun sched_get_priority_max(__algorithm : LibC::Int) : LibC::Int
  fun sched_get_priority_min(__algorithm : LibC::Int) : LibC::Int
  fun sched_getparam(__pid : X__PidT, __param : SchedParam*) : LibC::Int
  fun sched_getscheduler(__pid : X__PidT) : LibC::Int
  fun sched_rr_get_interval(__pid : X__PidT, __t : Timespec*) : LibC::Int
  fun sched_setparam(__pid : X__PidT, __param : SchedParam*) : LibC::Int
  fun sched_setscheduler(__pid : X__PidT, __policy : LibC::Int, __param : SchedParam*) : LibC::Int
  fun sched_yield : LibC::Int

  struct SchedParam
    sched_priority : LibC::Int
  end
end
