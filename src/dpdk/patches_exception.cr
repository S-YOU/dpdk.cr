{% skip_file() unless flag?(:dpdk_patch) %}

abstract struct ExceptionBase
end

struct TypeCastError < ExceptionBase
  @[AlwaysInline]
  def initialize(message = "Type Cast error")
    raise message
  end
end

struct ArgumentError < ExceptionBase
  @[AlwaysInline]
  def initialize(message = "ArgumentError")
    raise message
  end
end

lib LibC
  {% if flag?(:linux) %}
    {% if flag?(:musl) %}
      fun __errno_location : Int*
    {% else %}
      @[ThreadLocal]
      $errno : Int
    {% end %}
  {% elsif flag?(:darwin) || flag?(:freebsd) %}
    fun __error : Int*
  {% elsif flag?(:openbsd) %}
    fun __error = __errno : Int*
  {% end %}
end

class Errno
  @[AlwaysInline]
  def initialize(message : String?, errno = Errno.value)
    @errno = errno
    LibC.printf("errno: %s", LibC.strerror(errno))
  end

  def self.value : LibC::Int
    {% if flag?(:linux) %}
      {% if flag?(:musl) %}
        LibC.__errno_location.value
      {% else %}
        LibC.errno
      {% end %}
    {% elsif flag?(:darwin) || flag?(:freebsd) || flag?(:openbsd) %}
      LibC.__error.value
    {% end %}
  end
end

struct IndexError < ExceptionBase
  @[AlwaysInline]
  def initialize(message = "Index Error")
    raise message
  end
end

struct InvalidByteSequenceError < ExceptionBase
  def initialize(message = "Invalid byte sequence in UTF-8 string")
    raise message
  end
end

struct KeyError < ExceptionBase
  def initialize(message = "Invalid byte sequence in UTF-8 string")
    raise message
  end
end

struct DivisionByZero < ExceptionBase
  def initialize(message = "Division by zero")
    raise message
  end
end
