lib LibDpdk
  enum RtePmdI40ePackageInfo
    RtePmdI40EPkgInfoUndefined       =    0
    RtePmdI40EPkgInfoGlobalHeader    =    1
    RtePmdI40EPkgInfoGlobalNotesSize =    2
    RtePmdI40EPkgInfoGlobalNotes     =    3
    RtePmdI40EPkgInfoGlobalMax       = 1024
    RtePmdI40EPkgInfoHeader          = 1025
    RtePmdI40EPkgInfoDevidNum        = 1026
    RtePmdI40EPkgInfoDevidList       = 1027
    RtePmdI40EPkgInfoProtocolNum     = 1028
    RtePmdI40EPkgInfoProtocolList    = 1029
    RtePmdI40EPkgInfoPctypeNum       = 1030
    RtePmdI40EPkgInfoPctypeList      = 1031
    RtePmdI40EPkgInfoPtypeNum        = 1032
    RtePmdI40EPkgInfoPtypeList       = 1033
    RtePmdI40EPkgInfoMax             =   -1
  end
  enum RtePmdI40ePackageOp
    RtePmdI40EPkgOpUndefined =  0
    RtePmdI40EPkgOpWrAdd     =  1
    RtePmdI40EPkgOpWrDel     =  2
    RtePmdI40EPkgOpWrOnly    =  3
    RtePmdI40EPkgOpMax       = 32
  end
  enum RtePmdI40ePktTemplateBehavior
    RtePmdI40EPktTemplateAccept   = 0
    RtePmdI40EPktTemplateReject   = 1
    RtePmdI40EPktTemplatePassthru = 2
  end
  enum RtePmdI40ePktTemplateStatus
    RtePmdI40EPktTemplateNoReportStatus = 0
    RtePmdI40EPktTemplateReportId       = 1
    RtePmdI40EPktTemplateReportIdFlex4  = 2
    RtePmdI40EPktTemplateReportFlex8    = 3
  end
  enum RtePmdI40eQueueRegionOp
    RtePmdI40ERssQueueRegionUndefined       = 0
    RtePmdI40ERssQueueRegionSet             = 1
    RtePmdI40ERssQueueRegionFlowtypeSet     = 2
    RtePmdI40ERssQueueRegionUserPrioritySet = 3
    RtePmdI40ERssQueueRegionAllFlushOn      = 4
    RtePmdI40ERssQueueRegionAllFlushOff     = 5
    RtePmdI40ERssQueueRegionInfoGet         = 6
    RtePmdI40ERssQueueRegionOpMax           = 7
  end
  fun rte_pmd_i40e_add_vf_mac_addr(port : Uint16T, vf_id : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_pmd_i40e_flow_add_del_packet_template(port : Uint16T, conf : RtePmdI40ePktTemplateConf*, add : Uint8T) : LibC::Int
  fun rte_pmd_i40e_flow_type_mapping_get(port : Uint16T, mapping_items : RtePmdI40eFlowTypeMapping*) : LibC::Int
  fun rte_pmd_i40e_flow_type_mapping_reset(port : Uint16T) : LibC::Int
  fun rte_pmd_i40e_flow_type_mapping_update(port : Uint16T, mapping_items : RtePmdI40eFlowTypeMapping*, count : Uint16T, exclusive : Uint8T) : LibC::Int
  fun rte_pmd_i40e_get_ddp_info(pkg : Uint8T*, pkg_size : Uint32T, info : Uint8T*, size : Uint32T, type : RtePmdI40ePackageInfo) : LibC::Int
  fun rte_pmd_i40e_get_ddp_list(port : Uint16T, buff : Uint8T*, size : Uint32T) : LibC::Int
  fun rte_pmd_i40e_get_vf_stats(port : Uint16T, vf_id : Uint16T, stats : RteEthStats*) : LibC::Int
  fun rte_pmd_i40e_ping_vfs(port : Uint16T, vf : Uint16T) : LibC::Int
  fun rte_pmd_i40e_process_ddp_package(port : Uint16T, buff : Uint8T*, size : Uint32T, op : RtePmdI40ePackageOp) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_get(port : Uint16T, mapping_items : RtePmdI40ePtypeMapping*, size : Uint16T, count : Uint16T*, valid_only : Uint8T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_replace(port : Uint16T, target : Uint32T, mask : Uint8T, pkt_type : Uint32T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_reset(port : Uint16T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_update(port : Uint16T, mapping_items : RtePmdI40ePtypeMapping*, count : Uint16T, exclusive : Uint8T) : LibC::Int
  fun rte_pmd_i40e_query_vfid_by_mac(port : Uint16T, vf_mac : EtherAddr*) : LibC::Int
  fun rte_pmd_i40e_reset_vf_stats(port : Uint16T, vf_id : Uint16T) : LibC::Int
  fun rte_pmd_i40e_rss_queue_region_conf(port_id : Uint16T, op_type : RtePmdI40eQueueRegionOp, arg : Void*) : LibC::Int
  fun rte_pmd_i40e_set_tc_strict_prio(port : Uint16T, tc_map : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_tx_loopback(port : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_broadcast(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_mac_addr(port : Uint16T, vf_id : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_pmd_i40e_set_vf_mac_anti_spoof(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_max_bw(port : Uint16T, vf_id : Uint16T, bw : Uint32T) : LibC::Int
  fun rte_pmd_i40e_set_vf_multicast_promisc(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_tc_bw_alloc(port : Uint16T, vf_id : Uint16T, tc_num : Uint8T, bw_weight : Uint8T*) : LibC::Int
  fun rte_pmd_i40e_set_vf_tc_max_bw(port : Uint16T, vf_id : Uint16T, tc_no : Uint8T, bw : Uint32T) : LibC::Int
  fun rte_pmd_i40e_set_vf_unicast_promisc(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_anti_spoof(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_filter(port : Uint16T, vlan_id : Uint16T, vf_mask : Uint64T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_insert(port : Uint16T, vf_id : Uint16T, vlan_id : Uint16T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_stripq(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_tag(port : Uint16T, vf_id : Uint16T, on : Uint8T) : LibC::Int

  struct RtePmdI40eDdpDeviceId
    vendor_dev_id : Uint32T
    sub_vendor_dev_id : Uint32T
  end

  struct RtePmdI40eDdpVersion
    major : Uint8T
    minor : Uint8T
    update : Uint8T
    draft : Uint8T
  end

  struct RtePmdI40eFlowTypeMapping
    flow_type : Uint16T
    pctype : Uint64T
  end

  struct RtePmdI40eMbEventParam
    vfid : Uint16T
    msg_type : Uint16T
    retval : Uint16T
    msg : Void*
    msglen : Uint16T
  end

  struct RtePmdI40ePktTemplateAction
    rx_queue : Uint16T
    behavior : RtePmdI40ePktTemplateBehavior
    report_status : RtePmdI40ePktTemplateStatus
    flex_off : Uint8T
  end

  struct RtePmdI40ePktTemplateConf
    input : RtePmdI40ePktTemplateInput
    action : RtePmdI40ePktTemplateAction
    soft_id : Uint32T
  end

  struct RtePmdI40ePktTemplateInput
    pctype : Uint16T
    packet : Void*
    length : Uint32T
  end

  struct RtePmdI40eProfileInfo
    track_id : Uint32T
    version : RtePmdI40eDdpVersion
    owner : Uint8T
    reserved : Uint8T[7]
    name : Uint8T[32]
  end

  struct RtePmdI40eProfileList
    p_count : Uint32T
    p_info : RtePmdI40eProfileInfo[1]
  end

  struct RtePmdI40eProtoInfo
    proto_id : Uint8T
    name : LibC::Char[32]
  end

  struct RtePmdI40ePtypeInfo
    ptype_id : Uint8T
    protocols : Uint8T[6]
  end

  struct RtePmdI40ePtypeMapping
    hw_ptype : Uint16T
    sw_ptype : Uint32T
  end

  struct RtePmdI40eQueueRegionConf
    region_id : Uint8T
    hw_flowtype : Uint8T
    queue_start_index : Uint8T
    queue_num : Uint8T
    user_priority : Uint8T
  end

  struct RtePmdI40eQueueRegionInfo
    region_id : Uint8T
    queue_start_index : Uint8T
    queue_num : Uint8T
    user_priority_num : Uint8T
    user_priority : Uint8T[8]
    flowtype_num : Uint8T
    hw_flowtype : Uint8T[64]
  end

  struct RtePmdI40eQueueRegions
    queue_region_number : Uint16T
    region : RtePmdI40eQueueRegionInfo[8]
  end
end
