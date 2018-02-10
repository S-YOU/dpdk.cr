require "../lib_dpdk"

class Dpdk
  # RTE_ETH_TX_BUFFER_SIZE
  macro rte_eth_tx_buffer_size(sz)
    (sizeof(LibDpdk::RteEthDevTxBuffer) + {{sz}} * sizeof(LibDpdk::RteMbuf*)).to_u32
  end

  # RTE_MAX
  macro rte_max(a, b)
    Math.max({{a}}, {{b}})
  end

  # RTE_MIN
  macro rte_min(a, b)
    Math.min({{a}}, {{b}})
  end

  # usleep
  macro usleep(n)
    LibC.usleep({{n}})
  end

  # rte_pause
  macro rte_pause
    _mm_pause
  end
end
