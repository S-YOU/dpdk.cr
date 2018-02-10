lib LibDpdk
  fun __rte_bitmap_get_memory_footprint(n_bits : Uint32T, array1_byte_offset : Uint32T*, array1_slabs : Uint32T*, array2_byte_offset : Uint32T*, array2_slabs : Uint32T*) : Uint32T
  fun __rte_bitmap_index1_inc(bmp : RteBitmap*)
  fun __rte_bitmap_index2_set(bmp : RteBitmap*)
  fun __rte_bitmap_line_not_empty(slab2 : Uint64T*) : Uint64T
  fun __rte_bitmap_mask1_get(bmp : RteBitmap*) : Uint64T
  fun __rte_bitmap_scan_init(bmp : RteBitmap*)
  fun __rte_bitmap_scan_read(bmp : RteBitmap*, pos : Uint32T*, slab : Uint64T*) : LibC::Int
  fun __rte_bitmap_scan_read_init(bmp : RteBitmap*)
  fun __rte_bitmap_scan_search(bmp : RteBitmap*) : LibC::Int
  fun rte_bitmap_clear(bmp : RteBitmap*, pos : Uint32T)
  fun rte_bitmap_free(bmp : RteBitmap*) : LibC::Int
  fun rte_bitmap_get(bmp : RteBitmap*, pos : Uint32T) : Uint64T
  fun rte_bitmap_get_memory_footprint(n_bits : Uint32T) : Uint32T
  fun rte_bitmap_init(n_bits : Uint32T, mem : Uint8T*, mem_size : Uint32T) : RteBitmap*
  fun rte_bitmap_prefetch0(bmp : RteBitmap*, pos : Uint32T)
  fun rte_bitmap_reset(bmp : RteBitmap*)
  fun rte_bitmap_scan(bmp : RteBitmap*, pos : Uint32T*, slab : Uint64T*) : LibC::Int
  fun rte_bitmap_set(bmp : RteBitmap*, pos : Uint32T)
  fun rte_bitmap_set_slab(bmp : RteBitmap*, pos : Uint32T, slab : Uint64T)
  fun rte_bsf64(slab : Uint64T, pos : Uint32T*) : LibC::Int

  struct RteBitmap
    array1 : Uint64T*
    array2 : Uint64T*
    array1_size : Uint32T
    array2_size : Uint32T
    index1 : Uint32T
    offset1 : Uint32T
    index2 : Uint32T
    go2 : Uint32T
    memory : Uint8T*
  end
end
