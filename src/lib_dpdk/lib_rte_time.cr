lib LibDpdk
  $timezone : LibC::Long
  alias ClockidT = X__ClockidT
  alias Sigevent = Void
  alias TimeT = X__TimeT
  alias TimerT = X__TimerT
  alias X__ClockidT = LibC::Int
  alias X__TimerT = Void*
  fun rte_cyclecounter_cycles_to_ns(tc : RteTimecounter*, cycles : Uint64T) : Uint64T
  fun rte_ns_to_timespec(nsec : Uint64T) : Timespec
  fun rte_timecounter_update(tc : RteTimecounter*, cycle_now : Uint64T) : Uint64T
  fun rte_timespec_to_ns(ts : Timespec*) : Uint64T
  fun time(__timer : TimeT*) : TimeT
  # fun timegm(__tp : Tm*) : TimeT
  fun timelocal(__tp : Tm*) : TimeT
  fun timer_create(__clock_id : ClockidT, __evp : Sigevent*, __timerid : TimerT*) : LibC::Int
  fun timer_delete(__timerid : TimerT) : LibC::Int
  fun timer_getoverrun(__timerid : TimerT) : LibC::Int
  fun timer_gettime(__timerid : TimerT, __value : Itimerspec*) : LibC::Int
  fun timer_settime(__timerid : TimerT, __flags : LibC::Int, __value : Itimerspec*, __ovalue : Itimerspec*) : LibC::Int
  fun timespec_get(__ts : Timespec*, __base : LibC::Int) : LibC::Int

  struct Itimerspec
    it_interval : Timespec
    it_value : Timespec
  end

  struct RteTimecounter
    cycle_last : Uint64T
    nsec : Uint64T
    nsec_mask : Uint64T
    nsec_frac : Uint64T
    cc_mask : Uint64T
    cc_shift : Uint32T
  end

  struct Tm
    tm_sec : LibC::Int
    tm_min : LibC::Int
    tm_hour : LibC::Int
    tm_mday : LibC::Int
    tm_mon : LibC::Int
    tm_year : LibC::Int
    tm_wday : LibC::Int
    tm_yday : LibC::Int
    tm_isdst : LibC::Int
    tm_gmtoff : LibC::Long
    tm_zone : LibC::Char*
  end
end
