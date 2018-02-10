{% skip_file() unless flag?(:gc_none) && flag?(:bohem) %}

@[Link("gc")]
lib LibC
  fun malloc = GC_malloc(size : SizeT) : Void*
  fun malloc_atomic = GC_malloc_atomic(size : SizeT) : Void*
  fun realloc = GC_realloc(ptr : Void*, size : SizeT) : Void*
  fun free = GC_free(ptr : Void*)
end

module GC
  def self.init
  end

  # :nodoc:
  def self.malloc(size : LibC::SizeT)
    LibC.malloc(size)
  end

  # :nodoc:
  def self.malloc_atomic(size : LibC::SizeT)
    LibC.malloc_atomic(size)
  end

  # :nodoc:
  def self.realloc(pointer : Void*, size : LibC::SizeT)
    LibC.realloc(pointer, size)
  end

  def self.collect
  end

  def self.enable
  end

  def self.disable
  end

  def self.free(pointer : Void*)
    LibC.free(pointer)
  end

  def self.is_heap_ptr(pointer : Void*)
    false
  end

  def self.add_finalizer(object)
  end

  # def self.stats
  #   zero = LibC::ULong.new(0)
  #   Stats.new(zero, zero, zero, zero, zero)
  # end

  def self.pthread_create(thread : LibC::PthreadT*, attr : LibC::PthreadAttrT*, start : Void* -> Void*, arg : Void*)
    LibC.pthread_create(thread, attr, start, arg)
  end

  # :nodoc:
  def self.pthread_join(thread : LibC::PthreadT) : Void*
    ret = LibC.pthread_join(thread, out value)
    raise "pthread_join" unless ret == 0
    value
  end

  # :nodoc:
  def self.pthread_detach(thread : LibC::PthreadT)
    LibC.pthread_detach(thread)
  end

  @@stack_bottom = Pointer(Void).null

  # :nodoc:
  def self.stack_bottom
    @@stack_bottom
  end

  # :nodoc:
  def self.stack_bottom=(@@stack_bottom : Void*)
    @@stack_bottom
  end

  # :nodoc:
  def self.push_stack(stack_top, stack_bottom)
  end

  # :nodoc:
  def self.before_collect(&block)
  end
end
