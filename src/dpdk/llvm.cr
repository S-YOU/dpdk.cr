require "../lib_dpdk"

# :nodoc:
lib LibDpdk
  fun inspect1 = "llvm.expect.i1"(val : Bool, expected_val : Bool) : Bool
  fun rte_rdtsc = "llvm.x86.rdtsc" : UInt64
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

  # memcpy_from_array(Pointer, Array(UInt8))
  macro memcpy_from_array(dst, src)
    Intrinsics.memcpy({{dst}}.as(Void*), {{src}}.to_unsafe.as(Void*), sizeof({{src}}) * sizeof(typeof({{src}}[0])), 0_u32, false)
  end
end
