lib LibDpdk
  fun rte_bbdev_allocate(name : LibC::Char*) : RteBbdev*
  fun rte_bbdev_get_named_dev(name : LibC::Char*) : RteBbdev*
  fun rte_bbdev_pmd_callback_process(dev : RteBbdev*, event : RteBbdevEventType, ret_param : Void*)
  fun rte_bbdev_release(bbdev : RteBbdev*) : LibC::Int

  struct RteBbdevOps
    setup_queues : Void*
    intr_enable : Void*
    start : Void*
    stop : Void*
    close : Void*
    info_get : Void*
    stats_get : Void*
    stats_reset : Void*
    queue_setup : Void*
    queue_release : Void*
    queue_start : Void*
    queue_stop : Void*
    queue_intr_enable : Void*
    queue_intr_disable : Void*
  end
end
