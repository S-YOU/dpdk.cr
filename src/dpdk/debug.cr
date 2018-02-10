require "../lib_dpdk"

class Dpdk
  # rte_log equivalent
  macro rte_log(l, t, *args)
    LibDpdk.rte_log(RTE_LOG_{{l}}, RTE_LOGTYPE_{{t}}, "{{t}} : " + {{*args}})
  end

  # rte_log with log level condition.
  # TODO: fix log level check at compile time
  macro log_dp(l, t, *args)
    # not thread safe? in crystal?
    # rte_log(RTE_LOG_{{l}}, RTE_LOGTYPE_{{t}}, "{{t}} : " + {{*args}})
  end

  # TODO: support conditional logging
  # macro log_dp(l, *args)
  #   {% if l <= RTE_LOG_DP_LEVEL %}
  #     rte_log_dp(RTE_LOG_{{l}}, {{*args}})
  #   {% end %}
  # end

  # rte_exit with EXIT_FAILURE
  macro fail(*args)
    LibDpdk.rte_exit(EXIT_FAILURE, {{*args}})
  end

  # rte_panic equivalent without function name
  macro panic(*args)
    LibDpdk.__rte_panic("#{__FILE__}:#{__LINE__}", {{*args}})
  end

  # printf from LibC
  macro printf(*args)
    LibC.printf({{*args}})
  end

  # snprintf from LibC
  macro snprintf(*args)
    LibC.snprintf({{*args}})
  end
end
