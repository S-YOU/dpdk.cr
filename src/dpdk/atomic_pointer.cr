# :nodoc:
struct AtomicPointer(T)
  # Creates an AtomicPointer with the given initial pointer
  def initialize(@ptr : T*)
  end

  def add(value : T)
    Ops.atomicrmw(:add, @ptr, value, :sequentially_consistent, false)
  end

  # :nodoc:
  module Ops
    # Defines methods that directly map to LLVM instructions related to atomic operations.

    @[Primitive(:atomicrmw)]
    def self.atomicrmw(op : Symbol, ptr : T*, val : T, ordering : Symbol, singlethread : Bool) : T forall T
    end
  end
end
