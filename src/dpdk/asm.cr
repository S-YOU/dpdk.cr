require "../lib_dpdk"

class Dpdk
  @[AlwaysInline]
  @[Naked]
  def rte_prefetch0(p : Pointer) : Void
    {% if flag?(:x86_64) %}
      asm("prefetcht0 ($0)" :: "r"(p.as(Void*)))
    {% end %}
  end

  @[AlwaysInline]
  @[Naked]
  def rte_prefetch1(p : Pointer) : Void
    {% if flag?(:x86_64) %}
      asm("prefetcht1 ($0)" :: "r"(p.as(Void*)))
    {% end %}
  end

  @[AlwaysInline]
  @[Naked]
  def rte_prefetch2(p : Pointer) : Void
    {% if flag?(:x86_64) %}
      asm("prefetcht2 ($0)" :: "r"(p.as(Void*)))
    {% end %}
  end

  @[AlwaysInline]
  @[Naked]
  def rte_prefetch_non_temporal(p : Pointer) : Void
    {% if flag?(:x86_64) %}
      asm("prefetchnta ($0)" :: "r"(p.as(Void*)))
    {% end %}
  end

  @[AlwaysInline]
  @[Naked]
  # emmintrin.h pause implementation
  def _mm_pause
    {% if flag?(:x86_64) %}
      asm("rep; nop" : :)
    {% end %}
  end
end
