lib LibDpdk
  fun malloc_get_numa_socket : LibC::UInt
  fun malloc_heap_alloc(heap : MallocHeap*, type : LibC::Char*, size : LibC::Int, flags : LibC::UInt, align : LibC::Int, bound : LibC::Int) : Void*
  fun malloc_heap_get_stats(heap : MallocHeap*, socket_stats : RteMallocSocketStats*) : LibC::Int
  fun rte_eal_malloc_heap_init : LibC::Int
end
