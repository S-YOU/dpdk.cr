lib LibC
  alias UsecondsT = UInt32
  $stdout : Void*
  $stderr : Void*
  fun usleep(usec : UsecondsT)
  fun calloc(count : SizeT, size : SizeT) : UInt8*
end
