# :nodoc:
require "./lib_c"

require "./patches_release"
require "./bohem"

# :nodoc:
struct StaticArray(T, N)
  # raw index of static array, to prevent copying
  @[AlwaysInline]
  def pointer_at(index) : T*
    (pointerof(@buffer) + index)
  end

  # index access without bound check for performance
  @[AlwaysInline]
  def [](index : Int)
    to_unsafe[index]
  end

  @[AlwaysInline]
  # :nodoc:
  def []=(index : Int, value : T)
    to_unsafe[index] = value
  end
end

module Indexable(T)
  def self.range_to_index_and_count(range, collection_size)
    start_index = range.begin
    start_index += collection_size if start_index < 0
    raise "IndexError" if start_index < 0

    end_index = range.end
    end_index += collection_size if end_index < 0
    end_index -= 1 if range.excludes_end?
    count = end_index - start_index + 1
    count = 0 if count < 0

    {start_index, count}
  end
end

# :nodoc:
class Array(T)
  # index access without bound check for performance
  @[AlwaysInline]
  def [](index : Int)
    to_unsafe[index]
  end

  # :nodoc:
  def initialize(initial_capacity : Int)
    if initial_capacity < 0
      raise "Negative array size"
    end

    @size = 0
    @capacity = initial_capacity.to_i
    if initial_capacity == 0
      @buffer = Pointer(T).null
    else
      @buffer = Pointer(T).malloc(initial_capacity)
    end
  end

  @[AlwaysInline]
  def [](start : Int, count : Int)
    raise "Negative count: " + count.to_s if count < 0

    if start == size
      return Array(T).new
    end

    start += size if start < 0
    raise "IndexError" unless 0 <= start <= size

    if count == 0
      return Array(T).new
    end

    count = Math.min(count, size - start)

    Array(T).build(count) do |buffer|
      buffer.copy_from(@buffer + start, count)
      count
    end
  end
end

# :nodoc:
struct Bool
  @[AlwaysInline]
  def to_unsafe
    self ? 1 : 0
  end
end

# :nodoc:
struct Slice(T)
  # :nodoc:
  @[AlwaysInline]
  def [](index : Int)
    @pointer[index]
  end

  @[AlwaysInline]
  # :nodoc:
  def [](start, count)
    unless 0 <= start <= @size
      raise "IndexError"
    end

    unless 0 <= count <= @size - start
      raise "IndexError"
    end

    Slice.new(@pointer + start, count, read_only: @read_only)
  end

  @[AlwaysInline]
  # :nodoc:
  def []=(index : Int, value : T)
    check_writable

    index += size if index < 0
    unless 0 <= index < size
      raise "IndexError"
    end

    @pointer[index] = value
  end

  # :nodoc:
  @[AlwaysInline]
  def pointer(size)
    @pointer
  end
end

# :nodoc:
struct Tuple
  # :nodoc:
  @[AlwaysInline]
  def [](index : Int)
    at(index)
  end

  # :nodoc:
  @[AlwaysInline]
  def at(index : Int)
    at(index) { raise "IndexError" }
  end
end

