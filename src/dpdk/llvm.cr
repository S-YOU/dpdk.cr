require "../lib_dpdk"

# :nodoc:
lib LibDpdk
  fun inspect1 = "llvm.expect.i1"(val : Bool, expected_val : Bool) : Bool
  fun rte_rdtsc = "llvm.x86.rdtsc" : UInt64
  fun bswap16 = "llvm.bswap.i16"(id : UInt16) : UInt16
  fun bswap32 = "llvm.bswap.i32"(id : UInt32) : UInt32
  fun bswap64 = "llvm.bswap.i64"(id : UInt64) : UInt64
end

class Dpdk
  # likely branch prediction.
  # TODO: Measure performance with or without
  macro likely(val)
    LibDpdk.inspect1({{val}}, true)
  end

  # unlikely branch prediction.
  # TODO: Measure performance with or without
  macro unlikely(val)
    LibDpdk.inspect1({{val}}, false)
  end
end
