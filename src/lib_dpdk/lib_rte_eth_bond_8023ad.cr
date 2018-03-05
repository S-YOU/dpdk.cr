lib LibDpdk
  alias RteEthBond8023adExtSlowrxFn = (Uint8T, RteMbuf* -> Void)
  enum RteBond8023adAggSelection
    AggBandwidth = 0
    AggCount     = 1
    AggStable    = 2
  end
  enum RteBond8023adSelection
    Unselected = 0
    Standby    = 1
    Selected   = 2
  end
  fun rte_eth_bond_8023ad_agg_selection_get(port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_8023ad_agg_selection_set(port_id : Uint8T, agg_selection : RteBond8023adAggSelection) : LibC::Int
  fun rte_eth_bond_8023ad_conf_get(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_conf_get_v1607(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_conf_get_v1708(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_conf_get_v20(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_dedicated_queues_disable(port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_8023ad_dedicated_queues_enable(port_id : Uint8T) : LibC::Int
  fun rte_eth_bond_8023ad_ext_collect(port_id : Uint8T, slave_id : Uint8T, enabled : LibC::Int) : LibC::Int
  fun rte_eth_bond_8023ad_ext_collect_get(port_id : Uint8T, slave_id : Uint8T) : LibC::Int
  fun rte_eth_bond_8023ad_ext_distrib(port_id : Uint8T, slave_id : Uint8T, enabled : LibC::Int) : LibC::Int
  fun rte_eth_bond_8023ad_ext_distrib_get(port_id : Uint8T, slave_id : Uint8T) : LibC::Int
  fun rte_eth_bond_8023ad_ext_slowtx(port_id : Uint8T, slave_id : Uint8T, lacp_pkt : RteMbuf*) : LibC::Int
  fun rte_eth_bond_8023ad_setup(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_setup_v1607(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_setup_v1708(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_setup_v20(port_id : Uint8T, conf : RteEthBond8023adConf*) : LibC::Int
  fun rte_eth_bond_8023ad_slave_info(port_id : Uint8T, slave_id : Uint8T, conf : RteEthBond8023adSlaveInfo*) : LibC::Int

  struct PortParams
    system_priority : Uint16T
    system : EtherAddr
    key : Uint16T
    port_priority : Uint16T
    port_number : Uint16T
  end

  struct RteEthBond8023adConf
    fast_periodic_ms : Uint32T
    slow_periodic_ms : Uint32T
    short_timeout_ms : Uint32T
    long_timeout_ms : Uint32T
    aggregate_wait_timeout_ms : Uint32T
    tx_period_ms : Uint32T
    rx_marker_period_ms : Uint32T
    update_timeout_ms : Uint32T
    slowrx_cb : RteEthBond8023adExtSlowrxFn
    agg_selection : RteBond8023adAggSelection
  end

  struct RteEthBond8023adSlaveInfo
    selected : RteBond8023adSelection
    actor_state : Uint8T
    actor : PortParams
    partner_state : Uint8T
    partner : PortParams
    agg_port_id : Uint8T
  end
end
