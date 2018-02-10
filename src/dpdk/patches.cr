require "../lib_dpdk"

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
end

# :nodoc:
class Array(T)
  # index access without bound check for performance
  @[AlwaysInline]
  def [](index : Int)
    to_unsafe[index]
  end
end

# :nodoc:
struct Slice(T)
  # index access without bound check for performance
  @[AlwaysInline]
  def [](index : Int)
    @pointer[index]
  end

  # index access without bound check for performance
  @[AlwaysInline]
  def pointer(size)
    @pointer
  end
end

# :nodoc:
struct Pointer(T)
  # pointer arithmetics in bytes
  @[AlwaysInline]
  def offset_at(offset) : UInt8*
    (self.as(UInt8*) + offset)
  end

  # TODO: Not very useful
  # @[AlwaysInline]
  # def pointer_at(index)
  #   self.value.pointer_at(index)
  # end

  # PERF: Can't use because of codegen freeze on load_balancer
  # macro method_missing(call)
  #   self.value.{{call}}
  # end
end

require "./atomic_pointer"
