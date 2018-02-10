lib LibDpdk
  enum RteCryptodevScheduleOptionType
    CdevSchedOptionNotSet    = 0
    CdevSchedOptionThreshold = 1
    CdevSchedOptionCount     = 2
  end
  enum RteCryptodevSchedulerMode
    CdevSchedModeNotSet       = 0
    CdevSchedModeUserdefined  = 1
    CdevSchedModeRoundrobin   = 2
    CdevSchedModePktSizeDistr = 3
    CdevSchedModeFailover     = 4
    CdevSchedModeMulticore    = 5
    CdevSchedModeCount        = 6
  end
  fun rte_cryptodev_scheduler_load_user_scheduler(scheduler_id : Uint8T, scheduler : RteCryptodevScheduler*) : LibC::Int
  fun rte_cryptodev_scheduler_mode_get(scheduler_id : Uint8T) : RteCryptodevSchedulerMode
  fun rte_cryptodev_scheduler_mode_set(scheduler_id : Uint8T, mode : RteCryptodevSchedulerMode) : LibC::Int
  fun rte_cryptodev_scheduler_option_get(scheduler_id : Uint8T, option_type : RteCryptodevScheduleOptionType, option : Void*) : LibC::Int
  fun rte_cryptodev_scheduler_option_set(scheduler_id : Uint8T, option_type : RteCryptodevScheduleOptionType, option : Void*) : LibC::Int
  fun rte_cryptodev_scheduler_ordering_get(scheduler_id : Uint8T) : LibC::Int
  fun rte_cryptodev_scheduler_ordering_set(scheduler_id : Uint8T, enable_reorder : Uint32T) : LibC::Int
  fun rte_cryptodev_scheduler_slave_attach(scheduler_id : Uint8T, slave_id : Uint8T) : LibC::Int
  fun rte_cryptodev_scheduler_slave_detach(scheduler_id : Uint8T, slave_id : Uint8T) : LibC::Int
  fun rte_cryptodev_scheduler_slaves_get(scheduler_id : Uint8T, slaves : Uint8T*) : LibC::Int

  struct RteCryptodevScheduler
    name : LibC::Char*
    description : LibC::Char*
    mode : RteCryptodevSchedulerMode
    ops : RteCryptodevSchedulerOps*
  end

  struct RteCryptodevSchedulerThresholdOption
    threshold : Uint32T
  end
end
