lib LibDpdk
  fun rte_eth_vhost_get_queue_event(port_id : Uint16T, event : RteEthVhostQueueEvent*) : LibC::Int
  fun rte_eth_vhost_get_vid_from_port_id(port_id : Uint16T) : LibC::Int

  struct RteEthVhostQueueEvent
    queue_id : Uint16T
    rx : LibC::Int
    enable : LibC::Int
  end
end