# :nodoc:
struct Pointer(T)
  # pointer arithmetics in bytes
  @[AlwaysInline]
  def offset_at(offset) : UInt8*
    (self.as(UInt8*) + offset)
  end

  @[AlwaysInline]
  def u8(offset) : UInt8
    (self.as(UInt8*) + offset).value
  end

  @[AlwaysInline]
  def u8(offset, value : UInt8) : UInt8
    (self.as(UInt8*) + offset).value = value
  end

  @[AlwaysInline]
  def u16(offset) : UInt16
    (self.as(UInt8*) + offset).as(UInt16*).value
  end

  @[AlwaysInline]
  def u16(offset, value : UInt16) : UInt16
    (self.as(UInt8*) + offset).as(UInt16*).value = value
  end

  @[AlwaysInline]
  def u32(offset) : UInt32
    (self.as(UInt8*) + offset).as(UInt32*).value
  end

  @[AlwaysInline]
  def u32(offset, value : UInt32) : UInt32
    (self.as(UInt8*) + offset).as(UInt32*).value = value
  end

  @[AlwaysInline]
  def u64(offset) : UInt64
    (self.as(UInt8*) + offset).as(UInt64*).value
  end

  @[AlwaysInline]
  def u64(offset, value : UInt64) : UInt64
    (self.as(UInt8*) + offset).as(UInt64*).value = value
  end

  @[AlwaysInline]
  def self.malloc(size : Int = 1)
    if size < 0
      raise "Negative size#malloc"
    end

    malloc(size.to_u64)
  end

  @[AlwaysInline]
  def realloc(size : Int)
    if size < 0
      raise "Negative size#relloc"
    end

    realloc(size.to_u64)
  end

  @[AlwaysInline]
  def to_unsafe
    self
  end

  @[AlwaysInline]
  protected def copy_from_impl(source : Pointer(T), count : Int)
    raise "Negative count" if count < 0

    if self.class == source.class
      Intrinsics.memcpy(self.as(Void*), source.as(Void*), bytesize(count), 0_u32, false)
    else
      while (count -= 1) >= 0
        self[count] = source[count]
      end
    end
    self
  end

  @[AlwaysInline]
  def []=(offset, value : T)
    (self + offset).value = value
  end

  @[AlwaysInline]
  def []=(offset, value : Char)
    (self + offset).value = value.ord.to_u8
  end
end

abstract class IO
  @[AlwaysInline]
  def write_utf8(slice : Bytes) : Void
    write(slice)
  end

  @[AlwaysInline]
  protected def check_open
    raise "Closed stream" if closed?
  end
end

class String::Builder < IO
  # def initialize(capacity : Int = 64)
  #   String.check_capacity_in_bounds(capacity)

  #   # Make sure to also be able to hold
  #   # the header size plus the trailing zero byte
  #   capacity += String::HEADER_SIZE + 1
  #   String.check_capacity_in_bounds(capacity)

  #   @buffer_stack = uninitialized UInt8[256]
  #   if capacity <= 256
  #     @buffer = @buffer_stack.to_unsafe
  #     @capacity = 256
  #   else
  #     @buffer = GC.malloc_atomic(capacity.to_u32).as(UInt8*)
  #     @capacity = capacity.to_i
  #   end
  #   @bytesize = 0
  #   @finished = false
  # end

  # def write_byte(byte : UInt8) : Void
  #   new_bytesize = real_bytesize + 1
  #   if new_bytesize > @capacity
  #     resize_to_capacity(Math.pw2ceil(new_bytesize))
  #   end

  #   @buffer[real_bytesize] = byte

  #   @bytesize += 1
  # end

  # def to_s
  #   raise "Can only invoke 'to_s' once on String::Builder" if @finished
  #   @finished = true

  #   write_byte 0_u8

  #   # Try to reclaim some memory if capacity is bigger than what we need
  #   # real_bytesize = real_bytesize()
  #   # if @capacity > real_bytesize
  #   #   resize_to_capacity(real_bytesize)
  #   # end

  #   header = @buffer.as({Int32, Int32, Int32}*)
  #   header.value = {String::TYPE_ID, @bytesize - 1, 0}
  #   @buffer.as(String)
  # end

  # private def check_needs_resize
  #   resize_to_capacity(@capacity * 2) if real_bytesize == @capacity
  # end

  # private def resize_to_capacity(capacity)
  #   if capacity > 256
  #     if @capacity <= 256
  #       @buffer = GC.malloc_atomic(capacity.to_u32).as(UInt8*)
  #       @buffer.copy_from(@buffer_stack.to_unsafe, 256)
  #     else
  #       @buffer = @buffer.realloc(capacity)
  #     end
  #     @capacity = capacity
  #   end
  # end
end

