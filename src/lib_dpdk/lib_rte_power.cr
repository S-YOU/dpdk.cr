lib LibDpdk
  $rte_power_freq_down : RtePowerFreqChangeT
  $rte_power_freq_max : RtePowerFreqChangeT
  $rte_power_freq_min : RtePowerFreqChangeT
  $rte_power_freq_up : RtePowerFreqChangeT
  $rte_power_freqs : RtePowerFreqsT
  $rte_power_get_freq : RtePowerGetFreqT
  $rte_power_set_freq : RtePowerSetFreqT
  alias RtePowerFreqChangeT = (LibC::UInt -> LibC::Int)
  alias RtePowerFreqsT = (LibC::UInt, Uint32T*, Uint32T -> Uint32T)
  alias RtePowerGetFreqT = (LibC::UInt -> Uint32T)
  alias RtePowerSetFreqT = (LibC::UInt, Uint32T -> LibC::Int)
  enum PowerManagementEnv
    PmEnvNotSet      = 0
    PmEnvAcpiCpufreq = 1
    PmEnvKvmVm       = 2
  end
  fun rte_power_exit(lcore_id : LibC::UInt) : LibC::Int
  fun rte_power_get_env : PowerManagementEnv
  fun rte_power_init(lcore_id : LibC::UInt) : LibC::Int
  fun rte_power_set_env(env : PowerManagementEnv) : LibC::Int
  fun rte_power_unset_env
end
