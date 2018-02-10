lib LibDpdk
  alias RtePipeline = Void
  alias RtePipelinePortInActionHandler = (RtePipeline*, RteMbuf**, Uint32T, Void* -> LibC::Int)
  alias RtePipelinePortOutActionHandler = (RtePipeline*, RteMbuf**, Uint64T, Void* -> LibC::Int)
  alias RtePipelineTableActionHandlerHit = (RtePipeline*, RteMbuf**, Uint64T, RtePipelineTableEntry**, Void* -> LibC::Int)
  alias RtePipelineTableActionHandlerMiss = (RtePipeline*, RteMbuf**, Uint64T, RtePipelineTableEntry*, Void* -> LibC::Int)
  enum RtePipelineAction
    RtePipelineActionDrop     = 0
    RtePipelineActionPort     = 1
    RtePipelineActionPortMeta = 2
    RtePipelineActionTable    = 3
    RtePipelineActions        = 4
  end
  fun rte_pipeline_ah_packet_drop(p : RtePipeline*, pkts_mask : Uint64T) : LibC::Int
  fun rte_pipeline_ah_packet_hijack(p : RtePipeline*, pkts_mask : Uint64T) : LibC::Int
  fun rte_pipeline_check(p : RtePipeline*) : LibC::Int
  fun rte_pipeline_create(params : RtePipelineParams*) : RtePipeline*
  fun rte_pipeline_flush(p : RtePipeline*) : LibC::Int
  fun rte_pipeline_free(p : RtePipeline*) : LibC::Int
  fun rte_pipeline_port_in_connect_to_table(p : RtePipeline*, port_id : Uint32T, table_id : Uint32T) : LibC::Int
  fun rte_pipeline_port_in_create(p : RtePipeline*, params : RtePipelinePortInParams*, port_id : Uint32T*) : LibC::Int
  fun rte_pipeline_port_in_disable(p : RtePipeline*, port_id : Uint32T) : LibC::Int
  fun rte_pipeline_port_in_enable(p : RtePipeline*, port_id : Uint32T) : LibC::Int
  fun rte_pipeline_port_in_stats_read(p : RtePipeline*, port_id : Uint32T, stats : RtePipelinePortInStats*, clear : LibC::Int) : LibC::Int
  fun rte_pipeline_port_out_create(p : RtePipeline*, params : RtePipelinePortOutParams*, port_id : Uint32T*) : LibC::Int
  fun rte_pipeline_port_out_packet_insert(p : RtePipeline*, port_id : Uint32T, pkt : RteMbuf*) : LibC::Int
  fun rte_pipeline_port_out_stats_read(p : RtePipeline*, port_id : Uint32T, stats : RtePipelinePortOutStats*, clear : LibC::Int) : LibC::Int
  fun rte_pipeline_run(p : RtePipeline*) : LibC::Int
  fun rte_pipeline_table_create(p : RtePipeline*, params : RtePipelineTableParams*, table_id : Uint32T*) : LibC::Int
  fun rte_pipeline_table_default_entry_add(p : RtePipeline*, table_id : Uint32T, default_entry : RtePipelineTableEntry*, default_entry_ptr : RtePipelineTableEntry**) : LibC::Int
  fun rte_pipeline_table_default_entry_delete(p : RtePipeline*, table_id : Uint32T, entry : RtePipelineTableEntry*) : LibC::Int
  fun rte_pipeline_table_entry_add(p : RtePipeline*, table_id : Uint32T, key : Void*, entry : RtePipelineTableEntry*, key_found : LibC::Int*, entry_ptr : RtePipelineTableEntry**) : LibC::Int
  fun rte_pipeline_table_entry_add_bulk(p : RtePipeline*, table_id : Uint32T, keys : Void**, entries : RtePipelineTableEntry**, n_keys : Uint32T, key_found : LibC::Int*, entries_ptr : RtePipelineTableEntry**) : LibC::Int
  fun rte_pipeline_table_entry_delete(p : RtePipeline*, table_id : Uint32T, key : Void*, key_found : LibC::Int*, entry : RtePipelineTableEntry*) : LibC::Int
  fun rte_pipeline_table_entry_delete_bulk(p : RtePipeline*, table_id : Uint32T, keys : Void**, n_keys : Uint32T, key_found : LibC::Int*, entries : RtePipelineTableEntry**) : LibC::Int
  fun rte_pipeline_table_stats_read(p : RtePipeline*, table_id : Uint32T, stats : RtePipelineTableStats*, clear : LibC::Int) : LibC::Int

  struct RtePipelineParams
    name : LibC::Char*
    socket_id : LibC::Int
    offset_port_id : Uint32T
  end

  struct RtePipelinePortInParams
    ops : RtePortInOps*
    arg_create : Void*
    f_action : RtePipelinePortInActionHandler
    arg_ah : Void*
    burst_size : Uint32T
  end

  struct RtePipelinePortInStats
    stats : RtePortInStats
    n_pkts_dropped_by_ah : Uint64T
  end

  struct RtePipelinePortOutParams
    ops : RtePortOutOps*
    arg_create : Void*
    f_action : RtePipelinePortOutActionHandler
    arg_ah : Void*
  end

  struct RtePipelinePortOutStats
    stats : RtePortOutStats
    n_pkts_dropped_by_ah : Uint64T
  end

  struct RtePipelineTableEntry
    action : RtePipelineAction
    action_data : Uint8T[0]
  end

  struct RtePipelineTableParams
    ops : RteTableOps*
    arg_create : Void*
    f_action_hit : RtePipelineTableActionHandlerHit
    f_action_miss : RtePipelineTableActionHandlerMiss
    arg_ah : Void*
    action_data_size : Uint32T
  end

  struct RtePipelineTableStats
    stats : RteTableStats
    n_pkts_dropped_by_lkp_hit_ah : Uint64T
    n_pkts_dropped_by_lkp_miss_ah : Uint64T
    n_pkts_dropped_lkp_hit : Uint64T
    n_pkts_dropped_lkp_miss : Uint64T
  end
end