class IO::Memory < IO
  @[AlwaysInline]
  private def check_writeable
    unless @writeable
      raise "Read-only stream"
    end
  end

  @[AlwaysInline]
  private def check_resizeable
    unless @resizeable
      raise "Non-resizeable stream"
    end
  end

  @[AlwaysInline]
  def write_byte(byte : UInt8, count : Int32) : Void
    Intrinsics.memset((@buffer + @pos), byte, count, 0_u32, false)
    @pos += count
    @bytesize = @pos if @pos > @bytesize
  end

  @[AlwaysInline]
  def to_unsafe
    @buffer
  end

  def gets(delimiter : Char, limit : Int32, chomp = false)
    check_open

    raise "ArgumentError: Negative limit" if limit < 0

    index = (@buffer + @pos).to_slice(@bytesize - @pos).index(delimiter.ord)
    if index
      if index >= limit
        index = limit
      else
        index += 1
      end
    else
      index = @bytesize - @pos
      return nil if index == 0

      if index >= limit
        index = limit
      end
    end

    advance = index

    if chomp && index > 0 && (@buffer + @pos + index - 1).value === delimiter
      index -= 1

      if delimiter == '\n' && index > 0 && (@buffer + @pos + index - 1).value === '\r'
        index -= 1
      end
    end

    string = String.new(@buffer + @pos, index)
    @pos += advance
    string
  end
end

# :nodoc:
module Indexable(T)
  @[AlwaysInline]
  def at(index : Int)
    at(index) { raise "IndexError: " + index.to_s }
  end

  @[AlwaysInline]
  def at(index : Int)
    unsafe_at(index)
  end

  private def check_index_out_of_bounds(index)
    check_index_out_of_bounds(index) { raise "IndexError" }
  end
end

# :nodoc:
class String
  # :nodoc:
  @[AlwaysInline]
  def self.check_capacity_in_bounds(capacity)
    if capacity < 0
      raise "Negative capacity"
    end

    if capacity.to_u64 > (UInt32::MAX - HEADER_SIZE - 1)
      raise "Capacity too big"
    end
  end

  @[AlwaysInline]
  def byte_at(index)
    byte_at(index) { raise "IndexError" }
  end

  @[AlwaysInline]
  def byte_at?(index)
    byte_at(index) { nil }
  end

  @[AlwaysInline]
  def byte_at(index)
    index += bytesize if index < 0
    if 0 <= index < bytesize
      to_unsafe[index]
    else
      yield
    end
  end

  @[AlwaysInline]
  def [](index : Int)
    at(index) { raise "IndexError" }
  end

  def self.new(bytes : Bytes, encoding : String, invalid : Symbol? = nil) : String
    new(bytes)
  end

  def self.new(capacity : Int)
    check_capacity_in_bounds(capacity)

    str = GC.malloc_atomic(capacity.to_u32 + HEADER_SIZE + 1).as(UInt8*)
    buffer = str.as(String).to_unsafe
    bytesize, size = yield buffer

    unless 0 <= bytesize <= capacity
      raise "Bytesize out of capacity bounds"
    end

    buffer[bytesize] = 0_u8

    # Try to reclaim some memory if capacity is bigger than what was requested
    # if bytesize < capacity
    #   str = str.realloc(bytesize.to_u32 + HEADER_SIZE + 1)
    # end

    str_header = str.as({Int32, Int32, Int32}*)
    str_header.value = {TYPE_ID, bytesize.to_i, size.to_i}
    str.as(String)
  end

  @[AlwaysInline]
  def find(ch : UInt8)
    i = 0
    to_slice.each do |char|
      return i if char == ch
      i += 1
    end
  end

  def upcase
    return self if empty?

    String.new(bytesize) do |buffer|
      bytesize.times do |i|
        buffer[i] = to_unsafe[i].unsafe_chr.upcase.ord.to_u8
      end
      {@bytesize, @length}
    end
  end

  def *(times : Int)
    raise "Negative argument" if times < 0

    if times == 0 || bytesize == 0
      return ""
    elsif bytesize == 1
      return String.new(times) do |buffer|
        Intrinsics.memset(buffer.as(Void*), to_unsafe[0], times, 0, false)
        {times, times}
      end
    end

    total_bytesize = bytesize * times
    String.new(total_bytesize) do |buffer|
      buffer.copy_from(to_unsafe, bytesize)
      n = bytesize

      while n <= total_bytesize / 2
        (buffer + n).copy_from(buffer, n)
        n *= 2
      end

      (buffer + n).copy_from(buffer, total_bytesize - n)
      {total_bytesize, @length * times}
    end
  end

  def [](start : Int, count : Int)
    if ascii_only?
      return byte_slice(start, count)
    end

    start += size if start < 0

    start_pos = nil
    end_pos = nil

    reader = Char::Reader.new(self)
    i = 0

    reader.each do |char|
      if i == start
        start_pos = reader.pos
      elsif count >= 0 && i == start + count
        end_pos = reader.pos
        i += 1
        break
      end
      i += 1
    end

    end_pos ||= reader.pos

    if start_pos
      raise "Negative count" if count < 0
      return "" if count == 0

      count = end_pos - start_pos
      return self if count == bytesize

      String.new(count) do |buffer|
        buffer.copy_from(to_unsafe + start_pos, count)
        {count, 0}
      end
    elsif start == i
      if count >= 0
        return ""
      else
        raise "Negative count"
      end
    else
      raise "IndexError"
    end
  end

  def byte_slice(start : Int, count : Int)
    start += bytesize if start < 0
    single_byte_optimizable = ascii_only?

    if 0 <= start < bytesize
      raise "Negative count" if count < 0

      count = bytesize - start if start + count > bytesize
      return "" if count == 0
      return self if count == bytesize

      String.new(count) do |buffer|
        buffer.copy_from(to_unsafe + start, count)
        slice_size = single_byte_optimizable ? count : 0
        {count, slice_size}
      end
    elsif start == bytesize
      if count >= 0
        return ""
      else
        raise "Negative count"
      end
    else
      raise "IndexError"
    end
  end

  @[AlwaysInline]
  def ascii_only?
    @bytesize == size
  end
