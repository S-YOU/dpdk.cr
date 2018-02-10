require "../lib_dpdk"

class Dpdk
  # RTE_ETH_TX_BUFFER_SIZE
  macro rte_eth_tx_buffer_size(sz)
    (sizeof(RteEthDevTxBuffer) + {{sz}} * sizeof(RteMbuf*)).to_u32
  end

  # RTE_MAX
  macro rte_max(a, b)
    Math.max({{a}}, {{b}})
  end

  # RTE_MIN
  macro rte_min(a, b)
    Math.min({{a}}, {{b}})
  end

  # usleep from LibC
  macro usleep(n)
    LibC.usleep({{n}})
  end

  # override sleep with usleep
  macro sleep(n)
    LibC.usleep({{n}} * 1_000_000)
  end

  # rte_pause implementation
  macro rte_pause
    _mm_pause
  end

  # malloc
  macro malloc(count)
    LibC.malloc({{count}})
  end

  # calloc
  macro calloc(count, size)
    LibC.calloc({{count}}, {{size}})
  end

  # free
  macro free(ptr)
    LibC.free({{ptr}})
  end
end
