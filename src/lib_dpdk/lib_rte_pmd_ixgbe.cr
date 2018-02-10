lib LibDpdk
  fun rte_pmd_ixgbe_bypass_event_show(port : Uint16T, event : Uint32T, state : Uint32T*) : LibC::Int
  fun rte_pmd_ixgbe_bypass_event_store(port : Uint16T, event : Uint32T, state : Uint32T) : LibC::Int
  fun rte_pmd_ixgbe_bypass_init(port : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_bypass_state_set(port : Uint16T, new_state : Uint32T*) : LibC::Int
  fun rte_pmd_ixgbe_bypass_state_show(port : Uint16T, state : Uint32T*) : LibC::Int
  fun rte_pmd_ixgbe_bypass_ver_show(port : Uint16T, ver : Uint32T*) : LibC::Int
  fun rte_pmd_ixgbe_bypass_wd_reset(port : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_bypass_wd_timeout_show(port : Uint16T, wd_timeout : Uint32T*) : LibC::Int
  fun rte_pmd_ixgbe_bypass_wd_timeout_store(port : Uint16T, timeout : Uint32T) : LibC::Int
  fun rte_pmd_ixgbe_macsec_config_rxsc(port : Uint16T, mac : Uint8T*, pi : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_macsec_config_txsc(port : Uint16T, mac : Uint8T*) : LibC::Int
  fun rte_pmd_ixgbe_macsec_disable(port : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_macsec_enable(port : Uint16T, en : Uint8T, rp : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_macsec_select_rxsa(port : Uint16T, idx : Uint8T, an : Uint8T, pn : Uint32T, key : Uint8T*) : LibC::Int
  fun rte_pmd_ixgbe_macsec_select_txsa(port : Uint16T, idx : Uint8T, an : Uint8T, pn : Uint32T, key : Uint8T*) : LibC::Int
  fun rte_pmd_ixgbe_ping_vf(port : Uint16T, vf : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_set_all_queues_drop_en(port : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_tc_bw_alloc(port : Uint16T, tc_num : Uint8T, bw_weight : Uint8T*) : LibC::Int
  fun rte_pmd_ixgbe_set_tx_loopback(port : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_mac_addr(port : Uint16T, vf : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_mac_anti_spoof(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_rate_limit(port : Uint16T, vf : Uint16T, tx_rate : Uint16T, q_msk : Uint64T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_rx(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_rxmode(port : Uint16T, vf : Uint16T, rx_mask : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_split_drop_en(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_tx(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_vlan_anti_spoof(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_vlan_filter(port : Uint16T, vlan : Uint16T, vf_mask : Uint64T, vlan_on : Uint8T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_vlan_insert(port : Uint16T, vf : Uint16T, vlan_id : Uint16T) : LibC::Int
  fun rte_pmd_ixgbe_set_vf_vlan_stripq(port : Uint16T, vf : Uint16T, on : Uint8T) : LibC::Int

  struct RtePmdIxgbeMbEventParam
    vfid : Uint16T
    msg_type : Uint16T
    retval : Uint16T
    msg : Void*
  end
end
