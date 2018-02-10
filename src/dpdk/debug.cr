class Dpdk
  # rte_log equivalent
  macro rte_log(l, t, *args)
    # LibDpdk.rte_log(RTE_LOG_{{l}}, RTE_LOGTYPE_{{t}}, "{{t}} : " + {{*args}})
    LibC.printf("{{t}} : " + {{*args}})
  end

  # rte_log with log level condition.
  # TODO: fix log level check at compile time
  macro log_dp(l, t, *args)
    # not thread safe? in crystal?
    # rte_log(RTE_LOG_{{l}}, RTE_LOGTYPE_{{t}}, "{{t}} : " + {{*args}})
    LibC.printf("{{t}} : " + {{*args}})
  end

  # TODO: support conditional logging
  # macro log_dp(l, *args)
  #   {% if l <= RTE_LOG_DP_LEVEL %}
  #     rte_log_dp(RTE_LOG_{{l}}, {{*args}})
  #   {% end %}
  # end

  # rte_exit with EXIT_FAILURE
  macro fail(*args)
    LibC.printf({{*args}})
    LibC.exit(1)
    # LibDpdk.rte_exit(EXIT_FAILURE, {{*args}})
  end

  # rte_panic equivalent without function name
  # NOTE: lots of assembly
  macro panic(*args)
    LibDpdk.__rte_panic("#{__FILE__}:#{__LINE__}", {{*args}})
  end

  # printf from LibC
  macro printf(*args)
    LibC.printf({{*args}})
  end

  # puts from LibC
  macro puts(args)
    LibC.puts({{args}})
  end

  # snprintf from LibC
  macro snprintf(*args)
    LibC.snprintf({{*args}})
  end

  # fflush
  macro fflush(arg)
    LibC.fflush({{arg}})
  end

  # performance measure init
  private macro measure_init
    m_prev_time = microseconds # dummy
    m_iter = m_count = m_bytes = m_total = m_total_bytes = counter = 0_u64
  end

  # performance measure update
  private macro measure(name, val, bytes_val)
    measure_count({{val}}, {{bytes_val}})
    if unlikely(m_iter == APP_STATS)
      measure_output({{name}})
    end
  end

  # performance measure update count only
  private macro measure_count(val, bytes_val)
    m_iter += 1
    m_count += {{val}}
    m_bytes += {{bytes_val}}
  end

  # performance measure dump
  private macro measure_output(name)
    m_total += m_count
    m_total_bytes += m_bytes
    now_time = microseconds
    ms = (now_time - m_prev_time) / 1000
    printf("\r[%hu] {{name}} iter: %s, pkts count: %lu (%lu), bytes: %3.0f Mbps (%lu), time: %.2f ms\n",
      rte_lcore_id, to_si_measure(m_iter),
      m_count, m_total,
      (m_bytes << 3).to_f / 1_000_f64 / ms, m_total_bytes,
      ms)
    m_iter = m_count = m_bytes = 0_u64
    m_prev_time = microseconds
  end

  # performance measure dump without reset
  private macro measure_debug(name)
    now_time = microseconds
    ms = (now_time - m_prev_time) / 1000
    printf("\r[%hu] {{name}} iter: %s, pkts count: %lu (%lu), bytes: %3.0f Mbps (%lu), time: %.2f ms\n",
      rte_lcore_id, to_si_measure(m_iter),
      m_count, m_total,
      (m_bytes << 3).to_f / 1_000_f64 / ms, m_total_bytes,
      ms)
  end

  private macro microseconds
    %tp = uninitialized LibC::Timespec
    LibC.clock_gettime(LibC::CLOCK_MONOTONIC, pointerof(%tp))
    (%tp.tv_sec * 1_000_000 + %tp.tv_nsec / 1000)
  end

  macro hexdump(name, pkt, pkt_len)
    LibDpdk.rte_hexdump(LibC.stdout, "{{name}}", {{pkt}}, {{pkt_len}})
  end
end
