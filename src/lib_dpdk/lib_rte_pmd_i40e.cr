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
    RtePmdI40EPkgInfoMax             =   -1
  end
  enum RtePmdI40ePackageOp
    RtePmdI40EPkgOpUndefined =  0
    RtePmdI40EPkgOpWrAdd     =  1
    RtePmdI40EPkgOpWrDel     =  2
    RtePmdI40EPkgOpWrOnly    =  3
    RtePmdI40EPkgOpMax       = 32
  end
  fun rte_pmd_i40e_get_ddp_info(pkg : Uint8T*, pkg_size : Uint32T, info : Uint8T*, size : Uint32T, type : RtePmdI40ePackageInfo) : LibC::Int
  fun rte_pmd_i40e_get_ddp_list(port : Uint8T, buff : Uint8T*, size : Uint32T) : LibC::Int
  fun rte_pmd_i40e_get_vf_stats(port : Uint8T, vf_id : Uint16T, stats : RteEthStats*) : LibC::Int
  fun rte_pmd_i40e_ping_vfs(port : Uint8T, vf : Uint16T) : LibC::Int
  fun rte_pmd_i40e_process_ddp_package(port : Uint8T, buff : Uint8T*, size : Uint32T, op : RtePmdI40ePackageOp) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_get(port : Uint8T, mapping_items : RtePmdI40ePtypeMapping*, size : Uint16T, count : Uint16T*, valid_only : Uint8T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_replace(port : Uint8T, target : Uint32T, mask : Uint8T, pkt_type : Uint32T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_reset(port : Uint8T) : LibC::Int
  fun rte_pmd_i40e_ptype_mapping_update(port : Uint8T, mapping_items : RtePmdI40ePtypeMapping*, count : Uint16T, exclusive : Uint8T) : LibC::Int
  fun rte_pmd_i40e_reset_vf_stats(port : Uint8T, vf_id : Uint16T) : LibC::Int
  fun rte_pmd_i40e_set_tc_strict_prio(port : Uint8T, tc_map : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_tx_loopback(port : Uint8T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_broadcast(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_mac_addr(port : Uint8T, vf_id : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_pmd_i40e_set_vf_mac_anti_spoof(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_max_bw(port : Uint8T, vf_id : Uint16T, bw : Uint32T) : LibC::Int
  fun rte_pmd_i40e_set_vf_multicast_promisc(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_tc_bw_alloc(port : Uint8T, vf_id : Uint16T, tc_num : Uint8T, bw_weight : Uint8T*) : LibC::Int
  fun rte_pmd_i40e_set_vf_tc_max_bw(port : Uint8T, vf_id : Uint16T, tc_no : Uint8T, bw : Uint32T) : LibC::Int
  fun rte_pmd_i40e_set_vf_unicast_promisc(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_anti_spoof(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_filter(port : Uint8T, vlan_id : Uint16T, vf_mask : Uint64T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_insert(port : Uint8T, vf_id : Uint16T, vlan_id : Uint16T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_stripq(port : Uint8T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_i40e_set_vf_vlan_tag(port : Uint8T, vf_id : Uint16T, on : Uint8T) : LibC::Int

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

  struct RtePmdI40eMbEventParam
    vfid : Uint16T
    msg_type : Uint16T
    retval : Uint16T
    msg : Void*
    msglen : Uint16T
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

  struct RtePmdI40ePtypeMapping
    hw_ptype : Uint16T
    sw_ptype : Uint32T
  end
end
