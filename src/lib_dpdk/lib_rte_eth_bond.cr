lib LibDpdk
  fun rte_eth_bond_active_slaves_get(bonded_port_id : Uint8T, slaves : Uint8T*, len : Uint8T) : LibC::Int
  fun rte_eth_bond_create(name : LibC::Char*, mode : Uint8T, socket_id : Uint8T) : LibC::Int
  fun rte_eth_bond_free(name : LibC::Char*) : LibC::Int
  fun rte_eth_bond_link_down_prop_delay_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_link_down_prop_delay_set(bonded_port_id : Uint8T, delay_ms : Uint32T) : LibC::Int
  fun rte_eth_bond_link_monitoring_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_link_monitoring_set(bonded_port_id : Uint8T, internal_ms : Uint32T) : LibC::Int
  fun rte_eth_bond_link_up_prop_delay_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_link_up_prop_delay_set(bonded_port_id : Uint8T, delay_ms : Uint32T) : LibC::Int
  fun rte_eth_bond_mac_address_reset(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_mac_address_set(bonded_port_id : Uint8T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_eth_bond_mode_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_mode_set(bonded_port_id : Uint8T, mode : Uint8T) : LibC::Int
  fun rte_eth_bond_primary_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_primary_set(bonded_port_id : Uint8T, slave_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_slave_add(bonded_port_id : Uint8T, slave_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_slave_remove(bonded_port_id : Uint8T, slave_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_slaves_get(bonded_port_id : Uint8T, slaves : Uint8T*, len : Uint8T) : LibC::Int
  fun rte_eth_bond_xmit_policy_get(bonded_port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_xmit_policy_set(bonded_port_id : Uint8T, policy : Uint8T) : LibC::Int
end
