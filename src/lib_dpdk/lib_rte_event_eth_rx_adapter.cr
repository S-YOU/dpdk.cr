lib LibDpdk
  alias RteEventEthRxAdapterConfCb = (Uint8T, Uint8T, RteEventEthRxAdapterConf*, Void* -> LibC::Int)
  fun rte_event_eth_rx_adapter_create(id : Uint8T, dev_id : Uint8T, port_config : RteEventPortConf*) : LibC::Int
  fun rte_event_eth_rx_adapter_create_ext(id : Uint8T, dev_id : Uint8T, conf_cb : RteEventEthRxAdapterConfCb, conf_arg : Void*) : LibC::Int
  fun rte_event_eth_rx_adapter_free(id : Uint8T) : LibC::Int
  fun rte_event_eth_rx_adapter_queue_add(id : Uint8T, eth_dev_id : Uint8T, rx_queue_id : Int32T, conf : RteEventEthRxAdapterQueueConf*) : LibC::Int
  fun rte_event_eth_rx_adapter_queue_del(id : Uint8T, eth_dev_id : Uint8T, rx_queue_id : Int32T) : LibC::Int
  fun rte_event_eth_rx_adapter_service_id_get(id : Uint8T, service_id : Uint32T*) : LibC::Int
  fun rte_event_eth_rx_adapter_start(id : Uint8T) : LibC::Int
  fun rte_event_eth_rx_adapter_stats_get(id : Uint8T, stats : RteEventEthRxAdapterStats*) : LibC::Int
  fun rte_event_eth_rx_adapter_stats_reset(id : Uint8T) : LibC::Int
  fun rte_event_eth_rx_adapter_stop(id : Uint8T) : LibC::Int

  struct RteEventEthRxAdapterConf
    event_port_id : Uint8T
    max_nb_rx : Uint32T
  end

  struct RteEventEthRxAdapterQueueConf
    rx_queue_flags : Uint32T
    servicing_weight : Uint16T
    ev : RteEvent*
  end

  struct RteEventEthRxAdapterStats
    rx_poll_count : Uint64T
    rx_packets : Uint64T
    rx_enq_count : Uint64T
    rx_enq_retry : Uint64T
    rx_enq_start_ts : Uint64T
    rx_enq_block_cycles : Uint64T
    rx_enq_end_ts : Uint64T
  end
end
