require "./lib_llvm"

class Dpdk
  # rte_rdtsc
  macro rte_rdtsc
    LibLLVM.rdtsc
  end
end

# likely branch prediction.
# TODO: Measure performance with or without
macro likely(val)
  LibLLVM.inspect1({{val}}, true)
end

# unlikely branch prediction.
# TODO: Measure performance with or without
macro unlikely(val)
  LibLLVM.inspect1({{val}}, false)
end

# bswap16
macro bswap16(val)
  LibLLVM.bswap16({{val}})
end

# bswap32
macro bswap32(val)
  LibLLVM.bswap32({{val}})
end

# bswap64
macro bswap64(val)
  LibLLVM.bswap64({{val}})
end
