lib LibDpdk
  # alias MallocHeap = Void
  enum ElemState
    ElemFree = 0
    ElemBusy = 1
    ElemPad  = 2
  end
  fun malloc_elem_alloc(elem : MallocElem*, size : LibC::Int, align : LibC::UInt, bound : LibC::Int) : MallocElem*
  fun malloc_elem_can_hold(elem : MallocElem*, size : LibC::Int, align : LibC::UInt, bound : LibC::Int) : LibC::Int
  fun malloc_elem_cookies_ok(elem : MallocElem*) : LibC::Int
  fun malloc_elem_free(elem : MallocElem*) : LibC::Int
  fun malloc_elem_free_list_index : LibC::Int
  fun malloc_elem_free_list_insert(elem : MallocElem*)
  fun malloc_elem_from_data(data : Void*) : MallocElem*
  fun malloc_elem_init(elem : MallocElem*, heap : MallocHeap*, ms : RteMemseg*, size : LibC::Int)
  fun malloc_elem_mkend(elem : MallocElem*, prev_free : MallocElem*)
  fun malloc_elem_resize(elem : MallocElem*, size : LibC::Int) : LibC::Int

  struct MallocElem
    heap : MallocHeap*
    prev : MallocElem*
    list_entry : Void*
    ms : RteMemseg*
    state : ElemState
    pad : Uint32T
    size : LibC::Int
  end
end
