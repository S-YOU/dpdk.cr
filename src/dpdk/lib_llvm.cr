# :nodoc:
lib LibLLVM
  fun inspect1 = "llvm.expect.i1"(val : Bool, expected_val : Bool) : Bool
  fun rdtsc = "llvm.x86.rdtsc" : UInt64
  fun bswap16 = "llvm.bswap.i16"(id : UInt16) : UInt16
  fun bswap32 = "llvm.bswap.i32"(id : UInt32) : UInt32
  fun bswap64 = "llvm.bswap.i64"(id : UInt64) : UInt64
end
