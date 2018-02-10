require "../src/dpdk"

class Timer < Dpdk
  TIMER_RESOLUTION_CYCLES = 20_000_000_u64 # around 10ms at 2 Ghz

  @timer0 = uninitialized RteTimer
  @timer1 = uninitialized RteTimer

  def timer0_cb(tim)
    counter = 0
    lcore_id = rte_lcore_id
    printf("timer0_cb(): on lcore %d\n", lcore_id)

    # this timer is automatically reloaded until we decide to
    # stop it, when counter reaches 20.
    rte_timer_stop(tim) if counter == 20
    counter += 1
  end

  def timer1_cb(tim)
    lcore_id = rte_lcore_id
    printf("timer1_cb(): on lcore %d\n", lcore_id)

    # reload it on another lcore
    hz = rte_get_timer_hz
    lcore_id = rte_get_next_lcore(lcore_id, 0, 1)
    rte_timer_reset(tim, hz/3, RteTimerType::Single, lcore_id, ->(tim : RteTimer*, arg : Void*) {
      Timer.instance.timer1_cb(tim)
    }, nil)
  end

  def lcore_mainloop(arg_ptr : Void*) : Void
    prev_tsc = 0

    lcore_id = rte_lcore_id
    printf("Starting mainloop on core %u\n", lcore_id)

    while true
      # Call the timer handler on each core: as we don't
      # need a very precise timer, so only call
      # rte_timer_manage() every ~10ms (at 2Ghz). In a real
      # application, this will enhance performances as
      # reading the HPET timer is not efficient.
      cur_tsc = rte_rdtsc
      diff_tsc = cur_tsc - prev_tsc
      if diff_tsc > TIMER_RESOLUTION_CYCLES
        rte_timer_manage
        prev_tsc = cur_tsc
      end
    end
  end

  def main(argc, argv)
    rte_eal_init(argc, argv)

    # init RTE timer library
    rte_timer_subsystem_init

    # init timer structures
    rte_timer_init(pointerof(@timer0))
    rte_timer_init(pointerof(@timer1))

    # load timer0, every second, on master lcore, reloaded automatically
    hz = rte_get_timer_hz
    lcore_id = rte_lcore_id
    rte_timer_reset(pointerof(@timer0), hz, RteTimerType::Periodical, lcore_id, ->(tim : RteTimer*, arg : Void*) {
      Timer.instance.timer0_cb(tim)
    }, nil)

    # load timer1, every second/3, on next lcore, reloaded manually
    lcore_id = rte_get_next_lcore(lcore_id, 0, 1)
    rte_timer_reset(pointerof(@timer1), hz/3, RteTimerType::Single, lcore_id, ->(tim : RteTimer*, arg : Void*) {
      Timer.instance.timer1_cb(tim)
    }, nil)

    # call lcore_mainloop() on every slave lcore
    rte_lcore_foreach_slave do |lcore_id|
      rte_eal_remote_launch(lcore_mainloop, nil, lcore_id)
    end

    # call it on master lcore too
    lcore_mainloop(nil.as(Void*))
  end
end

Timer.run

# # Run the program
# # sudo build/timer
