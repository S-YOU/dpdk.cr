lib LibDpdk
  fun rte_pmd_bnxt_get_vf_rx_status(port : Uint8T, vf_id : Uint16T) : LibC::Int
  fun rte_pmd_bnxt_get_vf_stats(port : Uint8T, vf_id : Uint16T, stats : RteEthStats*) : LibC::Int
  fun rte_pmd_bnxt_get_vf_tx_drop_count(port : Uint8T, vf_id : Uint16T, count : Uint64T*) : LibC::Int
  fun rte_pmd_bnxt_mac_addr_add(port : Uint8T, mac_addr : EtherAddr*, vf_id : Uint32T) : LibC::Int
  fun rte_pmd_bnxt_reset_vf_stats(port : Uint8T, vf_id : Uint16T) : LibC::Int
  fun rte_pmd_bnxt_set_all_queues_drop_en(port : Uint8T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_tx_loopback(port : Uint8T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_mac_addr(port : Uint8T, vf : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_pmd_bnxt_set_vf_mac_anti_spoof(port : Uint8T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_persist_stats(port : Uint8T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_rate_limit(port : Uint8T, vf : Uint16T, tx_rate : Uint16T, q_msk : Uint64T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_rxmode(port : Uint8T, vf : Uint16T, rx_mask : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_vlan_anti_spoof(port : Uint8T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_vlan_filter(port : Uint8T, vlan : Uint16T, vf_mask : Uint64T, vlan_on : Uint8T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_vlan_insert(port : Uint8T, vf : Uint16T, vlan_id : Uint16T) : LibC::Int
  fun rte_pmd_bnxt_set_vf_vlan_stripq(port : Uint8T, vf : Uint16T, on : Uint8T) : LibC::Int

  struct RtePmdBnxtMbEventParam
    vf_id : Uint16T
    retval : LibC::Int
    msg : Void*
  end
end