end

class Regex
  def initialize(source : String, @options : Options = Options::None)
    # PCRE's pattern must have their null characters escaped
    source = source.gsub('\u{0}', "\\0")
    @source = source

    @re = LibPCRE.compile(@source, (options | Options::UTF_8 | Options::NO_UTF8_CHECK | Options::DUPNAMES), out errptr, out erroffset, nil)
    raise "%s at %d\n", errptr, erroffset if @re.null?
    @extra = LibPCRE.study(@re, 0, out studyerrptr)
    raise "%s\n", studyerrptr if @extra.null? && studyerrptr
    LibPCRE.full_info(@re, nil, LibPCRE::INFO_CAPTURECOUNT, out @captures)
  end

  struct MatchData
    def [](group_name : String)
      match = self[group_name]?
      unless match
        named_capture_number(group_name) do
          raise "KeyError: Capture group '%s' was not matched", group_name
        end
        raise "KeyError: Capture group '%s' does not exist", group_name
      end
      match
    end

    private def raise_invalid_group_index(index)
      raise "IndexError: Invalid capture group index: %d", index
    end

    private def raise_capture_group_was_not_matched(index)
      raise "IndexError: Capture group %d was not matched", index
    end
  end
end

struct Int
  def remainder(other : Int)
    if other == 0
      raise "DivisionByZero"
    else
      unsafe_mod other
    end
  end

  def to_s(base : Int, io : IO, upcase : Bool = false)
    raise "Invalid base" unless 2 <= base <= 36 || base == 62
    raise "upcase must be false for base 62" if upcase && base == 62

    case self
    when 0
      io << '0'
      return
    when 1
      io << '1'
      return
    end

    internal_to_s(base, upcase) do |ptr, count|
      io.write_utf8 Slice.new(ptr, count)
    end
  end

  def **(exponent : Int) : self
    if exponent < 0
      raise "ArgumentError: Cannot raise an integer to a negative integer power, use floats for that"
    end

    result = self.class.new(1)
    k = self
    while exponent > 0
      result *= k if exponent & 0b1 != 0
      k *= k
      exponent = exponent.unsafe_shr(1)
    end
    result
  end

  private def check_div_argument(other)
    if other == 0
      raise "DivisionByZero"
    end

    {% begin %}
      if self < 0 && self == {{@type}}::MIN && other == -1
        raise "ArgumentError: Overflow: {{@type}}::MIN / -1"
      end
    {% end %}
  end

  def %(other : Int)
    if other == 0
      raise "DivisionByZero"
    elsif (self ^ other) >= 0
      self.unsafe_mod(other)
    else
      me = self.unsafe_mod(other)
      me == 0 ? me : me + other
    end
  end

  def remainder(other : Int)
    if other == 0
      raise "DivisionByZero"
    else
      unsafe_mod other
    end
  end

  def to_s(base : Int, upcase : Bool = false)
    raise "ArgumentError: Invalid base" unless 2 <= base <= 36 || base == 62
    raise "ArgumentError: upcase must be false for base 62" if upcase && base == 62

    case self
    when 0
      return "0"
    when 1
      return "1"
    end

    internal_to_s(base, upcase) do |ptr, count|
      String.new(ptr, count, count)
    end
  end

  def to_s(base : Int, io : IO, upcase : Bool = false)
    raise "ArgumentError: Invalid base" unless 2 <= base <= 36 || base == 62
    raise "ArgumentError: upcase must be false for base 62" if upcase && base == 62

    case self
    when 0
      io << '0'
      return
    when 1
      io << '1'
      return
    end

    internal_to_s(base, upcase) do |ptr, count|
      io.write_utf8 Slice.new(ptr, count)
    end
  end
