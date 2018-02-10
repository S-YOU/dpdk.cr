lib LibDpdk
  $rte_red_log2_1_minus_Wq : Uint16T[12]
  $rte_red_pow2_frac_inv : Uint16T[16]
  $rte_red_rand_seed : Uint32T
  $rte_red_rand_val : Uint32T
  fun __rte_red_calc_qempty_factor(wq_log2 : Uint8T, m : Uint16T) : Uint16T
  fun __rte_red_drop(red_cfg : RteRedConfig*, red : RteRed*) : LibC::Int
  fun rte_fast_rand : Uint32T
  fun rte_red_config_init(red_cfg : RteRedConfig*, wq_log2 : Uint16T, min_th : Uint16T, max_th : Uint16T, maxp_inv : Uint16T) : LibC::Int
  fun rte_red_enqueue(red_cfg : RteRedConfig*, red : RteRed*, q : LibC::UInt, time : Uint64T) : LibC::Int
  fun rte_red_enqueue_empty(red_cfg : RteRedConfig*, red : RteRed*, time : Uint64T) : LibC::Int
  fun rte_red_enqueue_nonempty(red_cfg : RteRedConfig*, red : RteRed*, q : LibC::UInt) : LibC::Int
  fun rte_red_mark_queue_empty(red : RteRed*, time : Uint64T)
  fun rte_red_rt_data_init(red : RteRed*) : LibC::Int

  struct RteRed
    avg : Uint32T
    count : Uint32T
    q_time : Uint64T
  end

  struct RteRedConfig
    min_th : Uint32T
    max_th : Uint32T
    pa_const : Uint32T
    maxp_inv : Uint8T
    wq_log2 : Uint8T
  end

  struct RteRedParams
    min_th : Uint16T
    max_th : Uint16T
    maxp_inv : Uint16T
    wq_log2 : Uint16T
  end
end
