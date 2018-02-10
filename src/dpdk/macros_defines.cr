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

  # rte_pause implementation
  macro rte_pause
    _mm_pause
  end

  # copy by u64
  macro copy64(dst, src, size)
    ({{size}}).times do |i|
      ({{dst}}).as(UInt64*)[i] = ({{src}}).as(UInt64*)[i]
    end
  end

  # copy by u32
  macro copy32(dst, src, size)
    ({{size}}).times do |i|
      ({{dst}}).as(UInt32*)[i] = ({{src}}).as(UInt32*)[i]
    end
  end

  # inet_pton for IPv6
  macro ipv6(address)
    %buf = uninitialized_ptr UInt64[2]
    LibDpdk.inet_pton6({{address}}, %buf)
    %buf.as(UInt64*)
  end
end
