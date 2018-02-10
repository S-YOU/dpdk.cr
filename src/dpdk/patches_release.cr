# :nodoc:
{% skip_file() unless flag?(:release) %}

require "./lib_c"
require "./patches_gc_none"
require "./patches_fiber_none"
require "./patches_no_dpdk_patch"
require "./patches_dpdk_patch"
require "./patches_exception"

class Exception
  def backtrace
  end

  def backtrace?
  end

  def to_s(io : IO)
  end

  def inspect(io : IO)
  end

  def inspect_with_backtrace
  end

  def inspect_with_backtrace(io : IO)
  end
end

struct CallStack
  @@skip = nil

  def initialize
    @callstack = [] of Void*
  end

  def printable_backtrace
  end

  def self.print_backtrace
  end

  def self.skip(filename)
  end
end

{% unless flag?(:fiber_none) %}
enum Signal
  @@default_handlers_setup = nil

  def self.setup_default_handlers
  end
end
{% end %}

module Random::Secure
  def random_bytes(buf : Bytes)
  end
end

module AtExitHandlers
  @@running = nil

  def self.run(status)
  end
end

module Crystal
  @@stdin_is_blocking = nil
  @@stdout_is_blocking = nil
  @@stderr_is_blocking = nil

  def self.remember_blocking_state
  end

  def self.restore_blocking_state
  end

  def self.main(&block)
    yield
  end

  def self.main(argc : Int32, argv : UInt8**) : Int32
    _crystal_main(argc, argv); 0
  end

  def self.main_user_code(argc : Int32, argv : UInt8**)
  end
end

module Crystal::System::Random
  @@initialized = nil
  @@getrandom_available = nil
end

def at_exit(&handler : Int32 ->) : Nil
end

class Event::SignalHandler
  def self.close
  end
end

# def spawn(*, name : String? = nil, &block)
# end

{% if !flag?(:except_none) || flag?(:linux) %}
@[NoInline]
fun __crystal_sigfault_handler(sig : LibC::Int, addr : Void*)
end
{% end %}

class Hash(K, V)
  @[AlwaysInline]
  def fetch(key)
    fetch(key) do
      if (block = @block) && key.is_a?(K)
        block.call(self, key.as(K))
      else
        raise "Missing hash key: %s", key.to_s
      end
    end
  end
end

struct Char
  struct Reader
    @[AlwaysInline]
    private def byte_at(i)
      @string.byte_at(i).to_u32
    end

    @[AlwaysInline]
    private def byte_at?(i)
      @string.byte_at?(i).try(&.to_u32)
    end
  end

  def each_byte : Nil
    # See http://en.wikipedia.org/wiki/UTF-8#Sample_code

    c = ord
    if c < 0x80
      # 0xxxxxxx
      yield c.to_u8
    elsif c <= 0x7ff
      # 110xxxxx  10xxxxxx
      yield (0xc0 | c >> 6).to_u8
      yield (0x80 | c & 0x3f).to_u8
    elsif c <= 0xffff
      # 1110xxxx  10xxxxxx  10xxxxxx
      yield (0xe0 | (c >> 12)).to_u8
      yield (0x80 | ((c >> 6) & 0x3f)).to_u8
      yield (0x80 | (c & 0x3f)).to_u8
    elsif c <= MAX_CODEPOINT
      # 11110xxx  10xxxxxx  10xxxxxx  10xxxxxx
      yield (0xf0 | (c >> 18)).to_u8
      yield (0x80 | ((c >> 12) & 0x3f)).to_u8
      yield (0x80 | ((c >> 6) & 0x3f)).to_u8
      yield (0x80 | (c & 0x3f)).to_u8
    else
      raise "Char#each_byte: Invalid char value"
    end
  end

  def to_s(io : IO)
    if ascii?
      byte = ord.to_u8
      io.write_byte byte
    else
      chars = uninitialized UInt8[4]
      i = 0
      each_byte do |byte|
        chars[i] = byte
        i += 1
      end
      io.write_utf8 chars.to_slice[0, i]
    end
  end
end

struct Float64
  def to_unsafe
    self
  end
end

struct Descriptor
  def initialize(fd : Int32)
    @fd = LibC.fdopen(fd, "w")
  end

  def puts(message : String) : Void
    LibC.fputs(message, @fd)
  end

  def printf(format : String, *args) : Void
    LibC.fprintf(@fd, format, *args)
  end
end

{% if flag?(:dpdk_patch) %}
STDOUT = Descriptor.new(1)
STDERR = Descriptor.new(2)

class Exception
  def inspect_with_backtrace(io : Descriptor)
  end
end
{% end %}

module Unicode
  {% if flag?(:dpdk_patch) %}
  @[Flags]
  enum CaseOptions
    ASCII
  end
  {% end %}

  def self.upcase(char : Char, options : CaseOptions)
    result = check_upcase_ascii(char, options)
    return result if result
    char
  end

  def self.upcase(char : Char, options : CaseOptions)
    result = check_upcase_ascii(char, options)
    if result
      yield result
      return
    end
    yield char
  end

  private def self.check_upcase_ascii(char, options)
    if (char.ascii? && options.none?) || options.ascii?
      if char.ascii_lowercase?
        return (char.ord - 32).unsafe_chr
      else
        return char
      end
    end
    nil
  end

  def self.downcase(char : Char, options : CaseOptions)
    result = check_downcase_ascii(char, options)
    return result if result
    char
  end

  def self.downcase(char : Char, options : CaseOptions)
    result = check_downcase_ascii(char, options)
    if result
      yield result
      return
    end
    yield char
  end

  private def self.check_downcase_ascii(char, options)
    if (char.ascii? && options.none?) || options.ascii?
      if char.ascii_uppercase?
        return (char.ord + 32).unsafe_chr
      else
        return char
      end
    end
    nil
  end
end

def sprintf(format : String, args : Float64) : String
  buf = uninitialized UInt8[64]
  LibC.sprintf buf.to_unsafe, format, args
  String.new(buf.to_slice)
end

macro abort(message, status = 1)
  LibC.puts({{message}})
  LibC.exit({{status}})
end

macro printf(*args)
  LibC.printf({{*args}})
end

macro write(*args)
  LibC.write({{*args}})
end

macro putchar(arg)
  LibC.putchar({{arg}}.ord)
end

macro snprintf(*args)
  LibC.snprintf({{*args}})
end

macro fprintf(*args)
  LibC.fprintf({{*args}})
end

@[AlwaysInline]
def print(format : String)
  LibC.printf(format)
end

@[AlwaysInline]
def puts(format : String)
  LibC.puts(format)
end

@[AlwaysInline]
def puts(args : Tuple)
  LibC.puts(*args)
end

@[AlwaysInline]
def puts
  LibC.puts("")
end

@[AlwaysInline]
def puts(format : UInt8*)
  LibC.puts(format)
end

@[AlwaysInline]
def exit(code : Int32)
  LibC.exit(code)
end

abstract class IO
  def printf(format_string, *args) : Nil
    LibC.printf format_string, *args
  end

  # ditto
  def printf(format_string, args : Array | Tuple) : Nil
    LibC.printf format_string, *args
    # String::Formatter(typeof(args)).new(format_string, args, self).format
    # nil
  end

  private def encoder
  end

  private def decoder
  end

  def set_encoding(encoding : String, invalid : Symbol? = nil)
  end
end

class String
  protected def self.encode(slice, from, to, io, invalid)
    raise "Not implemented"
  end

  protected def char_bytesize_at(byte_index)
    1
  end
end

# {% if flag?(:darwin) %}
# fun setup_sigfault_handler
# end
# {% end %}
