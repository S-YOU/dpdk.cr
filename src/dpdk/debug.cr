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

  # performance measure init
  private macro measure_init
    iter = total = count = bytes = bytes_crc = total_bytes = prev_time = counter = 0_u64
    prev_time = microseconds
  end

  # performance measure update
  private macro measure(name, val, bytes_val)
    iter += 1
    count += {{val}}
    bytes += {{bytes_val}}
    if unlikely(iter == APP_STATS)
      bytes_crc = bytes
      measure_output({{name}})
    end
  end

  # performance measure update with crc
  private macro measure(name, val, bytes_val, bytes_val_crc)
    measure_count({{val}}, {{bytes_val}}, {{bytes_val_crc}})
    if unlikely(iter == APP_STATS)
      measure_output({{name}})
    end
  end

  # performance measure update count only
  private macro measure_count(val, bytes_val, bytes_val_crc)
    iter += 1
    count += {{val}}
    bytes += {{bytes_val}}
    bytes_crc += {{bytes_val_crc}}
  end

  # performance measure dump
  private macro measure_output(name)
    if count > 0
      total += count
      total_bytes += bytes
      lcore = rte_lcore_id
      now_time = microseconds
      ms = (now_time - prev_time) / 1000
      printf("\r[%hu] {{name}} iter: %s, pkts count: %lu (%lu), bytes: %3.0f Mbps (%lu), time: %.2f ms\n",
        lcore, to_si_measure(iter),
        count, total,
        (bytes_crc << 3).to_f / 1_000_f64 / ms, total_bytes,
        ms)
      iter = count = bytes = bytes_crc = 0_u64
      prev_time = microseconds
    end
  end

  def microseconds
    tp = uninitialized LibC::Timespec
    LibC.clock_gettime(LibC::CLOCK_MONOTONIC, pointerof(tp))
    tp.tv_sec * 1_000_000 + tp.tv_nsec / 1000
  end
end
