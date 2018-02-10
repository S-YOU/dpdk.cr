lib LibDpdk
  alias RteJobUpdatePeriodCbT = (RteJobstats*, Int64T -> Void)
  fun rte_jobstats_abort(job : RteJobstats*) : LibC::Int
  fun rte_jobstats_context_finish(ctx : RteJobstatsContext*)
  fun rte_jobstats_context_init(ctx : RteJobstatsContext*) : LibC::Int
  fun rte_jobstats_context_reset(ctx : RteJobstatsContext*)
  fun rte_jobstats_context_start(ctx : RteJobstatsContext*)
  fun rte_jobstats_finish(job : RteJobstats*, job_value : Int64T) : LibC::Int
  fun rte_jobstats_init(job : RteJobstats*, name : LibC::Char*, min_period : Uint64T, max_period : Uint64T, initial_period : Uint64T, target : Int64T) : LibC::Int
  fun rte_jobstats_reset(job : RteJobstats*)
  fun rte_jobstats_set_max(job : RteJobstats*, period : Uint64T)
  fun rte_jobstats_set_min(job : RteJobstats*, period : Uint64T)
  fun rte_jobstats_set_period(job : RteJobstats*, period : Uint64T, saturate : Uint8T)
  fun rte_jobstats_set_target(job : RteJobstats*, target : Int64T)
  fun rte_jobstats_set_update_period_function(job : RteJobstats*, update_period_cb : RteJobUpdatePeriodCbT)
  fun rte_jobstats_start(ctx : RteJobstatsContext*, job : RteJobstats*) : LibC::Int

  struct RteJobstats
    period : Uint64T
    min_period : Uint64T
    max_period : Uint64T
    target : Int64T
    update_period_cb : RteJobUpdatePeriodCbT
    exec_time : Uint64T
    min_exec_time : Uint64T
    max_exec_time : Uint64T
    exec_cnt : Uint64T
    name : LibC::Char[32]
    context : RteJobstatsContext*
  end

  struct RteJobstatsContext
    state_time : Uint64T
    loop_executed_jobs : Uint64T
    exec_time : Uint64T
    min_exec_time : Uint64T
    max_exec_time : Uint64T
    management_time : Uint64T
    min_management_time : Uint64T
    max_management_time : Uint64T
    start_time : Uint64T
    job_exec_cnt : Uint64T
    loop_cnt : Uint64T
  end
end
