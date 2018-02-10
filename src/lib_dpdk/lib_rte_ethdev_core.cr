lib LibDpdk
  # alias EthDevSupportedPtypesGetT = (RteEthDev* -> LibC::Int*)
  # alias EthFilterCtrlT = (RteEthDev*, Void, Void, Void* -> LibC::Int)
  # alias EthL2TunnelOffloadSetT = (RteEthDev*, RteEthL2TunnelConf*, Uint32T, LibC::Int -> LibC::Int)
  # alias EthMirrorRuleResetT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthMirrorRuleSetT = (RteEthDev*, RteEthMirrorConf*, LibC::Int, LibC::Int -> LibC::Int)
  # alias EthQueueStartT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthQueueStatsMappingSetT = (RteEthDev*, LibC::Int, LibC::Int, LibC::Int -> LibC::Int)
  # alias EthQueueStopT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthRxDescriptorDoneT = (Void*, LibC::Int -> LibC::Int)
  # alias EthRxDescriptorStatusT = (Void*, LibC::Int -> LibC::Int)
  # alias EthRxDisableIntrT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthRxEnableIntrT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthRxQueueSetupT = (RteEthDev*, LibC::Int, LibC::Int, LibC::UInt, RteEthRxconf*, RteMempool* -> LibC::Int)
  # alias EthRxqInfoGetT = (RteEthDev*, LibC::Int, RteEthRxqInfo* -> Void)
  # alias EthTimesyncAdjustTime = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthTxBurstT = (Void*, RteMbuf**, Uint16T -> LibC::Int)
  # alias EthTxDescriptorStatusT = (Void*, LibC::Int -> LibC::Int)
  # alias EthTxPrepT = (Void*, RteMbuf**, Uint16T -> LibC::Int)
  # alias EthTxQueueSetupT = (RteEthDev*, LibC::Int, LibC::Int, LibC::UInt, RteEthTxconf* -> LibC::Int)
  # alias EthTxqInfoGetT = (RteEthDev*, LibC::Int, RteEthTxqInfo* -> Void)
  # alias EthUcAllHashTableSetT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias EthUcHashTableSetT = (RteEthDev*, EtherAddr*, LibC::Int -> LibC::Int)
  # alias EthXstatsGetByIdT = (RteEthDev*, LibC::Int*, LibC::Int*, LibC::UInt -> LibC::Int)
  # alias EthXstatsGetNamesByIdT = (RteEthDev*, RteEthXstatName*, LibC::Int*, LibC::UInt -> LibC::Int)
  # alias EtherAddr = Void
  # alias MtuSetT = (RteEthDev*, LibC::Int -> LibC::Int)
  # alias RteDevEepromInfo = Void
  # alias RteDevRegInfo = Void
  # alias RteEthDcbInfo = Void
  # alias RteEthDevInfo = Void
  # alias RteEthDevOwner = Void
  # alias RteEthDevSriov = Void
  # alias RteEthFcConf = Void
  # alias RteEthL2TunnelConf = Void
  # alias RteEthMirrorConf = Void
  # alias RteEthPfcConf = Void
  # alias RteEthRssConf = Void
  # alias RteEthRssRetaEntry64 = Void
  # alias RteEthRxconf = Void
  # alias RteEthRxqInfo = Void
  # alias RteEthStats = Void
  # alias RteEthTxconf = Void
  # alias RteEthTxqInfo = Void
  # alias RteEthUdpTunnel = Void
  # alias RteEthXstat = Void
  # alias RteEthXstatName = Void
  # alias RteMempool = Void
  # alias Timespec = Void
  # alias Uint16T = (LibC::Int* -> LibC::Int)
  # alias Uint32T = (LibC::Int* -> LibC::Int)
  # alias VlanFilterSetT = (RteEthDev*, LibC::Int, LibC::Int -> LibC::Int)
  # alias VlanPvidSetT = (RteEthDev*, LibC::Int, LibC::Int -> LibC::Int)
  # alias VlanStripQueueSetT = (RteEthDev*, LibC::Int, LibC::Int -> Void)
  # alias VlanTpidSetT = (RteEthDev*, Void, LibC::Int -> LibC::Int)

  # struct EthDevOps
  #   dev_configure : EthDevConfigureT
  #   dev_start : EthDevStartT
  #   dev_stop : EthDevStopT
  #   dev_set_link_up : EthDevSetLinkUpT
  #   dev_set_link_down : EthDevSetLinkDownT
  #   dev_close : EthDevCloseT
  #   dev_reset : EthDevResetT
  #   link_update : EthLinkUpdateT
  #   is_removed : EthIsRemovedT
  #   promiscuous_enable : EthPromiscuousEnableT
  #   promiscuous_disable : EthPromiscuousDisableT
  #   allmulticast_enable : EthAllmulticastEnableT
  #   allmulticast_disable : EthAllmulticastDisableT
  #   mac_addr_remove : EthMacAddrRemoveT
  #   mac_addr_add : EthMacAddrAddT
  #   mac_addr_set : EthMacAddrSetT
  #   set_mc_addr_list : EthSetMcAddrListT
  #   mtu_set : MtuSetT
  #   stats_get : EthStatsGetT
  #   stats_reset : EthStatsResetT
  #   xstats_get : EthXstatsGetT
  #   xstats_reset : EthXstatsResetT
  #   xstats_get_names : EthXstatsGetNamesT
  #   queue_stats_mapping_set : EthQueueStatsMappingSetT
  #   dev_infos_get : EthDevInfosGetT
  #   rxq_info_get : EthRxqInfoGetT
  #   txq_info_get : EthTxqInfoGetT
  #   fw_version_get : EthFwVersionGetT
  #   dev_supported_ptypes_get : EthDevSupportedPtypesGetT
  #   vlan_filter_set : VlanFilterSetT
  #   vlan_tpid_set : VlanTpidSetT
  #   vlan_strip_queue_set : VlanStripQueueSetT
  #   vlan_offload_set : VlanOffloadSetT
  #   vlan_pvid_set : VlanPvidSetT
  #   rx_queue_start : EthQueueStartT
  #   rx_queue_stop : EthQueueStopT
  #   tx_queue_start : EthQueueStartT
  #   tx_queue_stop : EthQueueStopT
  #   rx_queue_setup : EthRxQueueSetupT
  #   rx_queue_release : EthQueueReleaseT
  #   rx_queue_count : LibC::Int
  #   rx_descriptor_done : EthRxDescriptorDoneT
  #   rx_descriptor_status : EthRxDescriptorStatusT
  #   tx_descriptor_status : EthTxDescriptorStatusT
  #   rx_queue_intr_enable : EthRxEnableIntrT
  #   rx_queue_intr_disable : EthRxDisableIntrT
  #   tx_queue_setup : EthTxQueueSetupT
  #   tx_queue_release : EthQueueReleaseT
  #   tx_done_cleanup : EthTxDoneCleanupT
  #   dev_led_on : EthDevLedOnT
  #   dev_led_off : EthDevLedOffT
  #   flow_ctrl_get : FlowCtrlGetT
  #   flow_ctrl_set : FlowCtrlSetT
  #   priority_flow_ctrl_set : PriorityFlowCtrlSetT
  #   uc_hash_table_set : EthUcHashTableSetT
  #   uc_all_hash_table_set : EthUcAllHashTableSetT
  #   mirror_rule_set : EthMirrorRuleSetT
  #   mirror_rule_reset : EthMirrorRuleResetT
  #   udp_tunnel_port_add : EthUdpTunnelPortAddT
  #   udp_tunnel_port_del : EthUdpTunnelPortDelT
  #   l2_tunnel_eth_type_conf : EthL2TunnelEthTypeConfT
  #   l2_tunnel_offload_set : EthL2TunnelOffloadSetT
  #   set_queue_rate_limit : EthSetQueueRateLimitT
  #   rss_hash_update : RssHashUpdateT
  #   rss_hash_conf_get : RssHashConfGetT
  #   reta_update : RetaUpdateT
  #   reta_query : RetaQueryT
  #   get_reg : EthGetRegT
  #   get_eeprom_length : EthGetEepromLengthT
  #   get_eeprom : EthGetEepromT
  #   set_eeprom : EthSetEepromT
  #   filter_ctrl : EthFilterCtrlT
  #   get_dcb_info : EthGetDcbInfo
  #   timesync_enable : EthTimesyncEnableT
  #   timesync_disable : EthTimesyncDisableT
  #   timesync_read_rx_timestamp : EthTimesyncReadRxTimestampT
  #   timesync_read_tx_timestamp : EthTimesyncReadTxTimestampT
  #   timesync_adjust_time : EthTimesyncAdjustTime
  #   timesync_read_time : EthTimesyncReadTime
  #   timesync_write_time : EthTimesyncWriteTime
  #   xstats_get_by_id : EthXstatsGetByIdT
  #   xstats_get_names_by_id : EthXstatsGetNamesByIdT
  #   tm_ops_get : EthTmOpsGetT
  #   mtr_ops_get : EthMtrOpsGetT
  #   pool_ops_supported : EthPoolOpsSupportedT
  # end

  # struct RteEthDev
  #   rx_pkt_burst : LibC::Int
  #   tx_pkt_burst : EthTxBurstT
  #   tx_pkt_prepare : EthTxPrepT
  #   data : RteEthDevData*
  #   dev_ops : EthDevOps*
  #   device : Void*
  #   intr_handle : Void*
  #   link_intr_cbs : Void
  #   post_rx_burst_cbs : RteEthRxtxCallback*
  #   pre_tx_burst_cbs : RteEthRxtxCallback*
  #   state : Void
  #   security_ctx : Void*
  # end

  # struct RteEthDevData
  #   name : LibC::Char
  #   rx_queues : Void**
  #   tx_queues : Void**
  #   nb_rx_queues : Uint16T
  #   nb_tx_queues : Uint16T
  #   sriov : Void
  #   dev_private : Void*
  #   dev_link : Void
  #   dev_conf : Void
  #   mtu : Uint16T
  #   min_rx_buf_size : Uint32T
  #   rx_mbuf_alloc_failed : LibC::Int
  #   mac_addrs : EtherAddr*
  #   mac_pool_sel : LibC::Int
  #   hash_mac_addrs : EtherAddr*
  #   port_id : Uint16T
  #   promiscuous : LibC::Int
  #   scattered_rx : LibC::Int
  #   all_multicast : LibC::Int
  #   dev_started : LibC::Int
  #   lro : LibC::Int
  #   rx_queue_state : LibC::Int
  #   tx_queue_state : LibC::Int
  #   dev_flags : Uint32T
  #   kdrv : Void
  #   numa_node : LibC::Int
  #   vlan_filter_conf : Void
  #   owner : Void
  # end

  # union RteEthRxtxCallbackFn
  #   rx : LibC::Int
  #   tx : LibC::Int
  # end
end
