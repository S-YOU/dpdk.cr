struct StackBuffer
  def initialize(@buffer : UInt8*)
    @pos = 0
    @buffer[@pos] = 0_u8
  end

  @[AlwaysInline]
  def write(slice : Bytes) : Void
    count = slice.size

    return if count == 0

    slice.copy_to(@buffer + @pos, count)
    @pos += count
    @buffer[@pos] = 0_u8
  end

  @[AlwaysInline]
  def <<(obj : String) : Void
    write(obj.to_slice)
  end

  @[AlwaysInline]
  def to_unsafe
    @buffer
  end

  @[AlwaysInline]
  def write_byte(byte : UInt8, count : Int32) : Void
    Intrinsics.memset((@buffer + @pos), byte, count, 0_u32, false)
    @pos += count
  end
end
