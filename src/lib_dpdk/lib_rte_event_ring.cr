lib LibDpdk
  fun rte_event_ring_count(r : RteEventRing*) : LibC::UInt
  fun rte_event_ring_create(name : LibC::Char*, count : LibC::UInt, socket_id : LibC::Int, flags : LibC::UInt) : RteEventRing*
  fun rte_event_ring_dequeue_burst(r : RteEventRing*, events : RteEvent*, n : LibC::UInt, available : Uint16T*) : LibC::UInt
  fun rte_event_ring_enqueue_burst(r : RteEventRing*, events : RteEvent*, n : LibC::UInt, free_space : Uint16T*) : LibC::UInt
  fun rte_event_ring_free(r : RteEventRing*)
  fun rte_event_ring_free_count(r : RteEventRing*) : LibC::UInt
  fun rte_event_ring_get_capacity(r : RteEventRing*) : LibC::UInt
  fun rte_event_ring_get_size(r : RteEventRing*) : LibC::UInt
  fun rte_event_ring_init(r : RteEventRing*, name : LibC::Char*, count : LibC::UInt, flags : LibC::UInt) : LibC::Int
  fun rte_event_ring_lookup(name : LibC::Char*) : RteEventRing*

  struct RteEventRing
    r : RteRing
  end
end
