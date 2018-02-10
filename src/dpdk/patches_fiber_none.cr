# :nodoc:
{% skip_file() unless flag?(:fiber_none) %}

class Thread
  @@current = nil

  def initialize(&@func : ->)
  end

  def initialize
    @func = ->{}
  end
end

# class Fiber
#   @@root = nil
# end

module GC
  @@stack_bottom = nil
end

# class Thread
#   @@threads = nil
#   @current_fiber : Fiber? = nil

#   def initialize(&@func : ->)
#     @current_fiber = uninitialized Fiber
#   end

#   def initialize
#     @current_fiber = uninitialized Fiber
#     @func = ->{}
#   end

#   @[ThreadLocal]
#   @@current = new

#   def self.current
#     @@current
#   end
# end

class IO::FileDescriptor < IO
  def flush
  end
end

class Fiber
  @@stack_pool = nil
  @stack = Pointer(Void).null
  @stack_bottom = Pointer(Void).null
  @stack_top = Pointer(Void).null

  def initialize(@name : String? = nil, &@proc : ->)
  end

  def initialize
    @name = nil
    @proc = ->{}
  end

  @@root = nil

  def self.root
    @@root
  end

  {% unless flag?(:dpdk_patch) && Crystal.has_constant?(:DPDK_PATCHED) %}
  Thread.current.current_fiber = nil
  {% end %}
end

class Scheduler
  @@runnables = nil
  @@eb = nil
end

macro sleep(n)
  LibC.usleep({{n}} * 1_000_000)
end