end

class Exception
  getter message : String?

  @[AlwaysInline]
  def initialize(@message : String? = nil, @cause : Exception? = nil)
  end
end

module AtExitHandlers
  @@running = nil

  def self.run(status)
  end
end

{% if flag?(:fiber_none) || flag?(:except_none) %}
  def raise(exception : Exception) : NoReturn
    LibC.puts(exception.message || "")
    LibC.exit(1)
  end
{% else %}
  # overriding does not work for __crystal_personality

  @[Raises]
  fun __crystal_raise(unwind_ex : LibUnwind::Exception*) : NoReturn
    ret = LibUnwind.raise_exception(unwind_ex)
    LibC.dprintf 2, "Failed to raise an exception: %s\n", ret.to_s
    LibC.exit(ret)
  end

  fun __crystal_get_exception(unwind_ex : LibUnwind::Exception*) : UInt64
    unwind_ex.value.exception_object
  end

  def raise(exception : Exception) : NoReturn
    unwind_ex_buf = uninitialized LibUnwind::Exception
    unwind_ex = pointerof(unwind_ex_buf)
    unwind_ex.value.exception_class = LibC::SizeT.zero
    unwind_ex.value.exception_cleanup = LibC::SizeT.zero
    unwind_ex.value.exception_object = exception.object_id
    unwind_ex.value.exception_type_id = exception.crystal_type_id
    __crystal_raise(unwind_ex)
  end
{% end %}

def raise(exception : ExceptionBase) : NoReturn
  LibC.exit(1)
end

def raise(exception : Errno) : NoReturn
  LibC.exit(1)
end

def raise(msg : String) : NoReturn
  LibC.puts(msg)
  LibC.exit(1)
end

def raise(msg : String?) : NoReturn
  LibC.puts(msg || "")
  LibC.exit(1)
end

def raise(format : String, *args) : NoReturn
  LibC.printf(format, *args)
  LibC.exit(1)
end

# uninitialized as pointer (mainly for StaticArray)
macro uninitialized_ptr(arg)
  %name = uninitialized {{arg}}
  %name.to_unsafe
end

# usleep from LibC
macro usleep(n)
  LibC.usleep({{n}})
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

# LibC.open - default read
macro open(name, mode = LibC::O_RDONLY, perm = 0o644)
  fd = LibC.open({{name}}, {{mode}}, {{perm}})
  raise "Cannot open %s\n", {{name}} if fd < 0
  fd
end

# LibC.read
macro read(fd, buf, buf_len)
  ret = LibC.read({{fd}}, {{buf}}, {{buf_len}})
  raise "Cannot read %s\n", {{fd}} if ret < 0
  ret
end

# LibC.write
macro write(fd, buf, buf_len)
  ret = LibC.write({{fd}}, {{buf}}, {{buf_len}})
  raise "Cannot write %s\n", {{fd}} if ret < 0
  ret
end

# LibC.close
macro close(fd)
  LibC.close({{fd}})
end

# read file to buffer
macro read_file(file, buf, size)
  %fd = open({{file}})
  ret = read(%fd, {{buf}}, {{size}})
  close(%fd)
  ret
end
