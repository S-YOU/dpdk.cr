@[Link(ldflags: "-Wl,--whole-archive -Wl,--start-group -lrte_jobstats -lrte_pipeline -lrte_pmd_ixgbe -lrte_acl -lrte_kni -lrte_pmd_kni -lrte_pmd_vhost -lrte_bitratestats -lrte_kvargs -lrte_pmd_virtio -lrte_cfgfile -lrte_latencystats -lrte_cmdline -lrte_lpm -lrte_pmd_null -lrte_port -lrte_cryptodev -lrte_mbuf -lrte_pmd_null_crypto -lrte_power -lrte_distributor -lrte_mempool -lrte_pmd_crypto_scheduler -lrte_reorder -lrte_eal -lrte_mempool_ring -lrte_ring -lrte_efd -lrte_mempool_stack -lrte_pmd_e1000 -lrte_sched -lrte_ethdev -lrte_meter -lrte_table -lrte_eventdev -lrte_metrics -lrte_pmd_skeleton_event -lrte_pmd_i40e -lrte_timer -lrte_pci -lrte_bus_pci -lrte_bus_vdev -lrte_hash -lrte_net -lrte_vhost -lrte_pmd_af_packet -lrte_ip_frag -lrte_pdump -lrte_pmd_tap -Wl,--end-group -Wl,--no-whole-archive -lnuma -ldl -lpthread -lm #{__DIR__}/../ext/libdpdk.a")]
lib LibDpdk
  alias RteAclCtx = Void
  alias RteFlow = Void
  alias RteKni = Void
  alias RteSchedPort = Void
  alias RteCryptodevCallback = Void
  alias RteEthDevCallback = Void
  alias RteLogDynamicType = Void
  alias RteBbdevCallback = Void
  alias X_IoLockT = Void
  alias PortT = UInt16

  struct Timespec
    tv_sec : LibC::Long
    tv_nsec : LibC::Long
  end

  struct RteEventAttr
    flow_event : Uint32T
    op_rsvd : Uint8T
    queue_id : Uint8T
    priority : Uint8T
    impl_opaque : Uint8T
  end

  union RteEventOrAttr
    event : Uint64T
    event_attr : RteEventAttr
  end

  union RteEventData
    u64 : Uint64T
    event_ptr : Void*
    mbuf : RteMbuf*
  end

  struct RteEvent
    event : RteEventOrAttr
    data : RteEventData
  end

  $cmdline_vt100_commands : LibC::Char**
  @[ThreadLocal]
  $internal_config : InternalConfig
  $lcore_config : LcoreConfig[128]
  @[ThreadLocal]
  $per_lcore__cpuset : RteCpusetT
  @[ThreadLocal]
  $per_lcore__socket_id : LibC::UInt
  @[ThreadLocal]
  $per_lcore__lcore_id : LibC::UInt
  @[ThreadLocal]
  $per_lcore__rte_errno : LibC::Int
  $rte_bbdev_devices : RteBbdev*
  $rte_crypto_aead_algorithm_strings : LibC::Char**
  $rte_crypto_aead_operation_strings : LibC::Char**
  $rte_crypto_auth_algorithm_strings : LibC::Char**
  $rte_crypto_auth_operation_strings : LibC::Char**
  $rte_crypto_cipher_algorithm_strings : LibC::Char**
  $rte_crypto_cipher_operation_strings : LibC::Char**
  $rte_cryptodevs : RteCryptodev*
  $rte_cycles_vmware_tsc_map : LibC::Int
  $rte_cyptodev_names : LibC::Char**
  $rte_delay_us : (LibC::UInt -> Void)
  $rte_eth_devices : RteEthDev*
  $rte_eventdev_globals : RteEventdevGlobal*
  $rte_eventdevs : RteEventdev*
  $rte_flow_item_any_mask : RteFlowItemAny
  $rte_flow_item_e_tag_mask : RteFlowItemETag
  $rte_flow_item_esp_mask : RteFlowItemEsp
  $rte_flow_item_eth_mask : RteFlowItemEth
  $rte_flow_item_fuzzy_mask : RteFlowItemFuzzy
  $rte_flow_item_geneve_mask : RteFlowItemGeneve
  $rte_flow_item_gre_mask : RteFlowItemGre
  $rte_flow_item_gtp_mask : RteFlowItemGtp
  $rte_flow_item_icmp_mask : RteFlowItemIcmp
  $rte_flow_item_ipv4_mask : RteFlowItemIpv4
  $rte_flow_item_ipv6_mask : RteFlowItemIpv6
  $rte_flow_item_mpls_mask : RteFlowItemMpls
  $rte_flow_item_nvgre_mask : RteFlowItemNvgre
  $rte_flow_item_port_mask : RteFlowItemPort
  $rte_flow_item_raw_mask : RteFlowItemRaw
  $rte_flow_item_sctp_mask : RteFlowItemSctp
  $rte_flow_item_tcp_mask : RteFlowItemTcp
  $rte_flow_item_udp_mask : RteFlowItemUdp
  $rte_flow_item_vf_mask : RteFlowItemVf
  $rte_flow_item_vlan_mask : RteFlowItemVlan
  $rte_flow_item_vxlan_mask : RteFlowItemVxlan
  $rte_logs : RteLogs
  $rte_mempool_ops_table : RteMempoolOpsTable
  $rte_rawdevs : RteRawdev*
  $rte_rtm_supported : Uint8T
  $rte_table_acl_ops : RteTableOps
  alias ArgHandlerT = (LibC::Char*, LibC::Char*, Void* -> LibC::Int)
  alias BufferTxErrorFn = (RteMbuf**, Uint16T, Void* -> Void)
  alias CcT = UInt8
  alias CmdlineParseCtxT = CmdlineParseInstT*
  alias DequeuePktBurstT = (Void*, RteCryptoOp**, Uint16T -> Uint16T)
  alias EnqueuePktBurstT = (Void*, RteCryptoOp**, Uint16T -> Uint16T)
  alias EthAllmulticastDisableT = (RteEthDev* -> Void)
  alias EthAllmulticastEnableT = (RteEthDev* -> Void)
  alias EthDevCloseT = (RteEthDev* -> Void)
  alias EthDevConfigureT = (RteEthDev* -> LibC::Int)
  alias EthDevInfosGetT = (RteEthDev*, RteEthDevInfo* -> Void)
  alias EthDevLedOffT = (RteEthDev* -> LibC::Int)
  alias EthDevLedOnT = (RteEthDev* -> LibC::Int)
  alias EthDevResetT = (RteEthDev* -> LibC::Int)
  alias EthDevSetLinkDownT = (RteEthDev* -> LibC::Int)
  alias EthDevSetLinkUpT = (RteEthDev* -> LibC::Int)
  alias EthDevStartT = (RteEthDev* -> LibC::Int)
  alias EthDevStopT = (RteEthDev* -> Void)
  alias EthDevSupportedPtypesGetT = (RteEthDev* -> Uint32T*)
  alias EthFilterCtrlT = (RteEthDev*, RteFilterType, RteFilterOp, Void* -> LibC::Int)
  alias EthFwVersionGetT = (RteEthDev*, LibC::Char*, LibC::Int -> LibC::Int)
  alias EthGetDcbInfo = (RteEthDev*, RteEthDcbInfo* -> LibC::Int)
  alias EthGetEepromLengthT = (RteEthDev* -> LibC::Int)
  alias EthGetEepromT = (RteEthDev*, RteDevEepromInfo* -> LibC::Int)
  alias EthGetRegT = (RteEthDev*, RteDevRegInfo* -> LibC::Int)
  alias EthIsRemovedT = (RteEthDev* -> LibC::Int)
  alias EthL2TunnelEthTypeConfT = (RteEthDev*, RteEthL2TunnelConf* -> LibC::Int)
  alias EthL2TunnelOffloadSetT = (RteEthDev*, RteEthL2TunnelConf*, Uint32T, Uint8T -> LibC::Int)
  alias EthLinkUpdateT = (RteEthDev*, LibC::Int -> LibC::Int)
  alias EthMacAddrAddT = (RteEthDev*, EtherAddr*, Uint32T, Uint32T -> LibC::Int)
  alias EthMacAddrRemoveT = (RteEthDev*, Uint32T -> Void)
  alias EthMacAddrSetT = (RteEthDev*, EtherAddr* -> Void)
  alias EthMirrorRuleResetT = (RteEthDev*, Uint8T -> LibC::Int)
  alias EthMirrorRuleSetT = (RteEthDev*, RteEthMirrorConf*, Uint8T, Uint8T -> LibC::Int)
  alias EthMtrOpsGetT = (RteEthDev*, Void* -> LibC::Int)
  alias EthPoolOpsSupportedT = (RteEthDev*, LibC::Char* -> LibC::Int)
  alias EthPromiscuousDisableT = (RteEthDev* -> Void)
  alias EthPromiscuousEnableT = (RteEthDev* -> Void)
  alias EthQueueReleaseT = (Void* -> Void)
  alias EthQueueStartT = (RteEthDev*, Uint16T -> LibC::Int)
  alias EthQueueStatsMappingSetT = (RteEthDev*, Uint16T, Uint8T, Uint8T -> LibC::Int)
  alias EthQueueStopT = (RteEthDev*, Uint16T -> LibC::Int)
  alias EthRxBurstT = (Void*, RteMbuf**, Uint16T -> Uint16T)
  alias EthRxDescriptorDoneT = (Void*, Uint16T -> LibC::Int)
  alias EthRxDescriptorStatusT = (Void*, Uint16T -> LibC::Int)
  alias EthRxDisableIntrT = (RteEthDev*, Uint16T -> LibC::Int)
  alias EthRxEnableIntrT = (RteEthDev*, Uint16T -> LibC::Int)
  alias EthRxQueueCountT = (RteEthDev*, Uint16T -> Uint32T)
  alias EthRxQueueSetupT = (RteEthDev*, Uint16T, Uint16T, LibC::UInt, RteEthRxconf*, RteMempool* -> LibC::Int)
  alias EthRxqInfoGetT = (RteEthDev*, Uint16T, RteEthRxqInfo* -> Void)
  alias EthSetEepromT = (RteEthDev*, RteDevEepromInfo* -> LibC::Int)
  alias EthSetMcAddrListT = (RteEthDev*, EtherAddr*, Uint32T -> LibC::Int)
  alias EthSetQueueRateLimitT = (RteEthDev*, Uint16T, Uint16T -> LibC::Int)
  alias EthStatsGetT = (RteEthDev*, RteEthStats* -> LibC::Int)
  alias EthStatsResetT = (RteEthDev* -> Void)
  alias EthTimesyncAdjustTime = (RteEthDev*, Int64T -> LibC::Int)
  alias EthTimesyncDisableT = (RteEthDev* -> LibC::Int)
  alias EthTimesyncEnableT = (RteEthDev* -> LibC::Int)
  alias EthTimesyncReadRxTimestampT = (RteEthDev*, Timespec*, Uint32T -> LibC::Int)
  alias EthTimesyncReadTime = (RteEthDev*, Timespec* -> LibC::Int)
  alias EthTimesyncReadTxTimestampT = (RteEthDev*, Timespec* -> LibC::Int)
  alias EthTimesyncWriteTime = (RteEthDev*, Timespec* -> LibC::Int)
  alias EthTmOpsGetT = (RteEthDev*, Void* -> LibC::Int)
  alias EthTxBurstT = (Void*, RteMbuf**, Uint16T -> Uint16T)
  alias EthTxDescriptorStatusT = (Void*, Uint16T -> LibC::Int)
  alias EthTxDoneCleanupT = (Void*, Uint32T -> LibC::Int)
  alias EthTxPrepT = (Void*, RteMbuf**, Uint16T -> Uint16T)
  alias EthTxQueueSetupT = (RteEthDev*, Uint16T, Uint16T, LibC::UInt, RteEthTxconf* -> LibC::Int)
  alias EthTxqInfoGetT = (RteEthDev*, Uint16T, RteEthTxqInfo* -> Void)
  alias EthUcAllHashTableSetT = (RteEthDev*, Uint8T -> LibC::Int)
  alias EthUcHashTableSetT = (RteEthDev*, EtherAddr*, Uint8T -> LibC::Int)
  alias EthUdpTunnelPortAddT = (RteEthDev*, RteEthUdpTunnel* -> LibC::Int)
  alias EthUdpTunnelPortDelT = (RteEthDev*, RteEthUdpTunnel* -> LibC::Int)
  alias EthXstatsGetByIdT = (RteEthDev*, Uint64T*, Uint64T*, LibC::UInt -> LibC::Int)
  alias EthXstatsGetNamesByIdT = (RteEthDev*, RteEthXstatName*, Uint64T*, LibC::UInt -> LibC::Int)
  alias EthXstatsGetNamesT = (RteEthDev*, RteEthXstatName*, LibC::UInt -> LibC::Int)
  alias EthXstatsGetT = (RteEthDev*, RteEthXstat*, LibC::UInt -> LibC::Int)
  alias EthXstatsResetT = (RteEthDev* -> Void)
  alias EventDequeueBurstT = (Void*, RteEvent*, Uint16T, Uint64T -> Uint16T)
  alias EventDequeueT = (Void*, RteEvent*, Uint64T -> Uint16T)
  alias EventEnqueueBurstT = (Void*, RteEvent*, Uint16T -> Uint16T)
  alias EventEnqueueT = (Void*, RteEvent* -> Uint16T)
  alias FlowCtrlGetT = (RteEthDev*, RteEthFcConf* -> LibC::Int)
  alias FlowCtrlSetT = (RteEthDev*, RteEthFcConf* -> LibC::Int)
  alias InAddrT = Uint32T
  alias Int16T = X__Int16T
  alias Int32T = X__Int32T
  alias Int64T = X__Int64T
  alias Marker = Void*[0]
  alias Marker64 = Uint64T[0]
  alias MtuSetT = (RteEthDev*, Uint16T -> LibC::Int)
  alias OffT = X__OffT
  alias PhysAddrT = Uint64T
  alias PriorityFlowCtrlSetT = (RteEthDev*, RteEthPfcConf* -> LibC::Int)
  alias PthreadT = LibC::ULong
  alias RetaQueryT = (RteEthDev*, RteEthRssRetaEntry64*, Uint16T -> LibC::Int)
  alias RetaUpdateT = (RteEthDev*, RteEthRssRetaEntry64*, Uint16T -> LibC::Int)
  alias RssHashConfGetT = (RteEthDev*, RteEthRssConf* -> LibC::Int)
  alias RssHashUpdateT = (RteEthDev*, RteEthRssConf* -> LibC::Int)
  alias RteBbdevCbFn = (Uint16T, RteBbdevEventType, Void*, Void* -> Void)
  alias RteBbdevDequeueDecOpsT = (RteBbdevQueueData*, RteBbdevDecOp**, Uint16T -> Uint16T)
  alias RteBbdevDequeueEncOpsT = (RteBbdevQueueData*, RteBbdevEncOp**, Uint16T -> Uint16T)
  alias RteBbdevEnqueueDecOpsT = (RteBbdevQueueData*, RteBbdevDecOp**, Uint16T -> Uint16T)
  alias RteBbdevEnqueueEncOpsT = (RteBbdevQueueData*, RteBbdevEncOp**, Uint16T -> Uint16T)
  alias RteBe16T = Uint16T
  alias RteBe32T = Uint32T
  alias RteBusCmpT = (RteBus*, Void* -> LibC::Int)
  alias RteCpusetT = CpuSetT
  alias RteCryptodevCbFn = (Uint8T, RteCryptodevEventType, Void* -> Void)
  alias RteCryptodevSchedulerConfigOptionGet = (RteCryptodev*, Uint32T, Void* -> LibC::Int)
  alias RteCryptodevSchedulerConfigOptionSet = (RteCryptodev*, Uint32T, Void* -> LibC::Int)
  alias RteCryptodevSchedulerConfigQueuePair = (RteCryptodev*, Uint16T -> LibC::Int)
  alias RteCryptodevSchedulerCreatePrivateCtx = (RteCryptodev* -> LibC::Int)
  alias RteCryptodevSchedulerSlaveAttachT = (RteCryptodev*, Uint8T -> LibC::Int)
  alias RteCryptodevSchedulerStartT = (RteCryptodev* -> LibC::Int)
  alias RteCryptodevSchedulerStopT = (RteCryptodev* -> LibC::Int)
  alias RteEthDevCbFn = (Uint16T, RteEthEventType, Void*, Void* -> LibC::Int)
  alias RteIntrCallbackFn = (Void* -> Void)
  alias RteIntrEventCbT = (LibC::Int, Void* -> Void)
  alias RteIovaT = Uint64T
  alias RteMempoolAllocT = (RteMempool* -> LibC::Int)
  alias RteMempoolDequeueT = (RteMempool*, Void**, LibC::UInt -> LibC::Int)
  alias RteMempoolEnqueueT = (RteMempool*, Void**, LibC::UInt -> LibC::Int)
  alias RteMempoolFreeT = (RteMempool* -> Void)
  alias RteMempoolGetCapabilitiesT = (RteMempool*, LibC::UInt* -> LibC::Int)
  alias RteMempoolGetCount = (RteMempool* -> LibC::UInt)
  alias RteMempoolOpsRegisterMemoryAreaT = (RteMempool*, LibC::Char*, RteIovaT, LibC::Int -> LibC::Int)
  alias RteMpT = (RteMpMsg*, Void* -> LibC::Int)
  alias RtePortInOpCreate = (Void*, LibC::Int -> Void*)
  alias RtePortInOpFree = (Void* -> LibC::Int)
  alias RtePortInOpRx = (Void*, RteMbuf**, Uint32T -> LibC::Int)
  alias RtePortInOpStatsRead = (Void*, RtePortInStats*, LibC::Int -> LibC::Int)
  alias RtePortOutOpCreate = (Void*, LibC::Int -> Void*)
  alias RtePortOutOpFlush = (Void* -> LibC::Int)
  alias RtePortOutOpFree = (Void* -> LibC::Int)
  alias RtePortOutOpStatsRead = (Void*, RtePortOutStats*, LibC::Int -> LibC::Int)
  alias RtePortOutOpTx = (Void*, RteMbuf* -> LibC::Int)
  alias RtePortOutOpTxBulk = (Void*, RteMbuf**, Uint64T -> LibC::Int)
  alias RteRawdevObjT = Void*
  alias RteRxCallbackFn = (Uint16T, Uint16T, RteMbuf**, Uint16T, Uint16T, Void* -> Uint16T)
  alias RteTableOpCreate = (Void*, LibC::Int, Uint32T -> Void*)
  alias RteTableOpEntryAdd = (Void*, Void*, Void*, LibC::Int*, Void** -> LibC::Int)
  alias RteTableOpEntryAddBulk = (Void*, Void**, Void**, Uint32T, LibC::Int*, Void** -> LibC::Int)
  alias RteTableOpEntryDelete = (Void*, Void*, LibC::Int*, Void* -> LibC::Int)
  alias RteTableOpEntryDeleteBulk = (Void*, Void**, Uint32T, LibC::Int*, Void** -> LibC::Int)
  alias RteTableOpFree = (Void* -> LibC::Int)
  alias RteTableOpLookup = (Void*, RteMbuf**, Uint64T, Uint64T*, Void** -> LibC::Int)
  alias RteTableOpStatsRead = (Void*, RteTableStats*, LibC::Int -> LibC::Int)
  alias RteTxCallbackFn = (Uint16T, Uint16T, RteMbuf**, Uint16T, Void* -> Uint16T)
  alias RteUsageHookT = (LibC::Char* -> Void)
  alias RteVdevScanCallback = (Void* -> Void)
  alias SpeedT = LibC::UInt
  alias SsizeT = X__SsizeT
  alias TcflagT = LibC::UInt
  alias Uint16T = X__Uint16T
  alias Uint32T = X__Uint32T
  alias Uint64T = X__Uint64T
  alias Uint8T = X__Uint8T
  alias UintptrT = LibC::ULong
  alias VaList = LibC::Int
  alias VlanFilterSetT = (RteEthDev*, Uint16T, LibC::Int -> LibC::Int)
  alias VlanOffloadSetT = (RteEthDev*, LibC::Int -> LibC::Int)
  alias VlanPvidSetT = (RteEthDev*, Uint16T, LibC::Int -> LibC::Int)
  alias VlanStripQueueSetT = (RteEthDev*, Uint16T, LibC::Int -> Void)
  alias VlanTpidSetT = (RteEthDev*, RteVlanType, Uint16T -> LibC::Int)
  alias X__CpuMask = LibC::ULong
  alias X__Int16T = LibC::Short
  alias X__Int32T = LibC::Int
  alias X__Int64T = LibC::Long
  alias X__Off64T = LibC::Long
  alias X__OffT = LibC::Long
  alias X__SsizeT = LibC::Long
  alias X__SyscallSlongT = LibC::Long
  alias X__TimeT = LibC::Long
  alias X__U16 = LibC::UShort
  alias X__U32 = LibC::UInt
  alias X__U64 = LibC::ULongLong
  alias X__Uint16T = LibC::UShort
  alias X__Uint32T = LibC::UInt
  alias X__Uint64T = LibC::ULong
  alias X__Uint8T = UInt8
  alias X__Virtio16 = X__U16
  alias X__Virtio32 = X__U32
  alias X__Virtio64 = X__U64
  alias XmmT = LibC::Int
  enum CmdlineVt100ParserState
    CmdlineVt100Init      = 0
    CmdlineVt100Escape    = 1
    CmdlineVt100EscapeCsi = 2
  end
  enum RdlineStatus
    RdlineInit    = 0
    RdlineRunning = 1
    RdlineExited  = 2
  end
  enum RteAclClassifyAlg
    RteAclClassifyDefault = 0
    RteAclClassifyScalar  = 1
    RteAclClassifySse     = 2
    RteAclClassifyAvx2    = 3
    RteAclClassifyNeon    = 4
    RteAclClassifyAltivec = 5
    RteAclClassifyNum     = 6
  end
  enum RteBbdevEventType
    RteBbdevEventUnknown = 0
    RteBbdevEventError   = 1
    RteBbdevEventDequeue = 2
    RteBbdevEventMax     = 3
  end
  enum RteBbdevOpType
    RteBbdevOpNone      = 0
    RteBbdevOpTurboDec  = 1
    RteBbdevOpTurboEnc  = 2
    RteBbdevOpTypeCount = 3
  end
  enum RteBbdevState
    RteBbdevUnused      = 0
    RteBbdevInitialized = 1
  end
  enum RteCpuFlagT
    RteCpuflagSse3          =  0
    RteCpuflagPclmulqdq     =  1
    RteCpuflagDtes64        =  2
    RteCpuflagMonitor       =  3
    RteCpuflagDsCpl         =  4
    RteCpuflagVmx           =  5
    RteCpuflagSmx           =  6
    RteCpuflagEist          =  7
    RteCpuflagTm2           =  8
    RteCpuflagSsse3         =  9
    RteCpuflagCnxtId        = 10
    RteCpuflagFma           = 11
    RteCpuflagCmpxchg16B    = 12
    RteCpuflagXtpr          = 13
    RteCpuflagPdcm          = 14
    RteCpuflagPcid          = 15
    RteCpuflagDca           = 16
    RteCpuflagSse41         = 17
    RteCpuflagSse42         = 18
    RteCpuflagX2Apic        = 19
    RteCpuflagMovbe         = 20
    RteCpuflagPopcnt        = 21
    RteCpuflagTscDeadline   = 22
    RteCpuflagAes           = 23
    RteCpuflagXsave         = 24
    RteCpuflagOsxsave       = 25
    RteCpuflagAvx           = 26
    RteCpuflagF16C          = 27
    RteCpuflagRdrand        = 28
    RteCpuflagHypervisor    = 29
    RteCpuflagFpu           = 30
    RteCpuflagVme           = 31
    RteCpuflagDe            = 32
    RteCpuflagPse           = 33
    RteCpuflagTsc           = 34
    RteCpuflagMsr           = 35
    RteCpuflagPae           = 36
    RteCpuflagMce           = 37
    RteCpuflagCx8           = 38
    RteCpuflagApic          = 39
    RteCpuflagSep           = 40
    RteCpuflagMtrr          = 41
    RteCpuflagPge           = 42
    RteCpuflagMca           = 43
    RteCpuflagCmov          = 44
    RteCpuflagPat           = 45
    RteCpuflagPse36         = 46
    RteCpuflagPsn           = 47
    RteCpuflagClfsh         = 48
    RteCpuflagDs            = 49
    RteCpuflagAcpi          = 50
    RteCpuflagMmx           = 51
    RteCpuflagFxsr          = 52
    RteCpuflagSse           = 53
    RteCpuflagSse2          = 54
    RteCpuflagSs            = 55
    RteCpuflagHtt           = 56
    RteCpuflagTm            = 57
    RteCpuflagPbe           = 58
    RteCpuflagDigtemp       = 59
    RteCpuflagTrbobst       = 60
    RteCpuflagArat          = 61
    RteCpuflagPln           = 62
    RteCpuflagEcmd          = 63
    RteCpuflagPtm           = 64
    RteCpuflagMperfAperfMsr = 65
    RteCpuflagAcnt2         = 66
    RteCpuflagEnergyEff     = 67
    RteCpuflagFsgsbase      = 68
    RteCpuflagBmi1          = 69
    RteCpuflagHle           = 70
    RteCpuflagAvx2          = 71
    RteCpuflagSmep          = 72
    RteCpuflagBmi2          = 73
    RteCpuflagErms          = 74
    RteCpuflagInvpcid       = 75
    RteCpuflagRtm           = 76
    RteCpuflagAvx512F       = 77
    RteCpuflagLahfSahf      = 78
    RteCpuflagLzcnt         = 79
    RteCpuflagSyscall       = 80
    RteCpuflagXd            = 81
    RteCpuflag1GbPg         = 82
    RteCpuflagRdtscp        = 83
    RteCpuflagEm64T         = 84
    RteCpuflagInvtsc        = 85
    RteCpuflagNumflags      = 86
  end
  enum RteCryptoAeadAlgorithm
    RteCryptoAeadAesCcm  = 1
    RteCryptoAeadAesGcm  = 2
    RteCryptoAeadListEnd = 3
  end
  enum RteCryptoAeadOperation
    RteCryptoAeadOpEncrypt = 0
    RteCryptoAeadOpDecrypt = 1
  end
  enum RteCryptoAuthAlgorithm
    RteCryptoAuthNull       =  1
    RteCryptoAuthAesCbcMac  =  2
    RteCryptoAuthAesCmac    =  3
    RteCryptoAuthAesGmac    =  4
    RteCryptoAuthAesXcbcMac =  5
    RteCryptoAuthKasumiF9   =  6
    RteCryptoAuthMd5        =  7
    RteCryptoAuthMd5Hmac    =  8
    RteCryptoAuthSha1       =  9
    RteCryptoAuthSha1Hmac   = 10
    RteCryptoAuthSha224     = 11
    RteCryptoAuthSha224Hmac = 12
    RteCryptoAuthSha256     = 13
    RteCryptoAuthSha256Hmac = 14
    RteCryptoAuthSha384     = 15
    RteCryptoAuthSha384Hmac = 16
    RteCryptoAuthSha512     = 17
    RteCryptoAuthSha512Hmac = 18
    RteCryptoAuthSnow3GUia2 = 19
    RteCryptoAuthZucEia3    = 20
    RteCryptoAuthListEnd    = 21
  end
  enum RteCryptoAuthOperation
    RteCryptoAuthOpVerify   = 0
    RteCryptoAuthOpGenerate = 1
  end
  enum RteCryptoCipherAlgorithm
    RteCryptoCipherNull         =  1
    RteCryptoCipher3DesCbc      =  2
    RteCryptoCipher3DesCtr      =  3
    RteCryptoCipher3DesEcb      =  4
    RteCryptoCipherAesCbc       =  5
    RteCryptoCipherAesCtr       =  6
    RteCryptoCipherAesEcb       =  7
    RteCryptoCipherAesF8        =  8
    RteCryptoCipherAesXts       =  9
    RteCryptoCipherArc4         = 10
    RteCryptoCipherKasumiF8     = 11
    RteCryptoCipherSnow3GUea2   = 12
    RteCryptoCipherZucEea3      = 13
    RteCryptoCipherDesCbc       = 14
    RteCryptoCipherAesDocsisbpi = 15
    RteCryptoCipherDesDocsisbpi = 16
    RteCryptoCipherListEnd      = 17
  end
  enum RteCryptoCipherOperation
    RteCryptoCipherOpEncrypt = 0
    RteCryptoCipherOpDecrypt = 1
  end
  enum RteCryptoOpType
    RteCryptoOpTypeUndefined = 0
    RteCryptoOpTypeSymmetric = 1
  end
  enum RteCryptoSymXformType
    RteCryptoSymXformNotSpecified = 0
    RteCryptoSymXformAuth         = 1
    RteCryptoSymXformCipher       = 2
    RteCryptoSymXformAead         = 3
  end
  enum RteCryptodevEventType
    RteCryptodevEventUnknown = 0
    RteCryptodevEventError   = 1
    RteCryptodevEventMax     = 2
  end
  enum RteDevPolicy
    RteDevWhitelisted = 0
    RteDevBlacklisted = 1
  end
  enum RteDevtype
    RteDevtypeWhitelistedPci = 0
    RteDevtypeBlacklistedPci = 1
    RteDevtypeVirtual        = 2
  end
  enum RteEthDevState
    RteEthDevUnused   = 0
    RteEthDevAttached = 1
    RteEthDevDeferred = 2
    RteEthDevRemoved  = 3
  end
  enum RteEthEventType
    RteEthEventUnknown    = 0
    RteEthEventIntrLsc    = 1
    RteEthEventQueueState = 2
    RteEthEventIntrReset  = 3
    RteEthEventVfMbox     = 4
    RteEthEventMacsec     = 5
    RteEthEventIntrRmv    = 6
    RteEthEventNew        = 7
    RteEthEventDestroy    = 8
    RteEthEventMax        = 9
  end
  enum RteEthFcMode
    RteFcNone    = 0
    RteFcRxPause = 1
    RteFcTxPause = 2
    RteFcFull    = 3
  end
  enum RteEthFdirBehavior
    RteEthFdirAccept   = 0
    RteEthFdirReject   = 1
    RteEthFdirPassthru = 2
  end
  enum RteEthFdirFilterInfoType
    RteEthFdirFilterInfoTypeUnknown = 0
    RteEthFdirFilterInputSetSelect  = 1
    RteEthFdirFilterInfoTypeMax     = 2
  end
  enum RteEthFdirStatus
    RteEthFdirNoReportStatus = 0
    RteEthFdirReportId       = 1
    RteEthFdirReportIdFlex4  = 2
    RteEthFdirReportFlex8    = 3
  end
  enum RteEthFdirTunnelType
    RteFdirTunnelTypeUnknown = 0
    RteFdirTunnelTypeNvgre   = 1
    RteFdirTunnelTypeVxlan   = 2
  end
  enum RteEthGlobalCfgType
    RteEthGlobalCfgTypeUnknown   = 0
    RteEthGlobalCfgTypeGreKeyLen = 1
    RteEthGlobalCfgTypeMax       = 2
  end
  enum RteEthHashFilterInfoType
    RteEthHashFilterInfoTypeUnknown   = 0
    RteEthHashFilterSymHashEnaPerPort = 1
    RteEthHashFilterGlobalConfig      = 2
    RteEthHashFilterInputSetSelect    = 3
    RteEthHashFilterInfoTypeMax       = 4
  end
  enum RteEthHashFunction
    RteEthHashFunctionDefault   = 0
    RteEthHashFunctionToeplitz  = 1
    RteEthHashFunctionSimpleXor = 2
    RteEthHashFunctionMax       = 3
  end
  enum RteEthInputSetField
    RteEthInputSetUnknown               =     0
    RteEthInputSetL2SrcMac              =     1
    RteEthInputSetL2DstMac              =     2
    RteEthInputSetL2OuterVlan           =     3
    RteEthInputSetL2InnerVlan           =     4
    RteEthInputSetL2Ethertype           =     5
    RteEthInputSetL3SrcIp4              =   129
    RteEthInputSetL3DstIp4              =   130
    RteEthInputSetL3SrcIp6              =   131
    RteEthInputSetL3DstIp6              =   132
    RteEthInputSetL3Ip4Tos              =   133
    RteEthInputSetL3Ip4Proto            =   134
    RteEthInputSetL3Ip6Tc               =   135
    RteEthInputSetL3Ip6NextHeader       =   136
    RteEthInputSetL3Ip4Ttl              =   137
    RteEthInputSetL3Ip6HopLimits        =   138
    RteEthInputSetL4UdpSrcPort          =   257
    RteEthInputSetL4UdpDstPort          =   258
    RteEthInputSetL4TcpSrcPort          =   259
    RteEthInputSetL4TcpDstPort          =   260
    RteEthInputSetL4SctpSrcPort         =   261
    RteEthInputSetL4SctpDstPort         =   262
    RteEthInputSetL4SctpVerificationTag =   263
    RteEthInputSetTunnelL2InnerDstMac   =   385
    RteEthInputSetTunnelL2InnerSrcMac   =   386
    RteEthInputSetTunnelL2InnerVlan     =   387
    RteEthInputSetTunnelL4UdpKey        =   388
    RteEthInputSetTunnelGreKey          =   389
    RteEthInputSetFlexPayload1StWord    =   641
    RteEthInputSetFlexPayload2NdWord    =   642
    RteEthInputSetFlexPayload3RdWord    =   643
    RteEthInputSetFlexPayload4ThWord    =   644
    RteEthInputSetFlexPayload5ThWord    =   645
    RteEthInputSetFlexPayload6ThWord    =   646
    RteEthInputSetFlexPayload7ThWord    =   647
    RteEthInputSetFlexPayload8ThWord    =   648
    RteEthInputSetDefault               = 65533
    RteEthInputSetNone                  = 65534
    RteEthInputSetMax                   = 65535
  end
  enum RteEthNbPools
    Eth8Pools  =  8
    Eth16Pools = 16
    Eth32Pools = 32
    Eth64Pools = 64
  end
  enum RteEthNbTcs
    Eth4Tcs = 4
    Eth8Tcs = 8
  end
  enum RteEthPayloadType
    RteEthPayloadUnknown = 0
    RteEthRawPayload     = 1
    RteEthL2Payload      = 2
    RteEthL3Payload      = 3
    RteEthL4Payload      = 4
    RteEthPayloadMax     = 8
  end
  enum RteEthRxMqMode
    EthMqRxNone       = 0
    EthMqRxRss        = 1
    EthMqRxDcb        = 2
    EthMqRxDcbRss     = 3
    EthMqRxVmdqOnly   = 4
    EthMqRxVmdqRss    = 5
    EthMqRxVmdqDcb    = 6
    EthMqRxVmdqDcbRss = 7
  end
  enum RteEthTunnelType
    RteTunnelTypeNone    = 0
    RteTunnelTypeVxlan   = 1
    RteTunnelTypeGeneve  = 2
    RteTunnelTypeTeredo  = 3
    RteTunnelTypeNvgre   = 4
    RteTunnelTypeIpInGre = 5
    RteL2TunnelTypeETag  = 6
    RteTunnelTypeMax     = 7
  end
  enum RteEthTxMqMode
    EthMqTxNone     = 0
    EthMqTxDcb      = 1
    EthMqTxVmdqDcb  = 2
    EthMqTxVmdqOnly = 3
  end
  enum RteEventDevXstatsMode
    RteEventDevXstatsDevice = 0
    RteEventDevXstatsPort   = 1
    RteEventDevXstatsQueue  = 2
  end
  enum RteFdirMode
    RteFdirModeNone           = 0
    RteFdirModeSignature      = 1
    RteFdirModePerfect        = 2
    RteFdirModePerfectMacVlan = 3
    RteFdirModePerfectTunnel  = 4
  end
  enum RteFdirPballocType
    RteFdirPballoc64K  = 0
    RteFdirPballoc128K = 1
    RteFdirPballoc256K = 2
  end
  enum RteFdirStatusMode
    RteFdirNoReportStatus     = 0
    RteFdirReportStatus       = 1
    RteFdirReportStatusAlways = 2
  end
  enum RteFilterInputSetOp
    RteEthInputSetOpUnknown = 0
    RteEthInputSetSelect    = 1
    RteEthInputSetAdd       = 2
    RteEthInputSetOpMax     = 3
  end
  enum RteFilterOp
    RteEthFilterNop    = 0
    RteEthFilterAdd    = 1
    RteEthFilterUpdate = 2
    RteEthFilterDelete = 3
    RteEthFilterFlush  = 4
    RteEthFilterGet    = 5
    RteEthFilterSet    = 6
    RteEthFilterInfo   = 7
    RteEthFilterStats  = 8
    RteEthFilterOpMax  = 9
  end
  enum RteFilterType
    RteEthFilterNone      =  0
    RteEthFilterMacvlan   =  1
    RteEthFilterEthertype =  2
    RteEthFilterFlexible  =  3
    RteEthFilterSyn       =  4
    RteEthFilterNtuple    =  5
    RteEthFilterTunnel    =  6
    RteEthFilterFdir      =  7
    RteEthFilterHash      =  8
    RteEthFilterL2Tunnel  =  9
    RteEthFilterGeneric   = 10
    RteEthFilterMax       = 11
  end
  enum RteFlowActionType
    RteFlowActionTypeEnd      =  0
    RteFlowActionTypeVoid     =  1
    RteFlowActionTypePassthru =  2
    RteFlowActionTypeMark     =  3
    RteFlowActionTypeFlag     =  4
    RteFlowActionTypeQueue    =  5
    RteFlowActionTypeDrop     =  6
    RteFlowActionTypeCount    =  7
    RteFlowActionTypeDup      =  8
    RteFlowActionTypeRss      =  9
    RteFlowActionTypePf       = 10
    RteFlowActionTypeVf       = 11
    RteFlowActionTypeMeter    = 12
    RteFlowActionTypeSecurity = 13
  end
  enum RteFlowErrorType
    RteFlowErrorTypeNone         =  0
    RteFlowErrorTypeUnspecified  =  1
    RteFlowErrorTypeHandle       =  2
    RteFlowErrorTypeAttrGroup    =  3
    RteFlowErrorTypeAttrPriority =  4
    RteFlowErrorTypeAttrIngress  =  5
    RteFlowErrorTypeAttrEgress   =  6
    RteFlowErrorTypeAttr         =  7
    RteFlowErrorTypeItemNum      =  8
    RteFlowErrorTypeItem         =  9
    RteFlowErrorTypeActionNum    = 10
    RteFlowErrorTypeAction       = 11
  end
  enum RteFlowItemType
    RteFlowItemTypeEnd    =  0
    RteFlowItemTypeVoid   =  1
    RteFlowItemTypeInvert =  2
    RteFlowItemTypeAny    =  3
    RteFlowItemTypePf     =  4
    RteFlowItemTypeVf     =  5
    RteFlowItemTypePort   =  6
    RteFlowItemTypeRaw    =  7
    RteFlowItemTypeEth    =  8
    RteFlowItemTypeVlan   =  9
    RteFlowItemTypeIpv4   = 10
    RteFlowItemTypeIpv6   = 11
    RteFlowItemTypeIcmp   = 12
    RteFlowItemTypeUdp    = 13
    RteFlowItemTypeTcp    = 14
    RteFlowItemTypeSctp   = 15
    RteFlowItemTypeVxlan  = 16
    RteFlowItemTypeETag   = 17
    RteFlowItemTypeNvgre  = 18
    RteFlowItemTypeMpls   = 19
    RteFlowItemTypeGre    = 20
    RteFlowItemTypeFuzzy  = 21
    RteFlowItemTypeGtp    = 22
    RteFlowItemTypeGtpc   = 23
    RteFlowItemTypeGtpu   = 24
    RteFlowItemTypeEsp    = 25
    RteFlowItemTypeGeneve = 26
  end
  enum RteIntrHandleType
    RteIntrHandleUnknown    = 0
    RteIntrHandleUio        = 1
    RteIntrHandleUioIntx    = 2
    RteIntrHandleVfioLegacy = 3
    RteIntrHandleVfioMsi    = 4
    RteIntrHandleVfioMsix   = 5
    RteIntrHandleAlarm      = 6
    RteIntrHandleExt        = 7
    RteIntrHandleVdev       = 8
    RteIntrHandleMax        = 9
  end
  enum RteIntrMode
    RteIntrModeNone   = 0
    RteIntrModeLegacy = 1
    RteIntrModeMsi    = 2
    RteIntrModeMsix   = 3
  end
  enum RteIovaMode
    RteIovaDc = 0
    RteIovaPa = 1
    RteIovaVa = 2
  end
  enum RteKernelDriver
    RteKdrvUnknown    = 0
    RteKdrvIgbUio     = 1
    RteKdrvVfio       = 2
    RteKdrvUioGeneric = 3
    RteKdrvNicUio     = 4
    RteKdrvNone       = 5
  end
  enum RteLcoreRoleT
    RoleRte     = 0
    RoleOff     = 1
    RoleService = 2
  end
  enum RteLcoreStateT
    Wait     = 0
    Running  = 1
    Finished = 2
  end
  enum RteMacFilterType
    RteMacPerfectMatch     = 1
    RteMacvlanPerfectMatch = 2
    RteMacHashMatch        = 3
    RteMacvlanHashMatch    = 4
  end
  enum RteMeterColor
    ERteMeterGreen  = 0
    ERteMeterYellow = 1
    ERteMeterRed    = 2
    ERteMeterColors = 3
  end
  enum RteMtrAlgorithm
    RteMtrNone         = 0
    RteMtrSrtcmRfc2697 = 1
    RteMtrTrtcmRfc2698 = 2
    RteMtrTrtcmRfc4115 = 3
  end
  enum RteMtrColor
    RteMtrGreen  = 0
    RteMtrYellow = 1
    RteMtrRed    = 2
    RteMtrColors = 3
  end
  enum RteMtrErrorType
    RteMtrErrorTypeNone                =  0
    RteMtrErrorTypeUnspecified         =  1
    RteMtrErrorTypeMeterProfileId      =  2
    RteMtrErrorTypeMeterProfile        =  3
    RteMtrErrorTypeMtrId               =  4
    RteMtrErrorTypeMtrParams           =  5
    RteMtrErrorTypePolicerActionGreen  =  6
    RteMtrErrorTypePolicerActionYellow =  7
    RteMtrErrorTypePolicerActionRed    =  8
    RteMtrErrorTypeStatsMask           =  9
    RteMtrErrorTypeStats               = 10
    RteMtrErrorTypeShared              = 11
  end
  enum RteMtrPolicerAction
    MtrPolicerActionColorGreen  = 0
    MtrPolicerActionColorYellow = 1
    MtrPolicerActionColorRed    = 2
    MtrPolicerActionDrop        = 3
  end
  enum RteProcTypeT
    RteProcAuto      = -1
    RteProcPrimary   =  0
    RteProcSecondary =  1
    RteProcInvalid   =  2
  end
  enum RteRingQueueBehavior
    RteRingQueueFixed    = 0
    RteRingQueueVariable = 1
  end
  enum RteRmtCallMasterT
    SkipMaster = 0
    CallMaster = 1
  end
  enum RteSecurityIpsecSaDirection
    RteSecurityIpsecSaDirEgress  = 0
    RteSecurityIpsecSaDirIngress = 1
  end
  enum RteSecurityIpsecSaMode
    RteSecurityIpsecSaModeTransport = 1
    RteSecurityIpsecSaModeTunnel    = 2
  end
  enum RteSecurityIpsecSaProtocol
    RteSecurityIpsecSaProtoAh  = 1
    RteSecurityIpsecSaProtoEsp = 2
  end
  enum RteSecurityIpsecTunnelType
    RteSecurityIpsecTunnelIpv4 = 1
    RteSecurityIpsecTunnelIpv6 = 2
  end
  enum RteSecuritySessionActionType
    RteSecurityActionTypeNone              = 0
    RteSecurityActionTypeInlineCrypto      = 1
    RteSecurityActionTypeInlineProtocol    = 2
    RteSecurityActionTypeLookasideProtocol = 3
  end
  enum RteSecuritySessionProtocol
    RteSecurityProtocolIpsec  = 1
    RteSecurityProtocolMacsec = 2
  end
  enum RteTmCmanMode
    RteTmCmanTailDrop = 0
    RteTmCmanHeadDrop = 1
    RteTmCmanWred     = 2
  end
  enum RteTmErrorType
    RteTmErrorTypeNone                          =  0
    RteTmErrorTypeUnspecified                   =  1
    RteTmErrorTypeCapabilities                  =  2
    RteTmErrorTypeLevelId                       =  3
    RteTmErrorTypeWredProfile                   =  4
    RteTmErrorTypeWredProfileGreen              =  5
    RteTmErrorTypeWredProfileYellow             =  6
    RteTmErrorTypeWredProfileRed                =  7
    RteTmErrorTypeWredProfileId                 =  8
    RteTmErrorTypeSharedWredContextId           =  9
    RteTmErrorTypeShaperProfile                 = 10
    RteTmErrorTypeShaperProfileCommittedRate    = 11
    RteTmErrorTypeShaperProfileCommittedSize    = 12
    RteTmErrorTypeShaperProfilePeakRate         = 13
    RteTmErrorTypeShaperProfilePeakSize         = 14
    RteTmErrorTypeShaperProfilePktAdjustLen     = 15
    RteTmErrorTypeShaperProfileId               = 16
    RteTmErrorTypeSharedShaperId                = 17
    RteTmErrorTypeNodeParentNodeId              = 18
    RteTmErrorTypeNodePriority                  = 19
    RteTmErrorTypeNodeWeight                    = 20
    RteTmErrorTypeNodeParams                    = 21
    RteTmErrorTypeNodeParamsShaperProfileId     = 22
    RteTmErrorTypeNodeParamsSharedShaperId      = 23
    RteTmErrorTypeNodeParamsNSharedShapers      = 24
    RteTmErrorTypeNodeParamsWfqWeightMode       = 25
    RteTmErrorTypeNodeParamsNSpPriorities       = 26
    RteTmErrorTypeNodeParamsCman                = 27
    RteTmErrorTypeNodeParamsWredProfileId       = 28
    RteTmErrorTypeNodeParamsSharedWredContextId = 29
    RteTmErrorTypeNodeParamsNSharedWredContexts = 30
    RteTmErrorTypeNodeParamsStats               = 31
    RteTmErrorTypeNodeId                        = 32
  end
  enum RteTunnelIptype
    RteTunnelIptypeIpv4 = 0
    RteTunnelIptypeIpv6 = 1
  end
  enum RteVlanType
    EthVlanTypeUnknown = 0
    EthVlanTypeInner   = 1
    EthVlanTypeOuter   = 2
    EthVlanTypeMax     = 3
  end
  fun __rte_crypto_op_get_priv_data(op : RteCryptoOp*, size : Uint32T) : Void*
  fun __rte_crypto_op_get_priv_data_size(mempool : RteMempool*) : Uint16T
  fun __rte_crypto_op_raw_bulk_alloc(mempool : RteMempool*, type : RteCryptoOpType, ops : RteCryptoOp**, nb_ops : Uint16T) : LibC::Int
  fun __rte_crypto_op_reset(op : RteCryptoOp*, type : RteCryptoOpType)
  fun __rte_crypto_sym_op_attach_sym_session(sym_op : RteCryptoSymOp*, sess : RteCryptodevSymSession*) : LibC::Int
  fun __rte_crypto_sym_op_reset(op : RteCryptoSymOp*)
  fun __rte_crypto_sym_op_sym_xforms_alloc(sym_op : RteCryptoSymOp*, priv_data : Void*, nb_xforms : Uint8T) : RteCryptoSymXform*
  fun __rte_event_enqueue_burst(dev_id : Uint8T, port_id : Uint8T, ev : RteEvent*, nb_events : Uint16T, fn : EventEnqueueBurstT) : Uint16T
  fun __rte_jhash_2hashes(key : Void*, length : Uint32T, pc : Uint32T*, pb : Uint32T*, check_align : LibC::UInt)
  fun __rte_jhash_3words(a : Uint32T, b : Uint32T, c : Uint32T, initval : Uint32T) : Uint32T
  fun __rte_mbuf_raw_free(m : RteMbuf*)
  fun __rte_mbuf_refcnt_update(m : RteMbuf*, value : Int16T) : Uint16T
  fun __rte_panic(funcname : LibC::Char*, format : LibC::Char*, ...)
  fun __rte_pktmbuf_prefree_seg(m : RteMbuf*) : RteMbuf*
  fun __rte_pktmbuf_read(m : RteMbuf*, off : Uint32T, len : Uint32T, buf : Void*) : Void*
  fun __rte_raw_cksum(buf : Void*, len : LibC::Int, sum : Uint32T) : Uint32T
  fun __rte_raw_cksum_reduce(sum : Uint32T) : Uint16T
  fun __rte_ring_do_dequeue(r : RteRing*, obj_table : Void**, n : LibC::UInt, behavior : RteRingQueueBehavior, is_sc : LibC::Int, available : LibC::UInt*) : LibC::UInt
  fun __rte_ring_do_enqueue(r : RteRing*, obj_table : Void**, n : LibC::UInt, behavior : RteRingQueueBehavior, is_sp : LibC::Int, free_space : LibC::UInt*) : LibC::UInt
  fun __rte_ring_move_cons_head(r : RteRing*, is_sc : LibC::Int, n : LibC::UInt, behavior : RteRingQueueBehavior, old_head : Uint32T*, new_head : Uint32T*, entries : Uint32T*) : LibC::UInt
  fun __rte_ring_move_prod_head(r : RteRing*, is_sp : LibC::Int, n : LibC::UInt, behavior : RteRingQueueBehavior, old_head : Uint32T*, new_head : Uint32T*, free_entries : Uint32T*) : LibC::UInt
  fun __rte_security_attach_session(sym_op : RteCryptoSymOp*, sess : RteSecuritySession*) : LibC::Int
  fun cmdline_complete(cl : Cmdline*, buf : LibC::Char*, state : LibC::Int*, dst : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_free(cl : Cmdline*)
  fun cmdline_in(cl : Cmdline*, buf : LibC::Char*, size : LibC::Int) : LibC::Int
  fun cmdline_interact(cl : Cmdline*)
  fun cmdline_isendofcommand(c : LibC::Char) : LibC::Int
  fun cmdline_isendoftoken(c : LibC::Char) : LibC::Int
  fun cmdline_new(ctx : CmdlineParseCtxT*, prompt : LibC::Char*, s_in : LibC::Int, s_out : LibC::Int) : Cmdline*
  fun cmdline_parse(cl : Cmdline*, buf : LibC::Char*) : LibC::Int
  fun cmdline_poll(cl : Cmdline*) : LibC::Int
  fun cmdline_printf(cl : Cmdline*, fmt : LibC::Char*, ...)
  fun cmdline_quit(cl : Cmdline*)
  fun cmdline_set_prompt(cl : Cmdline*, prompt : LibC::Char*)
  fun cmdline_write_char(rdl : Rdline*, c : LibC::Char) : LibC::Int
  # fun malloc(__size : LibC::Int) : Void*
  fun perror(__s : LibC::Char*)
  fun rte_acl_add_rules(ctx : RteAclCtx*, rules : RteAclRule*, num : Uint32T) : LibC::Int
  fun rte_acl_build(ctx : RteAclCtx*, cfg : RteAclConfig*) : LibC::Int
  fun rte_acl_classify(ctx : RteAclCtx*, data : Uint8T**, results : Uint32T*, num : Uint32T, categories : Uint32T) : LibC::Int
  fun rte_acl_classify_alg(ctx : RteAclCtx*, data : Uint8T**, results : Uint32T*, num : Uint32T, categories : Uint32T, alg : RteAclClassifyAlg) : LibC::Int
  fun rte_acl_create(param : RteAclParam*) : RteAclCtx*
  fun rte_acl_dump(ctx : RteAclCtx*)
  fun rte_acl_find_existing(name : LibC::Char*) : RteAclCtx*
  fun rte_acl_free(ctx : RteAclCtx*)
  fun rte_acl_list_dump
  fun rte_acl_reset(ctx : RteAclCtx*)
  fun rte_acl_reset_rules(ctx : RteAclCtx*)
  fun rte_acl_set_ctx_classify(ctx : RteAclCtx*, alg : RteAclClassifyAlg) : LibC::Int
  fun rte_align32pow2(x : Uint32T) : Uint32T
  fun rte_align64pow2(v : Uint64T) : Uint64T
  fun rte_arch_bswap16(_x : Uint16T) : Uint16T
  fun rte_arch_bswap32(_x : Uint32T) : Uint32T
  fun rte_arch_bswap64(_x : Uint64T) : Uint64T
  fun rte_atomic16_add(v : RteAtomic16T*, inc : Int16T)
  fun rte_atomic16_add_return(v : RteAtomic16T*, inc : Int16T) : Int16T
  fun rte_atomic16_clear(v : RteAtomic16T*)
  fun rte_atomic16_cmpset(dst : Uint16T*, exp : Uint16T, src : Uint16T) : LibC::Int
  fun rte_atomic16_dec(v : RteAtomic16T*)
  fun rte_atomic16_dec_and_test(v : RteAtomic16T*) : LibC::Int
  fun rte_atomic16_inc(v : RteAtomic16T*)
  fun rte_atomic16_inc_and_test(v : RteAtomic16T*) : LibC::Int
  fun rte_atomic16_init(v : RteAtomic16T*)
  fun rte_atomic16_read(v : RteAtomic16T*) : Int16T
  fun rte_atomic16_set(v : RteAtomic16T*, new_value : Int16T)
  fun rte_atomic16_sub(v : RteAtomic16T*, dec : Int16T)
  fun rte_atomic16_sub_return(v : RteAtomic16T*, dec : Int16T) : Int16T
  fun rte_atomic16_test_and_set(v : RteAtomic16T*) : LibC::Int
  fun rte_atomic32_add(v : RteAtomic32T*, inc : Int32T)
  fun rte_atomic32_add_return(v : RteAtomic32T*, inc : Int32T) : Int32T
  fun rte_atomic32_clear(v : RteAtomic32T*)
  fun rte_atomic32_cmpset(dst : Uint32T*, exp : Uint32T, src : Uint32T) : LibC::Int
  fun rte_atomic32_dec(v : RteAtomic32T*)
  fun rte_atomic32_dec_and_test(v : RteAtomic32T*) : LibC::Int
  fun rte_atomic32_inc(v : RteAtomic32T*)
  fun rte_atomic32_inc_and_test(v : RteAtomic32T*) : LibC::Int
  fun rte_atomic32_init(v : RteAtomic32T*)
  fun rte_atomic32_read(v : RteAtomic32T*) : Int32T
  fun rte_atomic32_set(v : RteAtomic32T*, new_value : Int32T)
  fun rte_atomic32_sub(v : RteAtomic32T*, dec : Int32T)
  fun rte_atomic32_sub_return(v : RteAtomic32T*, dec : Int32T) : Int32T
  fun rte_atomic32_test_and_set(v : RteAtomic32T*) : LibC::Int
  fun rte_atomic64_add(v : RteAtomic64T*, inc : Int64T)
  fun rte_atomic64_add_return(v : RteAtomic64T*, inc : Int64T) : Int64T
  fun rte_atomic64_clear(v : RteAtomic64T*)
  fun rte_atomic64_cmpset(dst : Uint64T*, exp : Uint64T, src : Uint64T) : LibC::Int
  fun rte_atomic64_dec(v : RteAtomic64T*)
  fun rte_atomic64_dec_and_test(v : RteAtomic64T*) : LibC::Int
  fun rte_atomic64_inc(v : RteAtomic64T*)
  fun rte_atomic64_inc_and_test(v : RteAtomic64T*) : LibC::Int
  fun rte_atomic64_init(v : RteAtomic64T*)
  fun rte_atomic64_read(v : RteAtomic64T*) : Int64T
  fun rte_atomic64_set(v : RteAtomic64T*, new_value : Int64T)
  fun rte_atomic64_sub(v : RteAtomic64T*, dec : Int64T)
  fun rte_atomic64_sub_return(v : RteAtomic64T*, dec : Int64T) : Int64T
  fun rte_atomic64_test_and_set(v : RteAtomic64T*) : LibC::Int
  fun rte_bbdev_callback_register(dev_id : Uint16T, event : RteBbdevEventType, cb_fn : RteBbdevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_bbdev_callback_unregister(dev_id : Uint16T, event : RteBbdevEventType, cb_fn : RteBbdevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_bbdev_close(dev_id : Uint16T) : LibC::Int
  fun rte_bbdev_count : Uint16T
  fun rte_bbdev_dec_op_alloc_bulk(mempool : RteMempool*, ops : RteBbdevDecOp**, num_ops : Uint16T) : LibC::Int
  fun rte_bbdev_dec_op_free_bulk(ops : RteBbdevDecOp**, num_ops : LibC::UInt)
  fun rte_bbdev_dequeue_dec_ops(dev_id : Uint16T, queue_id : Uint16T, ops : RteBbdevDecOp**, num_ops : Uint16T) : Uint16T
  fun rte_bbdev_dequeue_enc_ops(dev_id : Uint16T, queue_id : Uint16T, ops : RteBbdevEncOp**, num_ops : Uint16T) : Uint16T
  fun rte_bbdev_enc_op_alloc_bulk(mempool : RteMempool*, ops : RteBbdevEncOp**, num_ops : Uint16T) : LibC::Int
  fun rte_bbdev_enc_op_free_bulk(ops : RteBbdevEncOp**, num_ops : LibC::UInt)
  fun rte_bbdev_enqueue_dec_ops(dev_id : Uint16T, queue_id : Uint16T, ops : RteBbdevDecOp**, num_ops : Uint16T) : Uint16T
  fun rte_bbdev_enqueue_enc_ops(dev_id : Uint16T, queue_id : Uint16T, ops : RteBbdevEncOp**, num_ops : Uint16T) : Uint16T
  fun rte_bbdev_find_next(dev_id : Uint16T) : Uint16T
  fun rte_bbdev_info_get(dev_id : Uint16T, dev_info : RteBbdevInfo*) : LibC::Int
  fun rte_bbdev_intr_enable(dev_id : Uint16T) : LibC::Int
  fun rte_bbdev_op_pool_create(name : LibC::Char*, type : RteBbdevOpType, num_elements : LibC::UInt, cache_size : LibC::UInt, socket_id : LibC::Int) : RteMempool*
  fun rte_bbdev_op_type_str(op_type : RteBbdevOpType) : LibC::Char*
  fun rte_bbdev_queue_configure(dev_id : Uint16T, queue_id : Uint16T, conf : RteBbdevQueueConf*) : LibC::Int
  fun rte_bbdev_queue_info_get(dev_id : Uint16T, queue_id : Uint16T, queue_info : RteBbdevQueueInfo*) : LibC::Int
  fun rte_bbdev_queue_intr_ctl(dev_id : Uint16T, queue_id : Uint16T, epfd : LibC::Int, op : LibC::Int, data : Void*) : LibC::Int
  fun rte_bbdev_queue_intr_disable(dev_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_bbdev_queue_intr_enable(dev_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_bbdev_queue_start(dev_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_bbdev_queue_stop(dev_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_bbdev_setup_queues(dev_id : Uint16T, num_queues : Uint16T, socket_id : LibC::Int) : LibC::Int
  fun rte_bbdev_start(dev_id : Uint16T) : LibC::Int
  fun rte_bbdev_stats_get(dev_id : Uint16T, stats : RteBbdevStats*) : LibC::Int
  fun rte_bbdev_stats_reset(dev_id : Uint16T) : LibC::Int
  fun rte_bbdev_stop(dev_id : Uint16T) : LibC::Int
  fun rte_bsf32(v : Uint32T) : Uint32T
  fun rte_bus_dump(f : Void*)
  fun rte_bus_find(start : RteBus*, cmp : RteBusCmpT, data : Void*) : RteBus*
  fun rte_bus_find_by_device(dev : RteDevice*) : RteBus*
  fun rte_bus_find_by_name(busname : LibC::Char*) : RteBus*
  fun rte_bus_get_iommu_class : RteIovaMode
  fun rte_bus_probe : LibC::Int
  fun rte_bus_register(bus : RteBus*)
  fun rte_bus_scan : LibC::Int
  fun rte_bus_unregister(bus : RteBus*)
  fun rte_calloc(type : LibC::Char*, num : LibC::Int, size : LibC::Int, align : LibC::UInt) : Void*
  fun rte_calloc_socket(type : LibC::Char*, num : LibC::Int, size : LibC::Int, align : LibC::UInt, socket : LibC::Int) : Void*
  fun rte_constant_bswap16(x : Uint16T) : Uint16T
  fun rte_constant_bswap32(x : Uint32T) : Uint32T
  fun rte_constant_bswap64(x : Uint64T) : Uint64T
  fun rte_cpu_check_supported
  fun rte_cpu_get_flag_enabled(feature : RteCpuFlagT) : LibC::Int
  fun rte_cpu_get_flag_name(feature : RteCpuFlagT) : LibC::Char*
  fun rte_cpu_is_supported : LibC::Int
  fun rte_crypto_op_alloc(mempool : RteMempool*, type : RteCryptoOpType) : RteCryptoOp*
  fun rte_crypto_op_attach_sym_session(op : RteCryptoOp*, sess : RteCryptodevSymSession*) : LibC::Int
  fun rte_crypto_op_bulk_alloc(mempool : RteMempool*, type : RteCryptoOpType, ops : RteCryptoOp**, nb_ops : Uint16T) : LibC::UInt
  fun rte_crypto_op_free(op : RteCryptoOp*)
  fun rte_crypto_op_pool_create(name : LibC::Char*, type : RteCryptoOpType, nb_elts : LibC::UInt, cache_size : LibC::UInt, priv_size : Uint16T, socket_id : LibC::Int) : RteMempool*
  fun rte_crypto_op_sym_xforms_alloc(op : RteCryptoOp*, nb_xforms : Uint8T) : RteCryptoSymXform*
  fun rte_crypto_sym_op_alloc_from_mbuf_priv_data(m : RteMbuf*) : RteCryptoOp*
  fun rte_cryptodev_callback_register(dev_id : Uint8T, event : RteCryptodevEventType, cb_fn : RteCryptodevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_cryptodev_callback_unregister(dev_id : Uint8T, event : RteCryptodevEventType, cb_fn : RteCryptodevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_cryptodev_close(dev_id : Uint8T) : LibC::Int
  fun rte_cryptodev_configure(dev_id : Uint8T, config : RteCryptodevConfig*) : LibC::Int
  fun rte_cryptodev_count : Uint8T
  fun rte_cryptodev_dequeue_burst(dev_id : Uint8T, qp_id : Uint16T, ops : RteCryptoOp**, nb_ops : Uint16T) : Uint16T
  fun rte_cryptodev_device_count_by_driver(driver_id : Uint8T) : Uint8T
  fun rte_cryptodev_devices_get(driver_name : LibC::Char*, devices : Uint8T*, nb_devices : Uint8T) : Uint8T
  fun rte_cryptodev_driver_id_get(name : LibC::Char*) : LibC::Int
  fun rte_cryptodev_driver_name_get(driver_id : Uint8T) : LibC::Char*
  fun rte_cryptodev_enqueue_burst(dev_id : Uint8T, qp_id : Uint16T, ops : RteCryptoOp**, nb_ops : Uint16T) : Uint16T
  fun rte_cryptodev_get_aead_algo_enum(algo_enum : RteCryptoAeadAlgorithm*, algo_string : LibC::Char*) : LibC::Int
  fun rte_cryptodev_get_auth_algo_enum(algo_enum : RteCryptoAuthAlgorithm*, algo_string : LibC::Char*) : LibC::Int
  fun rte_cryptodev_get_cipher_algo_enum(algo_enum : RteCryptoCipherAlgorithm*, algo_string : LibC::Char*) : LibC::Int
  fun rte_cryptodev_get_dev_id(name : LibC::Char*) : LibC::Int
  fun rte_cryptodev_get_feature_name(flag : Uint64T) : LibC::Char*
  fun rte_cryptodev_get_header_session_size : LibC::UInt
  fun rte_cryptodev_get_private_session_size(dev_id : Uint8T) : LibC::UInt
  fun rte_cryptodev_get_sec_ctx(dev_id : Uint8T) : Void*
  fun rte_cryptodev_info_get(dev_id : Uint8T, dev_info : RteCryptodevInfo*)
  fun rte_cryptodev_name_get(dev_id : Uint8T) : LibC::Char*
  fun rte_cryptodev_queue_pair_attach_sym_session(dev_id : Uint8T, qp_id : Uint16T, session : RteCryptodevSymSession*) : LibC::Int
  fun rte_cryptodev_queue_pair_count(dev_id : Uint8T) : Uint16T
  fun rte_cryptodev_queue_pair_detach_sym_session(dev_id : Uint8T, qp_id : Uint16T, session : RteCryptodevSymSession*) : LibC::Int
  fun rte_cryptodev_queue_pair_setup(dev_id : Uint8T, queue_pair_id : Uint16T, qp_conf : RteCryptodevQpConf*, socket_id : LibC::Int, session_pool : RteMempool*) : LibC::Int
  fun rte_cryptodev_queue_pair_start(dev_id : Uint8T, queue_pair_id : Uint16T) : LibC::Int
  fun rte_cryptodev_queue_pair_stop(dev_id : Uint8T, queue_pair_id : Uint16T) : LibC::Int
  fun rte_cryptodev_socket_id(dev_id : Uint8T) : LibC::Int
  fun rte_cryptodev_start(dev_id : Uint8T) : LibC::Int
  fun rte_cryptodev_stats_get(dev_id : Uint8T, stats : RteCryptodevStats*) : LibC::Int
  fun rte_cryptodev_stats_reset(dev_id : Uint8T)
  fun rte_cryptodev_stop(dev_id : Uint8T)
  fun rte_cryptodev_sym_capability_check_aead(capability : RteCryptodevSymmetricCapability*, key_size : Uint16T, digest_size : Uint16T, aad_size : Uint16T, iv_size : Uint16T) : LibC::Int
  fun rte_cryptodev_sym_capability_check_auth(capability : RteCryptodevSymmetricCapability*, key_size : Uint16T, digest_size : Uint16T, iv_size : Uint16T) : LibC::Int
  fun rte_cryptodev_sym_capability_check_cipher(capability : RteCryptodevSymmetricCapability*, key_size : Uint16T, iv_size : Uint16T) : LibC::Int
  fun rte_cryptodev_sym_capability_get(dev_id : Uint8T, idx : RteCryptodevSymCapabilityIdx*) : RteCryptodevSymmetricCapability*
  fun rte_cryptodev_sym_session_clear(dev_id : Uint8T, sess : RteCryptodevSymSession*) : LibC::Int
  fun rte_cryptodev_sym_session_create(mempool : RteMempool*) : RteCryptodevSymSession*
  fun rte_cryptodev_sym_session_free(sess : RteCryptodevSymSession*) : LibC::Int
  fun rte_cryptodev_sym_session_init(dev_id : Uint8T, sess : RteCryptodevSymSession*, xforms : RteCryptoSymXform*, mempool : RteMempool*) : LibC::Int
  fun rte_ctrlmbuf_init(mp : RteMempool*, opaque_arg : Void*, m : Void*, i : LibC::UInt)
  fun rte_delay_ms(ms : LibC::UInt)
  fun rte_delay_us_block(us : LibC::UInt)
  fun rte_delay_us_callback_register(userfunc : (LibC::UInt -> Void))
  fun rte_dump_physmem_layout(f : Void*)
  fun rte_dump_registers
  fun rte_dump_stack
  fun rte_dump_tailq(f : Void*)
  fun rte_eal_cleanup : LibC::Int
  fun rte_eal_compare_pci_addr(addr : RtePciAddr*, addr2 : RtePciAddr*) : LibC::Int
  fun rte_eal_create_uio_dev : LibC::Int
  fun rte_eal_dev_attach(name : LibC::Char*, devargs : LibC::Char*) : LibC::Int
  fun rte_eal_dev_detach(dev : RteDevice*) : LibC::Int
  fun rte_eal_devargs_add(devtype : RteDevtype, devargs_str : LibC::Char*) : LibC::Int
  fun rte_eal_devargs_dump(f : Void*)
  fun rte_eal_devargs_insert(da : RteDevargs*) : LibC::Int
  fun rte_eal_devargs_parse(dev : LibC::Char*, da : RteDevargs*) : LibC::Int
  fun rte_eal_devargs_remove(busname : LibC::Char*, devname : LibC::Char*) : LibC::Int
  fun rte_eal_devargs_type_count(devtype : RteDevtype) : LibC::UInt
  fun rte_eal_get_configuration : RteConfig*
  fun rte_eal_get_lcore_state(slave_id : LibC::UInt) : RteLcoreStateT
  fun rte_eal_get_physmem_layout : RteMemseg*
  fun rte_eal_get_physmem_size : Uint64T
  fun rte_eal_has_hugepages : LibC::Int
  fun rte_eal_has_pci : LibC::Int
  fun rte_eal_hotplug_add(busname : LibC::Char*, devname : LibC::Char*, devargs : LibC::Char*) : LibC::Int
  fun rte_eal_hotplug_remove(busname : LibC::Char*, devname : LibC::Char*) : LibC::Int
  fun rte_eal_init(argc : LibC::Int, argv : LibC::Char**) : LibC::Int
  fun rte_eal_iopl_init : LibC::Int
  fun rte_eal_iova_mode : RteIovaMode
  fun rte_eal_lcore_role(lcore_id : LibC::UInt) : RteLcoreRoleT
  fun rte_eal_mbuf_default_mempool_ops : LibC::Char*
  fun rte_eal_mbuf_user_pool_ops : LibC::Char*
  fun rte_eal_mcfg_wait_complete(mcfg : RteMemConfig*)
  fun rte_eal_mp_remote_launch(f : (Void* -> LibC::Int), arg : Void*, call_master : RteRmtCallMasterT) : LibC::Int
  fun rte_eal_mp_wait_lcore
  fun rte_eal_parse_devargs_str(devargs_str : LibC::Char*, drvname : LibC::Char**, drvargs : LibC::Char**) : LibC::Int
  fun rte_eal_primary_proc_alive(config_file_path : LibC::Char*) : LibC::Int
  fun rte_eal_process_type : RteProcTypeT
  fun rte_eal_remote_launch(f : (Void* -> LibC::Int), arg : Void*, slave_id : LibC::UInt) : LibC::Int
  fun rte_eal_tailq_lookup(name : LibC::Char*) : RteTailqHead*
  fun rte_eal_tailq_register(t : RteTailqElem*) : LibC::Int
  fun rte_eal_using_phys_addrs : LibC::Int
  fun rte_eal_vfio_intr_mode : RteIntrMode
  fun rte_eal_wait_lcore(slave_id : LibC::UInt) : LibC::Int
  fun rte_epoll_ctl(epfd : LibC::Int, op : LibC::Int, fd : LibC::Int, event : RteEpollEvent*) : LibC::Int
  fun rte_epoll_wait(epfd : LibC::Int, events : RteEpollEvent*, maxevents : LibC::Int, timeout : LibC::Int) : LibC::Int
  fun rte_eth_add_first_rx_callback(port_id : Uint16T, queue_id : Uint16T, fn : RteRxCallbackFn, user_param : Void*) : Void*
  fun rte_eth_add_rx_callback(port_id : Uint16T, queue_id : Uint16T, fn : RteRxCallbackFn, user_param : Void*) : Void*
  fun rte_eth_add_tx_callback(port_id : Uint16T, queue_id : Uint16T, fn : RteTxCallbackFn, user_param : Void*) : Void*
  fun rte_eth_allmulticast_disable(port_id : Uint16T)
  fun rte_eth_allmulticast_enable(port_id : Uint16T)
  fun rte_eth_allmulticast_get(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_adjust_nb_rx_tx_desc(port_id : Uint16T, nb_rx_desc : Uint16T*, nb_tx_desc : Uint16T*) : LibC::Int
  fun rte_eth_dev_allocate(name : LibC::Char*) : RteEthDev*
  fun rte_eth_dev_allocated(name : LibC::Char*) : RteEthDev*
  fun rte_eth_dev_attach(devargs : LibC::Char*, port_id : Uint16T*) : LibC::Int
  fun rte_eth_dev_attach_secondary(name : LibC::Char*) : RteEthDev*
  fun rte_eth_dev_callback_register(port_id : Uint16T, event : RteEthEventType, cb_fn : RteEthDevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_eth_dev_callback_unregister(port_id : Uint16T, event : RteEthEventType, cb_fn : RteEthDevCbFn, cb_arg : Void*) : LibC::Int
  fun rte_eth_dev_close(port_id : Uint16T)
  fun rte_eth_dev_configure(port_id : Uint16T, nb_rx_queue : Uint16T, nb_tx_queue : Uint16T, eth_conf : RteEthConf*) : LibC::Int
  fun rte_eth_dev_count : Uint16T
  fun rte_eth_dev_default_mac_addr_set(port_id : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_eth_dev_detach(port_id : Uint16T, devname : LibC::Char*) : LibC::Int
  fun rte_eth_dev_filter_ctrl(port_id : Uint16T, filter_type : RteFilterType, filter_op : RteFilterOp, arg : Void*) : LibC::Int
  fun rte_eth_dev_filter_supported(port_id : Uint16T, filter_type : RteFilterType) : LibC::Int
  fun rte_eth_dev_flow_ctrl_get(port_id : Uint16T, fc_conf : RteEthFcConf*) : LibC::Int
  fun rte_eth_dev_flow_ctrl_set(port_id : Uint16T, fc_conf : RteEthFcConf*) : LibC::Int
  fun rte_eth_dev_fw_version_get(port_id : Uint16T, fw_version : LibC::Char*, fw_size : LibC::Int) : LibC::Int
  fun rte_eth_dev_get_dcb_info(port_id : Uint16T, dcb_info : RteEthDcbInfo*) : LibC::Int
  fun rte_eth_dev_get_eeprom(port_id : Uint16T, info : RteDevEepromInfo*) : LibC::Int
  fun rte_eth_dev_get_eeprom_length(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_get_mtu(port_id : Uint16T, mtu : Uint16T*) : LibC::Int
  fun rte_eth_dev_get_name_by_port(port_id : Uint16T, name : LibC::Char*) : LibC::Int
  fun rte_eth_dev_get_port_by_name(name : LibC::Char*, port_id : Uint16T*) : LibC::Int
  fun rte_eth_dev_get_reg_info(port_id : Uint16T, info : RteDevRegInfo*) : LibC::Int
  fun rte_eth_dev_get_sec_ctx(port_id : Uint8T) : Void*
  fun rte_eth_dev_get_supported_ptypes(port_id : Uint16T, ptype_mask : Uint32T, ptypes : Uint32T*, num : LibC::Int) : LibC::Int
  fun rte_eth_dev_get_vlan_offload(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_info_get(port_id : Uint16T, dev_info : RteEthDevInfo*)
  fun rte_eth_dev_is_removed(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_is_valid_port(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_l2_tunnel_eth_type_conf(port_id : Uint16T, l2_tunnel : RteEthL2TunnelConf*) : LibC::Int
  fun rte_eth_dev_l2_tunnel_offload_set(port_id : Uint16T, l2_tunnel : RteEthL2TunnelConf*, mask : Uint32T, en : Uint8T) : LibC::Int
  fun rte_eth_dev_mac_addr_add(port_id : Uint16T, mac_addr : EtherAddr*, pool : Uint32T) : LibC::Int
  fun rte_eth_dev_mac_addr_remove(port_id : Uint16T, mac_addr : EtherAddr*) : LibC::Int
  fun rte_eth_dev_owner_delete(owner_id : Uint64T)
  fun rte_eth_dev_owner_get(port_id : Uint16T, owner : RteEthDevOwner*) : LibC::Int
  fun rte_eth_dev_owner_new(owner_id : Uint64T*) : LibC::Int
  fun rte_eth_dev_owner_set(port_id : Uint16T, owner : RteEthDevOwner*) : LibC::Int
  fun rte_eth_dev_owner_unset(port_id : Uint16T, owner_id : Uint64T) : LibC::Int
  fun rte_eth_dev_pool_ops_supported(port_id : Uint16T, pool : LibC::Char*) : LibC::Int
  fun rte_eth_dev_priority_flow_ctrl_set(port_id : Uint16T, pfc_conf : RteEthPfcConf*) : LibC::Int
  fun rte_eth_dev_release_port(eth_dev : RteEthDev*) : LibC::Int
  fun rte_eth_dev_reset(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_rss_hash_conf_get(port_id : Uint16T, rss_conf : RteEthRssConf*) : LibC::Int
  fun rte_eth_dev_rss_hash_update(port_id : Uint16T, rss_conf : RteEthRssConf*) : LibC::Int
  fun rte_eth_dev_rss_reta_query(port_id : Uint16T, reta_conf : RteEthRssRetaEntry64*, reta_size : Uint16T) : LibC::Int
  fun rte_eth_dev_rss_reta_update(port_id : Uint16T, reta_conf : RteEthRssRetaEntry64*, reta_size : Uint16T) : LibC::Int
  fun rte_eth_dev_rx_intr_ctl(port_id : Uint16T, epfd : LibC::Int, op : LibC::Int, data : Void*) : LibC::Int
  fun rte_eth_dev_rx_intr_ctl_q(port_id : Uint16T, queue_id : Uint16T, epfd : LibC::Int, op : LibC::Int, data : Void*) : LibC::Int
  fun rte_eth_dev_rx_intr_disable(port_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_rx_intr_enable(port_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_rx_offload_name(offload : Uint64T) : LibC::Char*
  fun rte_eth_dev_rx_queue_start(port_id : Uint16T, rx_queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_rx_queue_stop(port_id : Uint16T, rx_queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_set_eeprom(port_id : Uint16T, info : RteDevEepromInfo*) : LibC::Int
  fun rte_eth_dev_set_link_down(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_set_link_up(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_set_mc_addr_list(port_id : Uint16T, mc_addr_set : EtherAddr*, nb_mc_addr : Uint32T) : LibC::Int
  fun rte_eth_dev_set_mtu(port_id : Uint16T, mtu : Uint16T) : LibC::Int
  fun rte_eth_dev_set_rx_queue_stats_mapping(port_id : Uint16T, rx_queue_id : Uint16T, stat_idx : Uint8T) : LibC::Int
  fun rte_eth_dev_set_tx_queue_stats_mapping(port_id : Uint16T, tx_queue_id : Uint16T, stat_idx : Uint8T) : LibC::Int
  fun rte_eth_dev_set_vlan_ether_type(port_id : Uint16T, vlan_type : RteVlanType, tag_type : Uint16T) : LibC::Int
  fun rte_eth_dev_set_vlan_offload(port_id : Uint16T, offload_mask : LibC::Int) : LibC::Int
  fun rte_eth_dev_set_vlan_pvid(port_id : Uint16T, pvid : Uint16T, on : LibC::Int) : LibC::Int
  fun rte_eth_dev_set_vlan_strip_on_queue(port_id : Uint16T, rx_queue_id : Uint16T, on : LibC::Int) : LibC::Int
  fun rte_eth_dev_socket_id(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_start(port_id : Uint16T) : LibC::Int
  fun rte_eth_dev_stop(port_id : Uint16T)
  fun rte_eth_dev_tx_offload_name(offload : Uint64T) : LibC::Char*
  fun rte_eth_dev_tx_queue_start(port_id : Uint16T, tx_queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_tx_queue_stop(port_id : Uint16T, tx_queue_id : Uint16T) : LibC::Int
  fun rte_eth_dev_uc_all_hash_table_set(port_id : Uint16T, on : Uint8T) : LibC::Int
  fun rte_eth_dev_uc_hash_table_set(port_id : Uint16T, addr : EtherAddr*, on : Uint8T) : LibC::Int
  fun rte_eth_dev_udp_tunnel_port_add(port_id : Uint16T, tunnel_udp : RteEthUdpTunnel*) : LibC::Int
  fun rte_eth_dev_udp_tunnel_port_delete(port_id : Uint16T, tunnel_udp : RteEthUdpTunnel*) : LibC::Int
  fun rte_eth_dev_vlan_filter(port_id : Uint16T, vlan_id : Uint16T, on : LibC::Int) : LibC::Int
  fun rte_eth_dma_zone_reserve(eth_dev : RteEthDev*, name : LibC::Char*, queue_id : Uint16T, size : LibC::Int, align : LibC::UInt, socket_id : LibC::Int) : RteMemzone*
  fun rte_eth_find_next(port_id : Uint16T) : Uint16T
  fun rte_eth_find_next_owned_by(port_id : Uint16T, owner_id : Uint64T) : Uint64T
  fun rte_eth_led_off(port_id : Uint16T) : LibC::Int
  fun rte_eth_led_on(port_id : Uint16T) : LibC::Int
  fun rte_eth_link_get(port_id : Uint16T, link : RteEthLink*)
  fun rte_eth_link_get_nowait(port_id : Uint16T, link : RteEthLink*)
  fun rte_eth_macaddr_get(port_id : Uint16T, mac_addr : EtherAddr*)
  fun rte_eth_mirror_rule_reset(port_id : Uint16T, rule_id : Uint8T) : LibC::Int
  fun rte_eth_mirror_rule_set(port_id : Uint16T, mirror_conf : RteEthMirrorConf*, rule_id : Uint8T, on : Uint8T) : LibC::Int
  fun rte_eth_promiscuous_disable(port_id : Uint16T)
  fun rte_eth_promiscuous_enable(port_id : Uint16T)
  fun rte_eth_promiscuous_get(port_id : Uint16T) : LibC::Int
  fun rte_eth_remove_rx_callback(port_id : Uint16T, queue_id : Uint16T, user_cb : RteEthRxtxCallback*) : LibC::Int
  fun rte_eth_remove_tx_callback(port_id : Uint16T, queue_id : Uint16T, user_cb : RteEthRxtxCallback*) : LibC::Int
  fun rte_eth_rx_burst(port_id : Uint16T, queue_id : Uint16T, rx_pkts : RteMbuf**, nb_pkts : Uint16T) : Uint16T
  fun rte_eth_rx_descriptor_done(port_id : Uint16T, queue_id : Uint16T, offset : Uint16T) : LibC::Int
  fun rte_eth_rx_descriptor_status(port_id : Uint16T, queue_id : Uint16T, offset : Uint16T) : LibC::Int
  fun rte_eth_rx_queue_count(port_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_eth_rx_queue_info_get(port_id : Uint16T, queue_id : Uint16T, qinfo : RteEthRxqInfo*) : LibC::Int
  fun rte_eth_rx_queue_setup(port_id : Uint16T, rx_queue_id : Uint16T, nb_rx_desc : Uint16T, socket_id : LibC::UInt, rx_conf : RteEthRxconf*, mb_pool : RteMempool*) : LibC::Int
  fun rte_eth_set_queue_rate_limit(port_id : Uint16T, queue_idx : Uint16T, tx_rate : Uint16T) : LibC::Int
  fun rte_eth_speed_bitflag(speed : Uint32T, duplex : LibC::Int) : Uint32T
  fun rte_eth_stats_get(port_id : Uint16T, stats : RteEthStats*) : LibC::Int
  fun rte_eth_stats_reset(port_id : Uint16T) : LibC::Int
  fun rte_eth_timesync_adjust_time(port_id : Uint16T, delta : Int64T) : LibC::Int
  fun rte_eth_timesync_disable(port_id : Uint16T) : LibC::Int
  fun rte_eth_timesync_enable(port_id : Uint16T) : LibC::Int
  fun rte_eth_timesync_read_rx_timestamp(port_id : Uint16T, timestamp : Timespec*, flags : Uint32T) : LibC::Int
  fun rte_eth_timesync_read_time(port_id : Uint16T, time : Timespec*) : LibC::Int
  fun rte_eth_timesync_read_tx_timestamp(port_id : Uint16T, timestamp : Timespec*) : LibC::Int
  fun rte_eth_timesync_write_time(port_id : Uint16T, time : Timespec*) : LibC::Int
  fun rte_eth_tx_buffer(port_id : Uint16T, queue_id : Uint16T, buffer : RteEthDevTxBuffer*, tx_pkt : RteMbuf*) : Uint16T
  fun rte_eth_tx_buffer_count_callback(pkts : RteMbuf**, unsent : Uint16T, userdata : Void*)
  fun rte_eth_tx_buffer_drop_callback(pkts : RteMbuf**, unsent : Uint16T, userdata : Void*)
  fun rte_eth_tx_buffer_flush(port_id : Uint16T, queue_id : Uint16T, buffer : RteEthDevTxBuffer*) : Uint16T
  fun rte_eth_tx_buffer_init(buffer : RteEthDevTxBuffer*, size : Uint16T) : LibC::Int
  fun rte_eth_tx_buffer_set_err_callback(buffer : RteEthDevTxBuffer*, callback : BufferTxErrorFn, userdata : Void*) : LibC::Int
  fun rte_eth_tx_burst(port_id : Uint16T, queue_id : Uint16T, tx_pkts : RteMbuf**, nb_pkts : Uint16T) : Uint16T
  fun rte_eth_tx_descriptor_status(port_id : Uint16T, queue_id : Uint16T, offset : Uint16T) : LibC::Int
  fun rte_eth_tx_done_cleanup(port_id : Uint16T, queue_id : Uint16T, free_cnt : Uint32T) : LibC::Int
  fun rte_eth_tx_prepare(port_id : Uint16T, queue_id : Uint16T, tx_pkts : RteMbuf**, nb_pkts : Uint16T) : Uint16T
  fun rte_eth_tx_queue_info_get(port_id : Uint16T, queue_id : Uint16T, qinfo : RteEthTxqInfo*) : LibC::Int
  fun rte_eth_tx_queue_setup(port_id : Uint16T, tx_queue_id : Uint16T, nb_tx_desc : Uint16T, socket_id : LibC::UInt, tx_conf : RteEthTxconf*) : LibC::Int
  fun rte_eth_xstats_get(port_id : Uint16T, xstats : RteEthXstat*, n : LibC::UInt) : LibC::Int
  fun rte_eth_xstats_get_by_id(port_id : Uint16T, ids : Uint64T*, values : Uint64T*, size : LibC::UInt) : LibC::Int
  fun rte_eth_xstats_get_id_by_name(port_id : Uint16T, xstat_name : LibC::Char*, id : Uint64T*) : LibC::Int
  fun rte_eth_xstats_get_names(port_id : Uint16T, xstats_names : RteEthXstatName*, size : LibC::UInt) : LibC::Int
  fun rte_eth_xstats_get_names_by_id(port_id : Uint16T, xstats_names : RteEthXstatName*, size : LibC::UInt, ids : Uint64T*) : LibC::Int
  fun rte_eth_xstats_reset(port_id : Uint16T)
  fun rte_event_dequeue_burst(dev_id : Uint8T, port_id : Uint8T, ev : RteEvent*, nb_events : Uint16T, timeout_ticks : Uint64T) : Uint16T
  fun rte_event_dequeue_timeout_ticks(dev_id : Uint8T, ns : Uint64T, timeout_ticks : Uint64T*) : LibC::Int
  fun rte_event_dev_attr_get(dev_id : Uint8T, attr_id : Uint32T, attr_value : Uint32T*) : LibC::Int
  fun rte_event_dev_close(dev_id : Uint8T) : LibC::Int
  fun rte_event_dev_configure(dev_id : Uint8T, dev_conf : RteEventDevConfig*) : LibC::Int
  fun rte_event_dev_count : Uint8T
  fun rte_event_dev_dump(dev_id : Uint8T, f : Void*) : LibC::Int
  fun rte_event_dev_get_dev_id(name : LibC::Char*) : LibC::Int
  fun rte_event_dev_info_get(dev_id : Uint8T, dev_info : RteEventDevInfo*) : LibC::Int
  fun rte_event_dev_selftest(dev_id : Uint8T) : LibC::Int
  fun rte_event_dev_service_id_get(dev_id : Uint8T, service_id : Uint32T*) : LibC::Int
  fun rte_event_dev_socket_id(dev_id : Uint8T) : LibC::Int
  fun rte_event_dev_start(dev_id : Uint8T) : LibC::Int
  fun rte_event_dev_stop(dev_id : Uint8T)
  fun rte_event_dev_xstats_by_name_get(dev_id : Uint8T, name : LibC::Char*, id : LibC::UInt*) : Uint64T
  fun rte_event_dev_xstats_get(dev_id : Uint8T, mode : RteEventDevXstatsMode, queue_port_id : Uint8T, ids : LibC::UInt*, values : Uint64T*, n : LibC::UInt) : LibC::Int
  fun rte_event_dev_xstats_names_get(dev_id : Uint8T, mode : RteEventDevXstatsMode, queue_port_id : Uint8T, xstats_names : RteEventDevXstatsName*, ids : LibC::UInt*, size : LibC::UInt) : LibC::Int
  fun rte_event_dev_xstats_reset(dev_id : Uint8T, mode : RteEventDevXstatsMode, queue_port_id : Int16T, ids : Uint32T*, nb_ids : Uint32T) : LibC::Int
  fun rte_event_enqueue_burst(dev_id : Uint8T, port_id : Uint8T, ev : RteEvent*, nb_events : Uint16T) : Uint16T
  fun rte_event_enqueue_forward_burst(dev_id : Uint8T, port_id : Uint8T, ev : RteEvent*, nb_events : Uint16T) : Uint16T
  fun rte_event_enqueue_new_burst(dev_id : Uint8T, port_id : Uint8T, ev : RteEvent*, nb_events : Uint16T) : Uint16T
  fun rte_event_eth_rx_adapter_caps_get(dev_id : Uint8T, eth_port_id : Uint8T, caps : Uint32T*) : LibC::Int
  fun rte_event_pmd_allocate(name : LibC::Char*, socket_id : LibC::Int) : RteEventdev*
  fun rte_event_pmd_get_named_dev(name : LibC::Char*) : RteEventdev*
  fun rte_event_pmd_is_valid_dev(dev_id : Uint8T) : LibC::UInt
  fun rte_event_pmd_release(eventdev : RteEventdev*) : LibC::Int
  fun rte_event_port_attr_get(dev_id : Uint8T, port_id : Uint8T, attr_id : Uint32T, attr_value : Uint32T*) : LibC::Int
  fun rte_event_port_default_conf_get(dev_id : Uint8T, port_id : Uint8T, port_conf : RteEventPortConf*) : LibC::Int
  fun rte_event_port_link(dev_id : Uint8T, port_id : Uint8T, queues : Uint8T*, priorities : Uint8T*, nb_links : Uint16T) : LibC::Int
  fun rte_event_port_links_get(dev_id : Uint8T, port_id : Uint8T, queues : Uint8T*, priorities : Uint8T*) : LibC::Int
  fun rte_event_port_setup(dev_id : Uint8T, port_id : Uint8T, port_conf : RteEventPortConf*) : LibC::Int
  fun rte_event_port_unlink(dev_id : Uint8T, port_id : Uint8T, queues : Uint8T*, nb_unlinks : Uint16T) : LibC::Int
  fun rte_event_queue_attr_get(dev_id : Uint8T, queue_id : Uint8T, attr_id : Uint32T, attr_value : Uint32T*) : LibC::Int
  fun rte_event_queue_default_conf_get(dev_id : Uint8T, queue_id : Uint8T, queue_conf : RteEventQueueConf*) : LibC::Int
  fun rte_event_queue_setup(dev_id : Uint8T, queue_id : Uint8T, queue_conf : RteEventQueueConf*) : LibC::Int
  fun rte_exit(exit_code : LibC::Int, format : LibC::Char*, ...) : NoReturn
  fun rte_flow_copy : LibC::Int
  fun rte_flow_create(port_id : Uint16T, attr : RteFlowAttr*, pattern : RteFlowItem*, actions : RteFlowAction*, error : RteFlowError*) : RteFlow*
  fun rte_flow_destroy(port_id : Uint16T, flow : RteFlow*, error : RteFlowError*) : LibC::Int
  fun rte_flow_error_set(error : RteFlowError*, code : LibC::Int, type : RteFlowErrorType, cause : Void*, message : LibC::Char*) : LibC::Int
  fun rte_flow_flush(port_id : Uint16T, error : RteFlowError*) : LibC::Int
  fun rte_flow_isolate(port_id : Uint16T, set : LibC::Int, error : RteFlowError*) : LibC::Int
  fun rte_flow_query(port_id : Uint16T, flow : RteFlow*, action : RteFlowActionType, data : Void*, error : RteFlowError*) : LibC::Int
  fun rte_flow_validate(port_id : Uint16T, attr : RteFlowAttr*, pattern : RteFlowItem*, actions : RteFlowAction*, error : RteFlowError*) : LibC::Int
  fun rte_free(ptr : Void*)
  fun rte_get_master_lcore : LibC::UInt
  fun rte_get_next_lcore(i : LibC::UInt, skip_master : LibC::Int, wrap : LibC::Int) : LibC::UInt
  fun rte_get_ptype_inner_l2_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_inner_l3_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_inner_l4_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_l2_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_l3_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_l4_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_ptype_name(ptype : Uint32T, buf : LibC::Char*, buflen : LibC::Int) : LibC::Int
  fun rte_get_ptype_tunnel_name(ptype : Uint32T) : LibC::Char*
  fun rte_get_rx_ol_flag_list(mask : Uint64T, buf : LibC::Char*, buflen : LibC::Int) : LibC::Int
  fun rte_get_rx_ol_flag_name(mask : Uint64T) : LibC::Char*
  fun rte_get_timer_cycles : Uint64T
  fun rte_get_timer_hz : Uint64T
  fun rte_get_tsc_cycles : Uint64T
  fun rte_get_tsc_hz : Uint64T
  fun rte_get_tx_ol_flag_list(mask : Uint64T, buf : LibC::Char*, buflen : LibC::Int) : LibC::Int
  fun rte_get_tx_ol_flag_name(mask : Uint64T) : LibC::Char*
  fun rte_gettid : LibC::Int
  fun rte_hash_crc(data : Void*, data_len : Uint32T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_1byte(data : Uint8T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_2byte(data : Uint16T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_4byte(data : Uint32T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_8byte(data : Uint64T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_init_alg
  fun rte_hash_crc_set_alg(alg : Uint8T)
  fun rte_intr_allow_others(intr_handle : RteIntrHandle*) : LibC::Int
  fun rte_intr_callback_register(intr_handle : RteIntrHandle*, cb : RteIntrCallbackFn, cb_arg : Void*) : LibC::Int
  fun rte_intr_callback_unregister(intr_handle : RteIntrHandle*, cb : RteIntrCallbackFn, cb_arg : Void*) : LibC::Int
  fun rte_intr_cap_multiple(intr_handle : RteIntrHandle*) : LibC::Int
  fun rte_intr_disable(intr_handle : RteIntrHandle*) : LibC::Int
  fun rte_intr_dp_is_en(intr_handle : RteIntrHandle*) : LibC::Int
  fun rte_intr_efd_disable(intr_handle : RteIntrHandle*)
  fun rte_intr_efd_enable(intr_handle : RteIntrHandle*, nb_efd : Uint32T) : LibC::Int
  fun rte_intr_enable(intr_handle : RteIntrHandle*) : LibC::Int
  fun rte_intr_free_epoll_fd(intr_handle : RteIntrHandle*)
  fun rte_intr_rx_ctl(intr_handle : RteIntrHandle*, epfd : LibC::Int, op : LibC::Int, vec : LibC::UInt, data : Void*) : LibC::Int
  fun rte_intr_tls_epfd : LibC::Int
  fun rte_ipv4_cksum(ipv4_hdr : Ipv4Hdr*) : Uint16T
  fun rte_ipv4_phdr_cksum(ipv4_hdr : Ipv4Hdr*, ol_flags : Uint64T) : Uint16T
  fun rte_ipv4_udptcp_cksum(ipv4_hdr : Ipv4Hdr*, l4_hdr : Void*) : Uint16T
  fun rte_ipv6_phdr_cksum(ipv6_hdr : Ipv6Hdr*, ol_flags : Uint64T) : Uint16T
  fun rte_ipv6_udptcp_cksum(ipv6_hdr : Ipv6Hdr*, l4_hdr : Void*) : Uint16T
  fun rte_is_aligned(ptr : Void*, align : LibC::UInt) : LibC::Int
  fun rte_is_ctrlmbuf(m : RteMbuf*) : LibC::Int
  fun rte_is_power_of_2(n : Uint32T) : LibC::Int
  fun rte_jhash(key : Void*, length : Uint32T, initval : Uint32T) : Uint32T
  fun rte_jhash_1word(a : Uint32T, initval : Uint32T) : Uint32T
  fun rte_jhash_2hashes(key : Void*, length : Uint32T, pc : Uint32T*, pb : Uint32T*)
  fun rte_jhash_2words(a : Uint32T, b : Uint32T, initval : Uint32T) : Uint32T
  fun rte_jhash_32b(k : Uint32T*, length : Uint32T, initval : Uint32T) : Uint32T
  fun rte_jhash_32b_2hashes(k : Uint32T*, length : Uint32T, pc : Uint32T*, pb : Uint32T*)
  fun rte_jhash_3words(a : Uint32T, b : Uint32T, c : Uint32T, initval : Uint32T) : Uint32T
  fun rte_kni_alloc(pktmbuf_pool : RteMempool*, conf : RteKniConf*, ops : RteKniOps*) : RteKni*
  fun rte_kni_close
  fun rte_kni_get(name : LibC::Char*) : RteKni*
  fun rte_kni_get_name(kni : RteKni*) : LibC::Char*
  fun rte_kni_handle_request(kni : RteKni*) : LibC::Int
  fun rte_kni_init(max_kni_ifaces : LibC::UInt)
  fun rte_kni_register_handlers(kni : RteKni*, ops : RteKniOps*) : LibC::Int
  fun rte_kni_release(kni : RteKni*) : LibC::Int
  fun rte_kni_rx_burst(kni : RteKni*, mbufs : RteMbuf**, num : LibC::UInt) : LibC::UInt
  fun rte_kni_tx_burst(kni : RteKni*, mbufs : RteMbuf**, num : LibC::UInt) : LibC::UInt
  fun rte_kni_unregister_handlers(kni : RteKni*) : LibC::Int
  fun rte_kvargs_count(kvlist : RteKvargs*, key_match : LibC::Char*) : LibC::UInt
  fun rte_kvargs_free(kvlist : RteKvargs*)
  fun rte_kvargs_parse(args : LibC::Char*, valid_keys : LibC::Char**) : RteKvargs*
  fun rte_kvargs_process(kvlist : RteKvargs*, key_match : LibC::Char*, handler : ArgHandlerT, opaque_arg : Void*) : LibC::Int
  fun rte_lcore_count : LibC::UInt
  fun rte_lcore_has_role(lcore_id : LibC::UInt, role : RteLcoreRoleT) : LibC::Int
  fun rte_lcore_id : LibC::UInt
  fun rte_lcore_index(lcore_id : LibC::Int) : LibC::Int
  fun rte_lcore_is_enabled(lcore_id : LibC::UInt) : LibC::Int
  fun rte_lcore_to_socket_id(lcore_id : LibC::UInt) : LibC::UInt
  fun rte_log(level : Uint32T, logtype : Uint32T, format : LibC::Char*, ...) : LibC::Int
  fun rte_log2_u32(v : Uint32T) : Uint32T
  fun rte_log_cur_msg_loglevel : LibC::Int
  fun rte_log_cur_msg_logtype : LibC::Int
  fun rte_log_dump(f : Void*)
  fun rte_log_get_global_level : Uint32T
  fun rte_log_get_level(logtype : Uint32T) : LibC::Int
  fun rte_log_register(name : LibC::Char*) : LibC::Int
  fun rte_log_set_global_level(level : Uint32T)
  fun rte_log_set_level(logtype : Uint32T, level : Uint32T) : LibC::Int
  fun rte_log_set_level_regexp(pattern : LibC::Char*, level : Uint32T) : LibC::Int
  fun rte_lpm_add(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  fun rte_lpm_add_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  fun rte_lpm_add_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T, next_hop : Uint8T) : LibC::Int
  fun rte_lpm_create(name : LibC::Char*, socket_id : LibC::Int, config : RteLpmConfig*) : RteLpm*
  fun rte_lpm_create_v1604(name : LibC::Char*, socket_id : LibC::Int, config : RteLpmConfig*) : RteLpm*
  fun rte_lpm_create_v20(name : LibC::Char*, socket_id : LibC::Int, max_rules : LibC::Int, flags : LibC::Int) : RteLpmV20*
  fun rte_lpm_delete(lpm : RteLpm*, ip : Uint32T, depth : Uint8T) : LibC::Int
  fun rte_lpm_delete_all(lpm : RteLpm*)
  fun rte_lpm_delete_all_v1604(lpm : RteLpm*)
  fun rte_lpm_delete_all_v20(lpm : RteLpmV20*)
  fun rte_lpm_delete_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T) : LibC::Int
  fun rte_lpm_delete_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T) : LibC::Int
  fun rte_lpm_find_existing(name : LibC::Char*) : RteLpm*
  fun rte_lpm_find_existing_v1604(name : LibC::Char*) : RteLpm*
  fun rte_lpm_find_existing_v20(name : LibC::Char*) : RteLpmV20*
  fun rte_lpm_free(lpm : RteLpm*)
  fun rte_lpm_free_v1604(lpm : RteLpm*)
  fun rte_lpm_free_v20(lpm : RteLpmV20*)
  fun rte_lpm_is_rule_present(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm_is_rule_present_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm_is_rule_present_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T, next_hop : Uint8T*) : LibC::Int
  fun rte_lpm_lookup(lpm : RteLpm*, ip : Uint32T, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm_lookup_bulk_func(lpm : RteLpm*, ips : Uint32T*, next_hops : Uint32T*, n : LibC::UInt) : LibC::Int
  fun rte_lpm_lookupx4(lpm : RteLpm*, ip : XmmT, hop : Uint32T[4], defv : Uint32T)
  fun rte_malloc(type : LibC::Char*, size : LibC::Int, align : LibC::UInt) : Void*
  fun rte_malloc_dump_stats(f : Void*, type : LibC::Char*)
  fun rte_malloc_get_socket_stats(socket : LibC::Int, socket_stats : RteMallocSocketStats*) : LibC::Int
  fun rte_malloc_set_limit(type : LibC::Char*, max : LibC::Int) : LibC::Int
  fun rte_malloc_socket(type : LibC::Char*, size : LibC::Int, align : LibC::UInt, socket : LibC::Int) : Void*
  fun rte_malloc_validate(ptr : Void*, size : LibC::Int*) : LibC::Int
  fun rte_malloc_virt2iova(addr : Void*) : RteIovaT
  fun rte_malloc_virt2phy(addr : Void*) : PhysAddrT
  fun rte_mbuf_data_dma_addr(mb : RteMbuf*) : PhysAddrT
  fun rte_mbuf_data_dma_addr_default(mb : RteMbuf*) : PhysAddrT
  fun rte_mbuf_data_iova(mb : RteMbuf*) : RteIovaT
  fun rte_mbuf_data_iova_default(mb : RteMbuf*) : RteIovaT
  fun rte_mbuf_from_indirect(mi : RteMbuf*) : RteMbuf*
  fun rte_mbuf_prefetch_part1(m : RteMbuf*)
  fun rte_mbuf_prefetch_part2(m : RteMbuf*)
  fun rte_mbuf_raw_alloc(mp : RteMempool*) : RteMbuf*
  fun rte_mbuf_raw_free(m : RteMbuf*)
  fun rte_mbuf_refcnt_read(m : RteMbuf*) : Uint16T
  fun rte_mbuf_refcnt_set(m : RteMbuf*, new_value : Uint16T)
  fun rte_mbuf_refcnt_update(m : RteMbuf*, value : Int16T) : Uint16T
  fun rte_mbuf_sanity_check(m : RteMbuf*, is_header : LibC::Int)
  fun rte_mbuf_to_baddr(md : RteMbuf*) : LibC::Char*
  fun rte_mem_lock_page(virt : Void*) : LibC::Int
  fun rte_mem_virt2iova(virt : Void*) : RteIovaT
  fun rte_mem_virt2phy(virt : Void*) : PhysAddrT
  fun rte_memcpy(dst : Void*, src : Void*, n : LibC::Int) : Void*
  fun rte_memcpy_aligned(dst : Void*, src : Void*, n : LibC::Int) : Void*
  fun rte_memcpy_generic(dst : Void*, src : Void*, n : LibC::Int) : Void*
  fun rte_memory_get_nchannel : LibC::UInt
  fun rte_memory_get_nrank : LibC::UInt
  fun rte_mempool_audit(mp : RteMempool*)
  fun rte_mempool_avail_count(mp : RteMempool*) : LibC::UInt
  fun rte_mempool_cache_create(size : Uint32T, socket_id : LibC::Int) : RteMempoolCache*
  fun rte_mempool_cache_flush(cache : RteMempoolCache*, mp : RteMempool*)
  fun rte_mempool_cache_free(cache : RteMempoolCache*)
  fun rte_mempool_calc_obj_size(elt_size : Uint32T, flags : Uint32T, sz : RteMempoolObjsz*) : Uint32T
  fun rte_mempool_check_cookies(mp : RteMempool*, obj_table_const : Void**, n : LibC::UInt, free : LibC::Int)
  fun rte_mempool_create(name : LibC::Char*, n : LibC::UInt, elt_size : LibC::UInt, cache_size : LibC::UInt, private_data_size : LibC::UInt, mp_init : (RteMempool*, Void* -> Void), mp_init_arg : Void*, obj_init : (RteMempool*, Void*, Void*, LibC::UInt -> Void), obj_init_arg : Void*, socket_id : LibC::Int, flags : LibC::UInt) : RteMempool*
  fun rte_mempool_create_empty(name : LibC::Char*, n : LibC::UInt, elt_size : LibC::UInt, cache_size : LibC::UInt, private_data_size : LibC::UInt, socket_id : LibC::Int, flags : LibC::UInt) : RteMempool*
  fun rte_mempool_default_cache(mp : RteMempool*, lcore_id : LibC::UInt) : RteMempoolCache*
  fun rte_mempool_dump(f : Void*, mp : RteMempool*)
  fun rte_mempool_empty(mp : RteMempool*) : LibC::Int
  fun rte_mempool_free(mp : RteMempool*)
  fun rte_mempool_from_obj(obj : Void*) : RteMempool*
  fun rte_mempool_full(mp : RteMempool*) : LibC::Int
  fun rte_mempool_generic_get(mp : RteMempool*, obj_table : Void**, n : LibC::UInt, cache : RteMempoolCache*) : LibC::Int
  fun rte_mempool_generic_put(mp : RteMempool*, obj_table : Void**, n : LibC::UInt, cache : RteMempoolCache*)
  fun rte_mempool_get(mp : RteMempool*, obj_p : Void**) : LibC::Int
  fun rte_mempool_get_bulk(mp : RteMempool*, obj_table : Void**, n : LibC::UInt) : LibC::Int
  fun rte_mempool_get_ops(ops_index : LibC::Int) : RteMempoolOps*
  fun rte_mempool_get_priv(mp : RteMempool*) : Void*
  fun rte_mempool_in_use_count(mp : RteMempool*) : LibC::UInt
  fun rte_mempool_list_dump(f : Void*)
  fun rte_mempool_lookup(name : LibC::Char*) : RteMempool*
  fun rte_mempool_mem_iter(mp : RteMempool*, mem_cb : (RteMempool*, Void*, RteMempoolMemhdr*, LibC::UInt -> Void), mem_cb_arg : Void*) : Uint32T
  fun rte_mempool_obj_iter(mp : RteMempool*, obj_cb : (RteMempool*, Void*, Void*, LibC::UInt -> Void), obj_cb_arg : Void*) : Uint32T
  fun rte_mempool_ops_alloc(mp : RteMempool*) : LibC::Int
  fun rte_mempool_ops_dequeue_bulk(mp : RteMempool*, obj_table : Void**, n : LibC::UInt) : LibC::Int
  fun rte_mempool_ops_enqueue_bulk(mp : RteMempool*, obj_table : Void**, n : LibC::UInt) : LibC::Int
  fun rte_mempool_ops_free(mp : RteMempool*)
  fun rte_mempool_ops_get_capabilities(mp : RteMempool*, flags : LibC::UInt*) : LibC::Int
  fun rte_mempool_ops_get_count(mp : RteMempool*) : LibC::UInt
  fun rte_mempool_ops_register_memory_area(mp : RteMempool*, vaddr : LibC::Char*, iova : RteIovaT, len : LibC::Int) : LibC::Int
  fun rte_mempool_populate_anon(mp : RteMempool*) : LibC::Int
  fun rte_mempool_populate_default(mp : RteMempool*) : LibC::Int
  fun rte_mempool_populate_iova(mp : RteMempool*, vaddr : LibC::Char*, iova : RteIovaT, len : LibC::Int, free_cb : (RteMempoolMemhdr*, Void* -> Void), opaque : Void*) : LibC::Int
  fun rte_mempool_populate_iova_tab(mp : RteMempool*, vaddr : LibC::Char*, iova : RteIovaT*, pg_num : Uint32T, pg_shift : Uint32T, free_cb : (RteMempoolMemhdr*, Void* -> Void), opaque : Void*) : LibC::Int
  fun rte_mempool_populate_phys(mp : RteMempool*, vaddr : LibC::Char*, paddr : PhysAddrT, len : LibC::Int, free_cb : (RteMempoolMemhdr*, Void* -> Void), opaque : Void*) : LibC::Int
  fun rte_mempool_populate_phys_tab(mp : RteMempool*, vaddr : LibC::Char*, paddr : PhysAddrT*, pg_num : Uint32T, pg_shift : Uint32T, free_cb : (RteMempoolMemhdr*, Void* -> Void), opaque : Void*) : LibC::Int
  fun rte_mempool_populate_virt(mp : RteMempool*, addr : LibC::Char*, len : LibC::Int, pg_sz : LibC::Int, free_cb : (RteMempoolMemhdr*, Void* -> Void), opaque : Void*) : LibC::Int
  fun rte_mempool_put(mp : RteMempool*, obj : Void*)
  fun rte_mempool_put_bulk(mp : RteMempool*, obj_table : Void**, n : LibC::UInt)
  fun rte_mempool_register_ops(ops : RteMempoolOps*) : LibC::Int
  fun rte_mempool_set_ops_byname(mp : RteMempool*, name : LibC::Char*, pool_config : Void*) : LibC::Int
  fun rte_mempool_virt2iova(elt : Void*) : RteIovaT
  fun rte_mempool_virt2phy(mp : RteMempool*, elt : Void*) : PhysAddrT
  fun rte_mempool_walk(func : (RteMempool*, Void* -> Void), arg : Void*)
  fun rte_mempool_xmem_create(name : LibC::Char*, n : LibC::UInt, elt_size : LibC::UInt, cache_size : LibC::UInt, private_data_size : LibC::UInt, mp_init : (RteMempool*, Void* -> Void), mp_init_arg : Void*, obj_init : (RteMempool*, Void*, Void*, LibC::UInt -> Void), obj_init_arg : Void*, socket_id : LibC::Int, flags : LibC::UInt, vaddr : Void*, iova : RteIovaT*, pg_num : Uint32T, pg_shift : Uint32T) : RteMempool*
  fun rte_mempool_xmem_size : LibC::Int
  fun rte_mempool_xmem_usage(vaddr : Void*, elt_num : Uint32T, total_elt_sz : LibC::Int, iova : RteIovaT*, pg_num : Uint32T, pg_shift : Uint32T, flags : LibC::UInt) : SsizeT
  fun rte_memzone_dump(f : Void*)
  fun rte_memzone_free(mz : RteMemzone*) : LibC::Int
  fun rte_memzone_lookup(name : LibC::Char*) : RteMemzone*
  fun rte_memzone_reserve(name : LibC::Char*, len : LibC::Int, socket_id : LibC::Int, flags : LibC::UInt) : RteMemzone*
  fun rte_memzone_reserve_aligned(name : LibC::Char*, len : LibC::Int, socket_id : LibC::Int, flags : LibC::UInt, align : LibC::UInt) : RteMemzone*
  fun rte_memzone_reserve_bounded(name : LibC::Char*, len : LibC::Int, socket_id : LibC::Int, flags : LibC::UInt, align : LibC::UInt, bound : LibC::UInt) : RteMemzone*
  fun rte_memzone_walk(func : (RteMemzone*, Void* -> Void), arg : Void*)
  fun rte_meter_srtcm_color_aware_check(m : RteMeterSrtcm*, time : Uint64T, pkt_len : Uint32T, pkt_color : RteMeterColor) : RteMeterColor
  fun rte_meter_srtcm_color_blind_check(m : RteMeterSrtcm*, time : Uint64T, pkt_len : Uint32T) : RteMeterColor
  fun rte_meter_srtcm_config(m : RteMeterSrtcm*, params : RteMeterSrtcmParams*) : LibC::Int
  fun rte_meter_trtcm_color_aware_check(m : RteMeterTrtcm*, time : Uint64T, pkt_len : Uint32T, pkt_color : RteMeterColor) : RteMeterColor
  fun rte_meter_trtcm_color_blind_check(m : RteMeterTrtcm*, time : Uint64T, pkt_len : Uint32T) : RteMeterColor
  fun rte_meter_trtcm_config(m : RteMeterTrtcm*, params : RteMeterTrtcmParams*) : LibC::Int
  fun rte_metrics_get_names(names : RteMetricName*, capacity : Uint16T) : LibC::Int
  fun rte_metrics_get_values(port_id : LibC::Int, values : RteMetricValue*, capacity : Uint16T) : LibC::Int
  fun rte_metrics_init(socket_id : LibC::Int)
  fun rte_metrics_reg_name(name : LibC::Char*) : LibC::Int
  fun rte_metrics_reg_names(names : LibC::Char**, cnt_names : Uint16T) : LibC::Int
  fun rte_metrics_update_value(port_id : LibC::Int, key : Uint16T, value : Uint64T) : LibC::Int
  fun rte_metrics_update_values(port_id : LibC::Int, key : Uint16T, values : Uint64T*, count : Uint32T) : LibC::Int
  fun rte_mov128(dst : Uint8T*, src : Uint8T*)
  fun rte_mov16(dst : Uint8T*, src : Uint8T*)
  fun rte_mov256(dst : Uint8T*, src : Uint8T*)
  fun rte_mov32(dst : Uint8T*, src : Uint8T*)
  fun rte_mov64(dst : Uint8T*, src : Uint8T*)
  fun rte_mp_action_register(name : LibC::Char*, action : RteMpT) : LibC::Int
  fun rte_mp_action_unregister(name : LibC::Char*)
  fun rte_mp_reply(msg : RteMpMsg*, peer : LibC::Char*) : LibC::Int
  fun rte_mp_request(req : RteMpMsg*, reply : RteMpReply*, ts : Timespec*) : LibC::Int
  fun rte_mp_sendmsg(msg : RteMpMsg*) : LibC::Int
  fun rte_mtr_capabilities_get(port_id : Uint16T, cap : RteMtrCapabilities*, error : RteMtrError*) : LibC::Int
  fun rte_mtr_create(port_id : Uint16T, mtr_id : Uint32T, params : RteMtrParams*, shared : LibC::Int, error : RteMtrError*) : LibC::Int
  fun rte_mtr_destroy(port_id : Uint16T, mtr_id : Uint32T, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_disable(port_id : Uint16T, mtr_id : Uint32T, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_dscp_table_update(port_id : Uint16T, mtr_id : Uint32T, dscp_table : RteMtrColor*, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_enable(port_id : Uint16T, mtr_id : Uint32T, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_profile_add(port_id : Uint16T, meter_profile_id : Uint32T, profile : RteMtrMeterProfile*, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_profile_delete(port_id : Uint16T, meter_profile_id : Uint32T, error : RteMtrError*) : LibC::Int
  fun rte_mtr_meter_profile_update(port_id : Uint16T, mtr_id : Uint32T, meter_profile_id : Uint32T, error : RteMtrError*) : LibC::Int
  fun rte_mtr_policer_actions_update(port_id : Uint16T, mtr_id : Uint32T, action_mask : Uint32T, actions : RteMtrPolicerAction*, error : RteMtrError*) : LibC::Int
  fun rte_mtr_stats_read(port_id : Uint16T, mtr_id : Uint32T, stats : RteMtrStats*, stats_mask : Uint64T*, clear : LibC::Int, error : RteMtrError*) : LibC::Int
  fun rte_mtr_stats_update(port_id : Uint16T, mtr_id : Uint32T, stats_mask : Uint64T, error : RteMtrError*) : LibC::Int
  fun rte_net_make_rarp_packet(mpool : RteMempool*, mac : EtherAddr*) : RteMbuf*
  fun rte_openlog_stream(f : Void*) : LibC::Int
  fun rte_pause
  fun rte_pci_addr_cmp(addr : RtePciAddr*, addr2 : RtePciAddr*) : LibC::Int
  fun rte_pci_addr_parse(str : LibC::Char*, addr : RtePciAddr*) : LibC::Int
  fun rte_pci_device_name(addr : RtePciAddr*, output : LibC::Char*, size : LibC::Int)
  fun rte_pci_dump(f : Void*)
  fun rte_pci_get_sysfs_path : LibC::Char*
  fun rte_pci_ioport_map(dev : RtePciDevice*, bar : LibC::Int, p : RtePciIoport*) : LibC::Int
  fun rte_pci_ioport_read(p : RtePciIoport*, data : Void*, len : LibC::Int, offset : OffT)
  fun rte_pci_ioport_unmap(p : RtePciIoport*) : LibC::Int
  fun rte_pci_ioport_write(p : RtePciIoport*, data : Void*, len : LibC::Int, offset : OffT)
  fun rte_pci_map_device(dev : RtePciDevice*) : LibC::Int
  fun rte_pci_read_config(device : RtePciDevice*, buf : Void*, len : LibC::Int, offset : OffT) : LibC::Int
  fun rte_pci_register(driver : RtePciDriver*)
  fun rte_pci_unmap_device(dev : RtePciDevice*)
  fun rte_pci_unregister(driver : RtePciDriver*)
  fun rte_pci_write_config(device : RtePciDevice*, buf : Void*, len : LibC::Int, offset : OffT) : LibC::Int
  fun rte_pktmbuf_adj(m : RteMbuf*, len : Uint16T) : LibC::Char*
  fun rte_pktmbuf_alloc(mp : RteMempool*) : RteMbuf*
  fun rte_pktmbuf_alloc_bulk(pool : RteMempool*, mbufs : RteMbuf**, count : LibC::UInt) : LibC::Int
  fun rte_pktmbuf_append(m : RteMbuf*, len : Uint16T) : LibC::Char*
  fun rte_pktmbuf_attach(mi : RteMbuf*, m : RteMbuf*)
  fun rte_pktmbuf_chain(head : RteMbuf*, tail : RteMbuf*) : LibC::Int
  fun rte_pktmbuf_clone(md : RteMbuf*, mp : RteMempool*) : RteMbuf*
  fun rte_pktmbuf_data_room_size(mp : RteMempool*) : Uint16T
  fun rte_pktmbuf_detach(m : RteMbuf*)
  fun rte_pktmbuf_dump(f : Void*, m : RteMbuf*, dump_len : LibC::UInt)
  fun rte_pktmbuf_free(m : RteMbuf*)
  fun rte_pktmbuf_free_seg(m : RteMbuf*)
  fun rte_pktmbuf_headroom(m : RteMbuf*) : Uint16T
  fun rte_pktmbuf_init(mp : RteMempool*, opaque_arg : Void*, m : Void*, i : LibC::UInt)
  fun rte_pktmbuf_is_contiguous(m : RteMbuf*) : LibC::Int
  fun rte_pktmbuf_lastseg(m : RteMbuf*) : RteMbuf*
  fun rte_pktmbuf_linearize(mbuf : RteMbuf*) : LibC::Int
  fun rte_pktmbuf_pool_create(name : LibC::Char*, n : LibC::UInt, cache_size : LibC::UInt, priv_size : Uint16T, data_room_size : Uint16T, socket_id : LibC::Int) : RteMempool*
  fun rte_pktmbuf_pool_create_by_ops(name : LibC::Char*, n : LibC::UInt, cache_size : LibC::UInt, priv_size : Uint16T, data_room_size : Uint16T, socket_id : LibC::Int, ops_name : LibC::Char*) : RteMempool*
  fun rte_pktmbuf_pool_init(mp : RteMempool*, opaque_arg : Void*)
  fun rte_pktmbuf_prefree_seg(m : RteMbuf*) : RteMbuf*
  fun rte_pktmbuf_prepend(m : RteMbuf*, len : Uint16T) : LibC::Char*
  fun rte_pktmbuf_priv_size(mp : RteMempool*) : Uint16T
  fun rte_pktmbuf_read(m : RteMbuf*, off : Uint32T, len : Uint32T, buf : Void*) : Void*
  fun rte_pktmbuf_refcnt_update(m : RteMbuf*, v : Int16T)
  fun rte_pktmbuf_reset(m : RteMbuf*)
  fun rte_pktmbuf_reset_headroom(m : RteMbuf*)
  fun rte_pktmbuf_tailroom(m : RteMbuf*) : Uint16T
  fun rte_pktmbuf_trim(m : RteMbuf*, len : Uint16T) : LibC::Int
  fun rte_pmd_debug_trace(func_name : LibC::Char*, fmt : LibC::Char*, ...)
  fun rte_prefetch0(p : Void*)
  fun rte_prefetch1(p : Void*)
  fun rte_prefetch2(p : Void*)
  fun rte_prefetch_non_temporal(p : Void*)
  fun rte_rand : Uint64T
  fun rte_raw_cksum(buf : Void*, len : LibC::Int) : Uint16T
  fun rte_raw_cksum_mbuf(m : RteMbuf*, off : Uint32T, len : Uint32T, cksum : Uint16T*) : LibC::Int
  fun rte_rdtsc : Uint64T
  fun rte_rdtsc_precise : Uint64T
  fun rte_realloc(ptr : Void*, size : LibC::Int, align : LibC::UInt) : Void*
  fun rte_ring_count(r : RteRing*) : LibC::UInt
  fun rte_ring_create(name : LibC::Char*, count : LibC::UInt, socket_id : LibC::Int, flags : LibC::UInt) : RteRing*
  fun rte_ring_dequeue(r : RteRing*, obj_p : Void**) : LibC::Int
  fun rte_ring_dequeue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_dequeue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_dump(f : Void*, r : RteRing*)
  fun rte_ring_empty(r : RteRing*) : LibC::Int
  fun rte_ring_enqueue(r : RteRing*, obj : Void*) : LibC::Int
  fun rte_ring_enqueue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_ring_enqueue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_ring_free(r : RteRing*)
  fun rte_ring_free_count(r : RteRing*) : LibC::UInt
  fun rte_ring_full(r : RteRing*) : LibC::Int
  fun rte_ring_get_capacity(r : RteRing*) : LibC::UInt
  fun rte_ring_get_memsize(count : LibC::UInt) : SsizeT
  fun rte_ring_get_size(r : RteRing*) : LibC::UInt
  fun rte_ring_init(r : RteRing*, name : LibC::Char*, count : LibC::UInt, flags : LibC::UInt) : LibC::Int
  fun rte_ring_list_dump(f : Void*)
  fun rte_ring_lookup(name : LibC::Char*) : RteRing*
  fun rte_ring_mc_dequeue(r : RteRing*, obj_p : Void**) : LibC::Int
  fun rte_ring_mc_dequeue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_mc_dequeue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_mp_enqueue(r : RteRing*, obj : Void*) : LibC::Int
  fun rte_ring_mp_enqueue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_ring_mp_enqueue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_ring_sc_dequeue(r : RteRing*, obj_p : Void**) : LibC::Int
  fun rte_ring_sc_dequeue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_sc_dequeue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, available : LibC::UInt*) : LibC::UInt
  fun rte_ring_sp_enqueue(r : RteRing*, obj : Void*) : LibC::Int
  fun rte_ring_sp_enqueue_bulk(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_ring_sp_enqueue_burst(r : RteRing*, obj_table : Void**, n : LibC::UInt, free_space : LibC::UInt*) : LibC::UInt
  fun rte_rwlock_init(rwl : RteRwlockT*)
  fun rte_rwlock_read_lock(rwl : RteRwlockT*)
  fun rte_rwlock_read_lock_tm(rwl : RteRwlockT*)
  fun rte_rwlock_read_unlock(rwl : RteRwlockT*)
  fun rte_rwlock_read_unlock_tm(rwl : RteRwlockT*)
  fun rte_rwlock_write_lock(rwl : RteRwlockT*)
  fun rte_rwlock_write_lock_tm(rwl : RteRwlockT*)
  fun rte_rwlock_write_unlock(rwl : RteRwlockT*)
  fun rte_rwlock_write_unlock_tm(rwl : RteRwlockT*)
  fun rte_sched_pipe_config(port : RteSchedPort*, subport_id : Uint32T, pipe_id : Uint32T, pipe_profile : Int32T) : LibC::Int
  fun rte_sched_port_config(params : RteSchedPortParams*) : RteSchedPort*
  fun rte_sched_port_dequeue(port : RteSchedPort*, pkts : RteMbuf**, n_pkts : Uint32T) : LibC::Int
  fun rte_sched_port_enqueue(port : RteSchedPort*, pkts : RteMbuf**, n_pkts : Uint32T) : LibC::Int
  fun rte_sched_port_free(port : RteSchedPort*)
  fun rte_sched_port_get_memory_footprint(params : RteSchedPortParams*) : Uint32T
  fun rte_sched_port_pkt_read_color(pkt : RteMbuf*) : RteMeterColor
  fun rte_sched_port_pkt_read_tree_path(pkt : RteMbuf*, subport : Uint32T*, pipe : Uint32T*, traffic_class : Uint32T*, queue : Uint32T*)
  fun rte_sched_port_pkt_write(pkt : RteMbuf*, subport : Uint32T, pipe : Uint32T, traffic_class : Uint32T, queue : Uint32T, color : RteMeterColor)
  fun rte_sched_queue_read_stats(port : RteSchedPort*, queue_id : Uint32T, stats : RteSchedQueueStats*, qlen : Uint16T*) : LibC::Int
  fun rte_sched_subport_config(port : RteSchedPort*, subport_id : Uint32T, params : RteSchedSubportParams*) : LibC::Int
  fun rte_sched_subport_read_stats(port : RteSchedPort*, subport_id : Uint32T, stats : RteSchedSubportStats*, tc_ov : Uint32T*) : LibC::Int
  fun rte_security_attach_session(op : RteCryptoOp*, sess : RteSecuritySession*) : LibC::Int
  fun rte_security_capabilities_get(instance : RteSecurityCtx*) : RteSecurityCapability*
  fun rte_security_capability_get(instance : RteSecurityCtx*, idx : RteSecurityCapabilityIdx*) : RteSecurityCapability*
  fun rte_security_get_userdata(instance : RteSecurityCtx*, md : Uint64T) : Void*
  fun rte_security_session_create(instance : RteSecurityCtx*, conf : RteSecuritySessionConf*, mp : RteMempool*) : RteSecuritySession*
  fun rte_security_session_destroy(instance : RteSecurityCtx*, sess : RteSecuritySession*) : LibC::Int
  fun rte_security_session_get_size(instance : RteSecurityCtx*) : LibC::UInt
  fun rte_security_session_stats_get(instance : RteSecurityCtx*, sess : RteSecuritySession*, stats : RteSecurityStats*) : LibC::Int
  fun rte_security_session_update(instance : RteSecurityCtx*, sess : RteSecuritySession*, conf : RteSecuritySessionConf*) : LibC::Int
  fun rte_security_set_pkt_metadata(instance : RteSecurityCtx*, sess : RteSecuritySession*, mb : RteMbuf*, params : Void*) : LibC::Int
  fun rte_service_attr_get(id : Uint32T, attr_id : Uint32T, attr_value : Uint32T*) : Int32T
  fun rte_service_attr_reset_all(id : Uint32T) : Int32T
  fun rte_service_dump(f : Void*, id : Uint32T) : Int32T
  fun rte_service_get_by_name(name : LibC::Char*, service_id : Uint32T*) : Int32T
  fun rte_service_get_count : Uint32T
  fun rte_service_get_name(id : Uint32T) : LibC::Char*
  fun rte_service_lcore_add(lcore : Uint32T) : Int32T
  fun rte_service_lcore_count : Int32T
  fun rte_service_lcore_count_services(lcore : Uint32T) : Int32T
  fun rte_service_lcore_del(lcore : Uint32T) : Int32T
  fun rte_service_lcore_list(array : Uint32T*, n : Uint32T) : Int32T
  fun rte_service_lcore_reset_all : Int32T
  fun rte_service_lcore_start(lcore_id : Uint32T) : Int32T
  fun rte_service_lcore_stop(lcore_id : Uint32T) : Int32T
  fun rte_service_map_lcore_get(service_id : Uint32T, lcore : Uint32T) : Int32T
  fun rte_service_map_lcore_set(service_id : Uint32T, lcore : Uint32T, enable : Uint32T) : Int32T
  fun rte_service_probe_capability(id : Uint32T, capability : Uint32T) : Int32T
  fun rte_service_run_iter_on_app_lcore(id : Uint32T, serialize_multithread_unsafe : Uint32T) : Int32T
  fun rte_service_runstate_get(id : Uint32T) : Int32T
  fun rte_service_runstate_set(id : Uint32T, runstate : Uint32T) : Int32T
  fun rte_service_set_runstate_mapped_check(id : Uint32T, enable : Int32T) : Int32T
  fun rte_service_set_stats_enable(id : Uint32T, enable : Int32T) : Int32T
  fun rte_set_application_usage_hook(usage_func : RteUsageHookT) : RteUsageHookT
  fun rte_smp_mb
  fun rte_socket_id : LibC::UInt
  fun rte_spinlock_init(sl : RteSpinlockT*)
  fun rte_spinlock_is_locked(sl : RteSpinlockT*) : LibC::Int
  fun rte_spinlock_lock(sl : RteSpinlockT*)
  fun rte_spinlock_lock_tm(sl : RteSpinlockT*)
  fun rte_spinlock_recursive_init(slr : RteSpinlockRecursiveT*)
  fun rte_spinlock_recursive_lock(slr : RteSpinlockRecursiveT*)
  fun rte_spinlock_recursive_lock_tm(slr : RteSpinlockRecursiveT*)
  fun rte_spinlock_recursive_trylock(slr : RteSpinlockRecursiveT*) : LibC::Int
  fun rte_spinlock_recursive_trylock_tm(slr : RteSpinlockRecursiveT*) : LibC::Int
  fun rte_spinlock_recursive_unlock(slr : RteSpinlockRecursiveT*)
  fun rte_spinlock_recursive_unlock_tm(slr : RteSpinlockRecursiveT*)
  fun rte_spinlock_trylock(sl : RteSpinlockT*) : LibC::Int
  fun rte_spinlock_trylock_tm(sl : RteSpinlockT*) : LibC::Int
  fun rte_spinlock_unlock(sl : RteSpinlockT*)
  fun rte_spinlock_unlock_tm(sl : RteSpinlockT*)
  fun rte_srand(seedval : Uint64T)
  fun rte_str_to_size(str : LibC::Char*) : Uint64T
  fun rte_strerror(errnum : LibC::Int) : LibC::Char*
  fun rte_strsplit(string : LibC::Char*, stringlen : LibC::Int, tokens : LibC::Char**, maxtokens : LibC::Int, delim : LibC::Char) : LibC::Int
  fun rte_sys_gettid : LibC::Int
  fun rte_thread_get_affinity(cpusetp : RteCpusetT*)
  fun rte_thread_set_affinity(cpusetp : RteCpusetT*) : LibC::Int
  fun rte_thread_setname(id : PthreadT, name : LibC::Char*) : LibC::Int
  fun rte_tm_capabilities_get(port_id : Uint16T, cap : RteTmCapabilities*, error : RteTmError*) : LibC::Int
  fun rte_tm_get_number_of_leaf_nodes(port_id : Uint16T, n_leaf_nodes : Uint32T*, error : RteTmError*) : LibC::Int
  fun rte_tm_hierarchy_commit(port_id : Uint16T, clear_on_fail : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_level_capabilities_get(port_id : Uint16T, level_id : Uint32T, cap : RteTmLevelCapabilities*, error : RteTmError*) : LibC::Int
  fun rte_tm_mark_ip_dscp(port_id : Uint16T, mark_green : LibC::Int, mark_yellow : LibC::Int, mark_red : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_mark_ip_ecn(port_id : Uint16T, mark_green : LibC::Int, mark_yellow : LibC::Int, mark_red : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_mark_vlan_dei(port_id : Uint16T, mark_green : LibC::Int, mark_yellow : LibC::Int, mark_red : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_node_add(port_id : Uint16T, node_id : Uint32T, parent_node_id : Uint32T, priority : Uint32T, weight : Uint32T, level_id : Uint32T, params : RteTmNodeParams*, error : RteTmError*) : LibC::Int
  fun rte_tm_node_capabilities_get(port_id : Uint16T, node_id : Uint32T, cap : RteTmNodeCapabilities*, error : RteTmError*) : LibC::Int
  fun rte_tm_node_cman_update(port_id : Uint16T, node_id : Uint32T, cman : RteTmCmanMode, error : RteTmError*) : LibC::Int
  fun rte_tm_node_delete(port_id : Uint16T, node_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_parent_update(port_id : Uint16T, node_id : Uint32T, parent_node_id : Uint32T, priority : Uint32T, weight : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_resume(port_id : Uint16T, node_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_shaper_update(port_id : Uint16T, node_id : Uint32T, shaper_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_shared_shaper_update(port_id : Uint16T, node_id : Uint32T, shared_shaper_id : Uint32T, add : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_node_shared_wred_context_update(port_id : Uint16T, node_id : Uint32T, shared_wred_context_id : Uint32T, add : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_node_stats_read(port_id : Uint16T, node_id : Uint32T, stats : RteTmNodeStats*, stats_mask : Uint64T*, clear : LibC::Int, error : RteTmError*) : LibC::Int
  fun rte_tm_node_stats_update(port_id : Uint16T, node_id : Uint32T, stats_mask : Uint64T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_suspend(port_id : Uint16T, node_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_type_get(port_id : Uint16T, node_id : Uint32T, is_leaf : LibC::Int*, error : RteTmError*) : LibC::Int
  fun rte_tm_node_wfq_weight_mode_update(port_id : Uint16T, node_id : Uint32T, wfq_weight_mode : LibC::Int*, n_sp_priorities : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_node_wred_context_update(port_id : Uint16T, node_id : Uint32T, wred_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_shaper_profile_add(port_id : Uint16T, shaper_profile_id : Uint32T, profile : RteTmShaperParams*, error : RteTmError*) : LibC::Int
  fun rte_tm_shaper_profile_delete(port_id : Uint16T, shaper_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_shared_shaper_add_update(port_id : Uint16T, shared_shaper_id : Uint32T, shaper_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_shared_shaper_delete(port_id : Uint16T, shared_shaper_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_shared_wred_context_add_update(port_id : Uint16T, shared_wred_context_id : Uint32T, wred_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_shared_wred_context_delete(port_id : Uint16T, shared_wred_context_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_tm_supported : LibC::Int
  fun rte_tm_wred_profile_add(port_id : Uint16T, wred_profile_id : Uint32T, profile : RteTmWredParams*, error : RteTmError*) : LibC::Int
  fun rte_tm_wred_profile_delete(port_id : Uint16T, wred_profile_id : Uint32T, error : RteTmError*) : LibC::Int
  fun rte_try_tm(lock : LibC::Int*) : LibC::Int
  fun rte_validate_tx_offload(m : RteMbuf*) : LibC::Int
  fun rte_vdev_add_custom_scan(callback : RteVdevScanCallback, user_arg : Void*) : LibC::Int
  fun rte_vdev_device_args(dev : RteVdevDevice*) : LibC::Char*
  fun rte_vdev_device_name(dev : RteVdevDevice*) : LibC::Char*
  fun rte_vdev_init(name : LibC::Char*, args : LibC::Char*) : LibC::Int
  fun rte_vdev_register(driver : RteVdevDriver*)
  fun rte_vdev_remove_custom_scan(callback : RteVdevScanCallback, user_arg : Void*) : LibC::Int
  fun rte_vdev_uninit(name : LibC::Char*) : LibC::Int
  fun rte_vdev_unregister(driver : RteVdevDriver*)
  fun rte_vhost_avail_entries(vid : LibC::Int, queue_id : Uint16T) : Uint16T
  fun rte_vhost_dequeue_burst(vid : LibC::Int, queue_id : Uint16T, mbuf_pool : RteMempool*, pkts : RteMbuf**, count : Uint16T) : Uint16T
  fun rte_vhost_driver_callback_register(path : LibC::Char*, ops : VhostDeviceOps*) : LibC::Int
  fun rte_vhost_driver_disable_features(path : LibC::Char*, features : Uint64T) : LibC::Int
  fun rte_vhost_driver_enable_features(path : LibC::Char*, features : Uint64T) : LibC::Int
  fun rte_vhost_driver_get_features(path : LibC::Char*, features : Uint64T*) : LibC::Int
  fun rte_vhost_driver_register(path : LibC::Char*, flags : Uint64T) : LibC::Int
  fun rte_vhost_driver_set_features(path : LibC::Char*, features : Uint64T) : LibC::Int
  fun rte_vhost_driver_start(path : LibC::Char*) : LibC::Int
  fun rte_vhost_driver_unregister(path : LibC::Char*) : LibC::Int
  fun rte_vhost_enable_guest_notification(vid : LibC::Int, queue_id : Uint16T, enable : LibC::Int) : LibC::Int
  fun rte_vhost_enqueue_burst(vid : LibC::Int, queue_id : Uint16T, pkts : RteMbuf**, count : Uint16T) : Uint16T
  fun rte_vhost_get_ifname(vid : LibC::Int, buf : LibC::Char*, len : LibC::Int) : LibC::Int
  fun rte_vhost_get_mem_table(vid : LibC::Int, mem : RteVhostMemory**) : LibC::Int
  fun rte_vhost_get_mtu(vid : LibC::Int, mtu : Uint16T*) : LibC::Int
  fun rte_vhost_get_negotiated_features(vid : LibC::Int, features : Uint64T*) : LibC::Int
  fun rte_vhost_get_numa_node(vid : LibC::Int) : LibC::Int
  fun rte_vhost_get_queue_num(vid : LibC::Int) : Uint32T
  fun rte_vhost_get_vhost_vring(vid : LibC::Int, vring_idx : Uint16T, vring : RteVhostVring*) : LibC::Int
  fun rte_vhost_get_vring_num(vid : LibC::Int) : Uint16T
  fun rte_vhost_gpa_to_vva(mem : RteVhostMemory*, gpa : Uint64T) : Uint64T
  fun rte_vhost_log_used_vring(vid : LibC::Int, vring_idx : Uint16T, offset : Uint64T, len : Uint64T)
  fun rte_vhost_log_write(vid : LibC::Int, addr : Uint64T, len : Uint64T)
  fun rte_vhost_rx_queue_count(vid : LibC::Int, qid : Uint16T) : Uint32T
  fun rte_vhost_va_from_guest_pa(mem : RteVhostMemory*, gpa : Uint64T, len : Uint64T*) : Uint64T
  fun rte_vhost_vring_call(vid : LibC::Int, vring_idx : Uint16T) : LibC::Int
  fun rte_vlan_insert(m : RteMbuf**) : LibC::Int
  fun rte_vlan_strip(m : RteMbuf*) : LibC::Int
  fun rte_vlog(level : Uint32T, logtype : Uint32T, format : LibC::Char*, ap : VaList) : LibC::Int
  fun rte_xbegin : LibC::UInt
  fun rte_xend
  fun rte_xtest : LibC::Int
  fun rte_zmalloc(type : LibC::Char*, size : LibC::Int, align : LibC::UInt) : Void*
  fun rte_zmalloc_socket(type : LibC::Char*, size : LibC::Int, align : LibC::UInt, socket : LibC::Int) : Void*

  struct Cirbuf
    maxlen : LibC::UInt
    start : LibC::UInt
    _end : LibC::UInt
    len : LibC::UInt
    buf : LibC::Char*
  end

  struct Cmdline
    s_in : LibC::Int
    s_out : LibC::Int
    ctx : CmdlineParseCtxT*
    rdl : Rdline
    prompt : LibC::Char[32]
    oldterm : Termios
  end

  struct CmdlineInst
    f : (Void*, Cmdline*, Void* -> Void)
    data : Void*
    help_str : LibC::Char*
    tokens : CmdlineParseTokenHdrT**
  end

  struct CmdlineTokenHdr
    ops : CmdlineTokenOps*
    offset : LibC::UInt
  end

  struct CmdlineTokenOps
    parse : (Void**, LibC::Char*, Void*, LibC::UInt -> LibC::Int)
    complete_get_nb : (Void** -> LibC::Int)
    complete_get_elt : (Void**, LibC::Int, LibC::Char*, LibC::UInt -> LibC::Int)
    get_help : (Void**, LibC::Char*, LibC::UInt -> LibC::Int)
  end

  struct CmdlineVt100
    bufpos : Uint8T
    buf : LibC::Char[8]
    state : CmdlineVt100ParserState
  end

  struct CpuSetT
    __bits : X__CpuMask[16]
  end

  struct EspHdr
    spi : RteBe32T
    seq : RteBe32T
  end

  struct EthDevOps
    dev_configure : EthDevConfigureT
    dev_start : EthDevStartT
    dev_stop : EthDevStopT
    dev_set_link_up : EthDevSetLinkUpT
    dev_set_link_down : EthDevSetLinkDownT
    dev_close : EthDevCloseT
    dev_reset : EthDevResetT
    link_update : EthLinkUpdateT
    is_removed : EthIsRemovedT
    promiscuous_enable : EthPromiscuousEnableT
    promiscuous_disable : EthPromiscuousDisableT
    allmulticast_enable : EthAllmulticastEnableT
    allmulticast_disable : EthAllmulticastDisableT
    mac_addr_remove : EthMacAddrRemoveT
    mac_addr_add : EthMacAddrAddT
    mac_addr_set : EthMacAddrSetT
    set_mc_addr_list : EthSetMcAddrListT
    mtu_set : MtuSetT
    stats_get : EthStatsGetT
    stats_reset : EthStatsResetT
    xstats_get : EthXstatsGetT
    xstats_reset : EthXstatsResetT
    xstats_get_names : EthXstatsGetNamesT
    queue_stats_mapping_set : EthQueueStatsMappingSetT
    dev_infos_get : EthDevInfosGetT
    rxq_info_get : EthRxqInfoGetT
    txq_info_get : EthTxqInfoGetT
    fw_version_get : EthFwVersionGetT
    dev_supported_ptypes_get : EthDevSupportedPtypesGetT
    vlan_filter_set : VlanFilterSetT
    vlan_tpid_set : VlanTpidSetT
    vlan_strip_queue_set : VlanStripQueueSetT
    vlan_offload_set : VlanOffloadSetT
    vlan_pvid_set : VlanPvidSetT
    rx_queue_start : EthQueueStartT
    rx_queue_stop : EthQueueStopT
    tx_queue_start : EthQueueStartT
    tx_queue_stop : EthQueueStopT
    rx_queue_setup : EthRxQueueSetupT
    rx_queue_release : EthQueueReleaseT
    rx_queue_count : EthRxQueueCountT
    rx_descriptor_done : EthRxDescriptorDoneT
    rx_descriptor_status : EthRxDescriptorStatusT
    tx_descriptor_status : EthTxDescriptorStatusT
    rx_queue_intr_enable : EthRxEnableIntrT
    rx_queue_intr_disable : EthRxDisableIntrT
    tx_queue_setup : EthTxQueueSetupT
    tx_queue_release : EthQueueReleaseT
    tx_done_cleanup : EthTxDoneCleanupT
    dev_led_on : EthDevLedOnT
    dev_led_off : EthDevLedOffT
    flow_ctrl_get : FlowCtrlGetT
    flow_ctrl_set : FlowCtrlSetT
    priority_flow_ctrl_set : PriorityFlowCtrlSetT
    uc_hash_table_set : EthUcHashTableSetT
    uc_all_hash_table_set : EthUcAllHashTableSetT
    mirror_rule_set : EthMirrorRuleSetT
    mirror_rule_reset : EthMirrorRuleResetT
    udp_tunnel_port_add : EthUdpTunnelPortAddT
    udp_tunnel_port_del : EthUdpTunnelPortDelT
    l2_tunnel_eth_type_conf : EthL2TunnelEthTypeConfT
    l2_tunnel_offload_set : EthL2TunnelOffloadSetT
    set_queue_rate_limit : EthSetQueueRateLimitT
    rss_hash_update : RssHashUpdateT
    rss_hash_conf_get : RssHashConfGetT
    reta_update : RetaUpdateT
    reta_query : RetaQueryT
    get_reg : EthGetRegT
    get_eeprom_length : EthGetEepromLengthT
    get_eeprom : EthGetEepromT
    set_eeprom : EthSetEepromT
    filter_ctrl : EthFilterCtrlT
    get_dcb_info : EthGetDcbInfo
    timesync_enable : EthTimesyncEnableT
    timesync_disable : EthTimesyncDisableT
    timesync_read_rx_timestamp : EthTimesyncReadRxTimestampT
    timesync_read_tx_timestamp : EthTimesyncReadTxTimestampT
    timesync_adjust_time : EthTimesyncAdjustTime
    timesync_read_time : EthTimesyncReadTime
    timesync_write_time : EthTimesyncWriteTime
    xstats_get_by_id : EthXstatsGetByIdT
    xstats_get_names_by_id : EthXstatsGetNamesByIdT
    tm_ops_get : EthTmOpsGetT
    mtr_ops_get : EthMtrOpsGetT
    pool_ops_supported : EthPoolOpsSupportedT
  end

  struct EtherAddr
    addr_bytes : Uint8T[6]
  end

  struct HugepageInfo
    hugepage_sz : Uint64T
    hugedir : LibC::Char*
    num_pages : Uint32T[8]
    lock_descriptor : LibC::Int
  end

  struct IcmpHdr
    icmp_type : Uint8T
    icmp_code : Uint8T
    icmp_cksum : Uint16T
    icmp_ident : Uint16T
    icmp_seq_nb : Uint16T
  end

  struct In6Addr
    __in6_u : In6AddrIn6U
  end

  struct InAddr
    s_addr : InAddrT
  end

  struct InternalConfig
    memory : LibC::Int
    force_nchannel : LibC::UInt
    force_nrank : LibC::UInt
    no_hugetlbfs : LibC::UInt
    hugepage_unlink : LibC::UInt
    no_pci : LibC::UInt
    no_hpet : LibC::UInt
    vmware_tsc_map : LibC::UInt
    no_shconf : LibC::UInt
    create_uio_dev : LibC::UInt
    process_type : RteProcTypeT
    force_sockets : LibC::UInt
    socket_mem : Uint64T[8]
    base_virtaddr : UintptrT
    syslog_facility : LibC::Int
    vfio_intr_mode : RteIntrMode
    hugefile_prefix : LibC::Char*
    hugepage_dir : LibC::Char*
    user_mbuf_pool_ops_name : LibC::Char*
    num_hugepage_sizes : LibC::UInt
    hugepage_info : HugepageInfo[3]
  end

  struct Ipv4Hdr
    version_ihl : Uint8T
    type_of_service : Uint8T
    total_length : Uint16T
    packet_id : Uint16T
    fragment_offset : Uint16T
    time_to_live : Uint8T
    next_proto_id : Uint8T
    hdr_checksum : Uint16T
    src_addr : Uint32T
    dst_addr : Uint32T
  end

  struct Ipv6Hdr
    vtc_flow : Uint32T
    payload_len : Uint16T
    proto : Uint8T
    hop_limits : Uint8T
    src_addr : Uint8T[16]
    dst_addr : Uint8T[16]
  end

  struct LcoreConfig
    detected : LibC::UInt
    thread_id : PthreadT
    pipe_master2slave : LibC::Int[2]
    pipe_slave2master : LibC::Int[2]
    f : (Void* -> LibC::Int)
    arg : Void*
    ret : LibC::Int
    state : RteLcoreStateT
    socket_id : LibC::UInt
    core_id : LibC::UInt
    core_index : LibC::Int
    cpuset : RteCpusetT
    core_role : Uint8T
  end

  struct MallocHeap
    lock : RteSpinlockT
    free_head : MallocHeapFreeHead[13]
    alloc_count : LibC::UInt
    total_size : LibC::Int
  end

  struct MallocHeapFreeHead
    lh_first : Void*
  end

  struct Rdline
    status : RdlineStatus
    left : Cirbuf
    right : Cirbuf
    left_buf : LibC::Char[514]
    right_buf : LibC::Char[512]
    prompt : LibC::Char[32]
    prompt_size : LibC::UInt
    kill_buf : LibC::Char[512]
    kill_size : LibC::UInt
    history : Cirbuf
    history_buf : LibC::Char[8192]
    history_cur_line : LibC::Int
    write_char : (Rdline*, LibC::Char -> LibC::Int)
    validate : (Rdline*, LibC::Char*, LibC::UInt -> Void)
    complete : (Rdline*, LibC::Char*, LibC::Char*, LibC::UInt, LibC::Int* -> LibC::Int)
    vt100 : CmdlineVt100
    opaque : Void*
  end

  struct RteAclConfig
    num_categories : Uint32T
    num_fields : Uint32T
    defs : RteAclFieldDef[64]
    max_size : LibC::Int
  end

  struct RteAclField
    value : RteAclFieldTypes
    mask_range : RteAclFieldTypes
  end

  struct RteAclFieldDef
    type : Uint8T
    size : Uint8T
    field_index : Uint8T
    input_index : Uint8T
    offset : Uint32T
  end

  struct RteAclParam
    name : LibC::Char*
    socket_id : LibC::Int
    rule_size : Uint32T
    max_rule_num : Uint32T
  end

  struct RteAclRule
    data : RteAclRuleData
    field : RteAclField*
  end

  struct RteAclRuleData
    category_mask : Uint32T
    priority : Int32T
    userdata : Uint32T
  end

  struct RteAtomic16T
    cnt : Int16T
  end

  struct RteAtomic32T
    cnt : Int32T
  end

  struct RteAtomic64T
    cnt : Int64T
  end

  struct RteAvpDesc
    pad0 : Uint64T
    pkt_mbuf : Void*
    pad1 : Uint8T[14]
    ol_flags : Uint16T
    next : Void*
    data : Void*
    data_len : Uint16T
    nb_segs : Uint8T
    pad2 : Uint8T
    pkt_len : Uint16T
    pad3 : Uint32T
    vlan_tci : Uint16T
    pad4 : Uint32T
  end

  struct RteAvpDeviceConfig
    device_id : Uint64T
    driver_type : Uint32T
    driver_version : Uint32T
    features : Uint32T
    num_tx_queues : Uint16T
    num_rx_queues : Uint16T
    if_up : Uint8T
  end

  struct RteAvpDeviceInfo
    magic : Uint32T
    version : Uint32T
    ifname : LibC::Char[32]
    tx_phys : RteIovaT
    rx_phys : RteIovaT
    alloc_phys : RteIovaT
    free_phys : RteIovaT
    features : Uint32T
    min_rx_queues : Uint8T
    num_rx_queues : Uint8T
    max_rx_queues : Uint8T
    min_tx_queues : Uint8T
    num_tx_queues : Uint8T
    max_tx_queues : Uint8T
    tx_size : Uint32T
    rx_size : Uint32T
    alloc_size : Uint32T
    free_size : Uint32T
    req_phys : RteIovaT
    resp_phys : RteIovaT
    sync_phys : RteIovaT
    sync_va : Void*
    mbuf_va : Void*
    mbuf_phys : RteIovaT
    pool : RteAvpMempoolInfo[8]
    ethaddr : LibC::Char[6]
    mode : Uint8T
    mbuf_size : LibC::UInt
    device_id : Uint64T
    max_rx_pkt_len : Uint32T
  end

  struct RteAvpFifo
    write : LibC::UInt
    read : LibC::UInt
    len : LibC::UInt
    elem_size : LibC::UInt
    buffer : Void**
  end

  struct RteAvpMemmap
    addr : Void*
    phys_addr : RteIovaT
    length : Uint64T
  end

  struct RteAvpMemmapInfo
    magic : Uint32T
    version : Uint32T
    nb_maps : Uint32T
    maps : RteAvpMemmap[2048]
  end

  struct RteAvpMempoolInfo
    addr : Void*
    phys_addr : RteIovaT
    length : Uint64T
  end

  struct RteAvpRequest
    req_id : Uint32T
    result : Int32T
  end

  struct RteBbdev
    enqueue_enc_ops : RteBbdevEnqueueEncOpsT
    enqueue_dec_ops : RteBbdevEnqueueDecOpsT
    dequeue_enc_ops : RteBbdevDequeueEncOpsT
    dequeue_dec_ops : RteBbdevDequeueDecOpsT
    dev_ops : RteBbdevOps*
    data : RteBbdevData*
    state : RteBbdevState
    device : RteDevice*
    list_cbs : RteBbdevCbList
    intr_handle : RteIntrHandle*
  end

  struct RteBbdevCbList
    tqh_first : RteBbdevCallback*
    tqh_last : RteBbdevCallback**
  end

  struct RteBbdevData
    name : LibC::Char[64]
    dev_private : Void*
    num_queues : Uint16T
    queues : RteBbdevQueueData*
    dev_id : Uint16T
    socket_id : LibC::Int
    started : LibC::Int
    process_cnt : RteAtomic16T
  end

  struct RteBbdevDecOp
    status : LibC::Int
    mempool : RteMempool*
    opaque_data : Void*
    turbo_dec : RteBbdevOpTurboDec
  end

  struct RteBbdevDriverInfo
    driver_name : LibC::Char*
    max_num_queues : LibC::UInt
    queue_size_lim : Uint32T
    hardware_accelerated : LibC::Int
    max_queue_priority : Uint8T
    queue_intr_supported : LibC::Int
    min_alignment : Uint16T
    default_queue_conf : RteBbdevQueueConf
    capabilities : RteBbdevOpCap*
    cpu_flag_reqs : RteCpuFlagT*
  end

  struct RteBbdevEncOp
    status : LibC::Int
    mempool : RteMempool*
    opaque_data : Void*
    turbo_enc : RteBbdevOpTurboEnc
  end

  struct RteBbdevInfo
    socket_id : LibC::Int
    dev_name : LibC::Char*
    bus : RteBus*
    num_queues : Uint16T
    started : LibC::Int
    drv : RteBbdevDriverInfo
  end

  struct RteBbdevOpCap
    type : RteBbdevOpType
    cap : RteBbdevOpCapCap
  end

  struct RteBbdevOpCapTurboDec
    capability_flags : Uint32T
    num_buffers_src : Uint8T
    num_buffers_hard_out : Uint8T
    num_buffers_soft_out : Uint8T
  end

  struct RteBbdevOpCapTurboEnc
    capability_flags : Uint32T
    num_buffers_src : Uint8T
    num_buffers_dst : Uint8T
  end

  struct RteBbdevOpData
    data : RteMbuf*
    offset : Uint32T
    length : Uint32T
  end

  struct RteBbdevOpDecCbParams
    k : Uint16T
    e : Uint32T
  end

  struct RteBbdevOpDecTbParams
    k_neg : Uint16T
    k_pos : Uint16T
    c_neg : Uint8T
    c : Uint8T
    cab : Uint8T
    ea : Uint32T
    eb : Uint32T
  end

  struct RteBbdevOpEncCbParams
    k : Uint16T
    e : Uint32T
    ncb : Uint16T
  end

  struct RteBbdevOpEncTbParams
    k_neg : Uint16T
    k_pos : Uint16T
    c_neg : Uint8T
    c : Uint8T
    cab : Uint8T
    ea : Uint32T
    eb : Uint32T
    ncb_neg : Uint16T
    ncb_pos : Uint16T
    r : Uint8T
  end

  struct RteBbdevOpPoolPrivate
    type : RteBbdevOpType
  end

  struct RteBbdevOpTurboDec
    input : RteBbdevOpData
    hard_output : RteBbdevOpData
    soft_output : RteBbdevOpData
    op_flags : Uint32T
    rv_index : Uint8T
    iter_min : Uint8T
    iter_max : Uint8T
    iter_count : Uint8T
    ext_scale : Uint8T
    num_maps : Uint8T
    code_block_mode : Uint8T
  end

  struct RteBbdevOpTurboEnc
    input : RteBbdevOpData
    output : RteBbdevOpData
    op_flags : Uint32T
    rv_index : Uint8T
    code_block_mode : Uint8T
  end

  struct RteBbdevQueueConf
    socket : LibC::Int
    queue_size : Uint32T
    priority : Uint8T
    deferred_start : LibC::Int
    op_type : RteBbdevOpType
  end

  struct RteBbdevQueueData
    queue_private : Void*
    conf : RteBbdevQueueConf
    queue_stats : RteBbdevStats
    started : LibC::Int
  end

  struct RteBbdevQueueInfo
    conf : RteBbdevQueueConf
    started : LibC::Int
  end

  struct RteBbdevStats
    enqueued_count : Uint64T
    dequeued_count : Uint64T
    enqueue_err_count : Uint64T
    dequeue_err_count : Uint64T
  end

  struct RteBus
    next : RteBusNext
    name : LibC::Char*
    scan : Void*
    probe : Void*
    find_device : Void*
    plug : Void*
    unplug : Void*
    parse : Void*
    conf : RteBusConf
    get_iommu_class : Void*
  end

  struct RteBusConf
    scan_mode : Int32T
  end

  struct RteBusList
    tqh_first : RteBus*
    tqh_last : RteBus**
  end

  struct RteBusNext
    tqe_next : RteBus*
    tqe_prev : RteBus**
  end

  @[Packed]
  struct RteConfig
    master_lcore : Uint32T
    lcore_count : Uint32T
    service_lcore_count : Uint32T
    lcore_role : RteLcoreRoleT[128]
    process_type : RteProcTypeT
    iova_mode : RteIovaMode
    mem_config : RteMemConfig*
  end

  struct RteCryptoAeadXform
    op : RteCryptoAeadOperation
    algo : RteCryptoAeadAlgorithm
    key : RteCryptoAeadXformKey
    iv : RteCryptoAeadXformIv
    digest_length : Uint16T
    aad_length : Uint16T
  end

  struct RteCryptoAeadXformIv
    offset : Uint16T
    length : Uint16T
  end

  struct RteCryptoAeadXformKey
    data : Uint8T*
    length : Uint16T
  end

  struct RteCryptoAuthXform
    op : RteCryptoAuthOperation
    algo : RteCryptoAuthAlgorithm
    key : RteCryptoAuthXformKey
    iv : RteCryptoAuthXformIv
    digest_length : Uint16T
  end

  struct RteCryptoAuthXformIv
    offset : Uint16T
    length : Uint16T
  end

  struct RteCryptoAuthXformKey
    data : Uint8T*
    length : Uint16T
  end

  struct RteCryptoCipherXform
    op : RteCryptoCipherOperation
    algo : RteCryptoCipherAlgorithm
    key : RteCryptoCipherXformKey
    iv : RteCryptoCipherXformIv
  end

  struct RteCryptoCipherXformIv
    offset : Uint16T
    length : Uint16T
  end

  struct RteCryptoCipherXformKey
    data : Uint8T*
    length : Uint16T
  end

  struct RteCryptoOp
    type : Uint8T
    status : Uint8T
    sess_type : Uint8T
    reserved : Uint8T[5]
    mempool : RteMempool*
    phys_addr : RteIovaT
  end

  struct RteCryptoOpPoolPrivate
    type : RteCryptoOpType
    priv_size : Uint16T
  end

  struct RteCryptoParamRange
    min : Uint16T
    max : Uint16T
    increment : Uint16T
  end

  struct RteCryptoSymOp
    m_src : RteMbuf*
    m_dst : RteMbuf*
  end

  struct RteCryptoSymXform
    next : RteCryptoSymXform*
    type : RteCryptoSymXformType
  end

  struct RteCryptodev
    dequeue_burst : DequeuePktBurstT
    enqueue_burst : EnqueuePktBurstT
    data : RteCryptodevData*
    dev_ops : Void*
    feature_flags : Uint64T
    device : RteDevice*
    driver_id : Uint8T
    link_intr_cbs : RteCryptodevCbList
    security_ctx : Void*
    attached : Uint8T
  end

  struct RteCryptodevCapabilities
    op : RteCryptoOpType
  end

  struct RteCryptodevCbList
    tqh_first : RteCryptodevCallback*
    tqh_last : RteCryptodevCallback**
  end

  struct RteCryptodevConfig
    socket_id : LibC::Int
    nb_queue_pairs : Uint16T
  end

  struct RteCryptodevData
    dev_id : Uint8T
    socket_id : Uint8T
    name : LibC::Char[64]
    dev_started : Uint8T
    session_pool : RteMempool*
    queue_pairs : Void**
    nb_queue_pairs : Uint16T
    dev_private : Void*
  end

  struct RteCryptodevInfo
    driver_name : LibC::Char*
    driver_id : Uint8T
    pci_dev : Void*
    feature_flags : Uint64T
    capabilities : RteCryptodevCapabilities*
    max_nb_queue_pairs : LibC::UInt
    sym : RteCryptodevInfoSym
  end

  struct RteCryptodevInfoSym
    max_nb_sessions : LibC::UInt
    max_nb_sessions_per_qp : LibC::UInt
  end

  struct RteCryptodevQpConf
    nb_descriptors : Uint32T
  end

  struct RteCryptodevSchedulerOps
    slave_attach : RteCryptodevSchedulerSlaveAttachT
    slave_detach : RteCryptodevSchedulerSlaveAttachT
    scheduler_start : RteCryptodevSchedulerStartT
    scheduler_stop : RteCryptodevSchedulerStopT
    config_queue_pair : RteCryptodevSchedulerConfigQueuePair
    create_private_ctx : RteCryptodevSchedulerCreatePrivateCtx
    option_set : RteCryptodevSchedulerConfigOptionSet
    option_get : RteCryptodevSchedulerConfigOptionGet
  end

  struct RteCryptodevStats
    enqueued_count : Uint64T
    dequeued_count : Uint64T
    enqueue_err_count : Uint64T
    dequeue_err_count : Uint64T
  end

  struct RteCryptodevSymCapabilityIdx
    type : RteCryptoSymXformType
    algo : RteCryptodevSymCapabilityIdxAlgo
  end

  struct RteCryptodevSymSession
    sess_private_data : Void*[0]
  end

  struct RteCryptodevSymmetricCapability
    xform_type : RteCryptoSymXformType
  end

  struct RteDevEepromInfo
    data : Void*
    offset : Uint32T
    length : Uint32T
    magic : Uint32T
  end

  struct RteDevRegInfo
    data : Void*
    offset : Uint32T
    length : Uint32T
    width : Uint32T
    version : Uint32T
  end

  struct RteDevargs
    next : RteDevargsNext
    type : RteDevtype
    policy : RteDevPolicy
    bus : RteBus*
    name : LibC::Char[64]
    args : LibC::Char*
  end

  struct RteDevargsList
    tqh_first : RteDevargs*
    tqh_last : RteDevargs**
  end

  struct RteDevargsNext
    tqe_next : RteDevargs*
    tqe_prev : RteDevargs**
  end

  struct RteDevice
    next : RteDeviceNext
    name : LibC::Char*
    driver : RteDriver*
    numa_node : LibC::Int
    devargs : RteDevargs*
  end

  struct RteDeviceNext
    tqe_next : RteDevice*
    tqe_prev : RteDevice**
  end

  struct RteDriver
    next : RteDriverNext
    name : LibC::Char*
    alias : LibC::Char*
  end

  struct RteDriverNext
    tqe_next : RteDriver*
    tqe_prev : RteDriver**
  end

  struct RteEpollData
    event : Uint32T
    data : Void*
    cb_fun : RteIntrEventCbT
    cb_arg : Void*
  end

  struct RteEpollEvent
    status : Uint32T
    fd : LibC::Int
    epfd : LibC::Int
    epdata : RteEpollData
  end

  struct RteEthConf
    link_speeds : Uint32T
    rxmode : RteEthRxmode
    txmode : RteEthTxmode
    lpbk_mode : Uint32T
    rx_adv_conf : RteEthConfRxAdvConf
    tx_adv_conf : RteEthConfTxAdvConf
    dcb_capability_en : Uint32T
    fdir_conf : RteFdirConf
    intr_conf : RteIntrConf
  end

  struct RteEthConfRxAdvConf
    rss_conf : RteEthRssConf
    vmdq_dcb_conf : RteEthVmdqDcbConf
    dcb_rx_conf : RteEthDcbRxConf
    vmdq_rx_conf : RteEthVmdqRxConf
  end

  struct RteEthDcbInfo
    nb_tcs : Uint8T
    prio_tc : Uint8T[8]
    tc_bws : Uint8T[8]
    tc_queue : RteEthDcbTcQueueMapping
  end

  struct RteEthDcbRxConf
    nb_tcs : RteEthNbTcs
    dcb_tc : Uint8T[8]
  end

  struct RteEthDcbTcQueueMapping
    tc_rxq : RteEthDcbTcQueueMappingTcRxq[8][64]
    tc_txq : RteEthDcbTcQueueMappingTcTxq[8][64]
  end

  struct RteEthDcbTcQueueMappingTcRxq
    base : Uint8T
    nb_queue : Uint8T
  end

  struct RteEthDcbTcQueueMappingTcTxq
    base : Uint8T
    nb_queue : Uint8T
  end

  struct RteEthDcbTxConf
    nb_tcs : RteEthNbTcs
    dcb_tc : Uint8T[8]
  end

  struct RteEthDescLim
    nb_max : Uint16T
    nb_min : Uint16T
    nb_align : Uint16T
    nb_seg_max : Uint16T
    nb_mtu_seg_max : Uint16T
  end

  struct RteEthDev
    rx_pkt_burst : EthRxBurstT
    tx_pkt_burst : EthTxBurstT
    tx_pkt_prepare : EthTxPrepT
    data : RteEthDevData*
    dev_ops : EthDevOps*
    device : RteDevice*
    intr_handle : RteIntrHandle*
    link_intr_cbs : RteEthDevCbList
    post_rx_burst_cbs : RteEthRxtxCallback*[1024]
    pre_tx_burst_cbs : RteEthRxtxCallback*[1024]
    state : RteEthDevState
    security_ctx : Void*
  end

  struct RteEthDevCbList
    tqh_first : RteEthDevCallback*
    tqh_last : RteEthDevCallback**
  end

  struct RteEthDevData
    name : LibC::Char[64]
    rx_queues : Void**
    tx_queues : Void**
    nb_rx_queues : Uint16T
    nb_tx_queues : Uint16T
    sriov : RteEthDevSriov
    dev_private : Void*
    dev_link : RteEthLink
    dev_conf : RteEthConf
    mtu : Uint16T
    min_rx_buf_size : Uint32T
    rx_mbuf_alloc_failed : Uint64T
    mac_addrs : EtherAddr*
    mac_pool_sel : Uint64T[128]
    hash_mac_addrs : EtherAddr*
    port_id : Uint16T
    promiscuous : Uint8T
    scattered_rx : Uint8T
    all_multicast : Uint8T
    dev_started : Uint8T
    lro : Uint8T
    rx_queue_state : Uint8T[1024]
    tx_queue_state : Uint8T[1024]
    dev_flags : Uint32T
    kdrv : RteKernelDriver
    numa_node : LibC::Int
    vlan_filter_conf : RteVlanFilterConf
    owner : RteEthDevOwner
  end

  struct RteEthDevInfo
    pci_dev : RtePciDevice*
    driver_name : LibC::Char*
    if_index : LibC::UInt
    min_rx_bufsize : Uint32T
    max_rx_pktlen : Uint32T
    max_rx_queues : Uint16T
    max_tx_queues : Uint16T
    max_mac_addrs : Uint32T
    max_hash_mac_addrs : Uint32T
    max_vfs : Uint16T
    max_vmdq_pools : Uint16T
    rx_offload_capa : Uint64T
    tx_offload_capa : Uint64T
    rx_queue_offload_capa : Uint64T
    tx_queue_offload_capa : Uint64T
    reta_size : Uint16T
    hash_key_size : Uint8T
    flow_type_rss_offloads : Uint64T
    default_rxconf : RteEthRxconf
    default_txconf : RteEthTxconf
    vmdq_queue_base : Uint16T
    vmdq_queue_num : Uint16T
    vmdq_pool_base : Uint16T
    rx_desc_lim : RteEthDescLim
    tx_desc_lim : RteEthDescLim
    speed_capa : Uint32T
    nb_rx_queues : Uint16T
    nb_tx_queues : Uint16T
  end

  struct RteEthDevOwner
    id : Uint64T
    name : LibC::Char[64]
  end

  struct RteEthDevSriov
    active : Uint8T
    nb_q_per_pool : Uint8T
    def_vmdq_idx : Uint16T
    def_pool_q_idx : Uint16T
  end

  struct RteEthDevTxBuffer
    error_callback : BufferTxErrorFn
    error_userdata : Void*
    size : Uint16T
    length : Uint16T
    pkts : RteMbuf**
  end

  struct RteEthEthertypeFilter
    mac_addr : EtherAddr
    ether_type : Uint16T
    flags : Uint16T
    queue : Uint16T
  end

  struct RteEthFcConf
    high_water : Uint32T
    low_water : Uint32T
    pause_time : Uint16T
    send_xon : Uint16T
    mode : RteEthFcMode
    mac_ctrl_frame_fwd : Uint8T
    autoneg : Uint8T
  end

  struct RteEthFdirAction
    rx_queue : Uint16T
    behavior : RteEthFdirBehavior
    report_status : RteEthFdirStatus
    flex_off : Uint8T
  end

  struct RteEthFdirFilter
    soft_id : Uint32T
    input : RteEthFdirInput
    action : RteEthFdirAction
  end

  struct RteEthFdirFilterInfo
    info_type : RteEthFdirFilterInfoType
    info : RteEthFdirFilterInfoInfo
  end

  struct RteEthFdirFlexConf
    nb_payloads : Uint16T
    nb_flexmasks : Uint16T
    flex_set : RteEthFlexPayloadCfg[8]
    flex_mask : RteEthFdirFlexMask[22]
  end

  struct RteEthFdirFlexMask
    flow_type : Uint16T
    mask : Uint8T[16]
  end

  struct RteEthFdirFlowExt
    vlan_tci : Uint16T
    flexbytes : Uint8T[16]
    is_vf : Uint8T
    dst_id : Uint16T
  end

  struct RteEthFdirInfo
    mode : RteFdirMode
    mask : RteEthFdirMasks
    flex_conf : RteEthFdirFlexConf
    guarant_spc : Uint32T
    best_spc : Uint32T
    flow_types_mask : Uint64T
    max_flexpayload : Uint32T
    flex_payload_unit : Uint32T
    max_flex_payload_segment_num : Uint32T
    flex_payload_limit : Uint16T
    flex_bitmask_unit : Uint32T
    max_flex_bitmask_num : Uint32T
  end

  struct RteEthFdirInput
    flow_type : Uint16T
    flow : RteEthFdirFlow
    flow_ext : RteEthFdirFlowExt
  end

  struct RteEthFdirMasks
    vlan_tci_mask : Uint16T
    ipv4_mask : RteEthIpv4Flow
    ipv6_mask : RteEthIpv6Flow
    src_port_mask : Uint16T
    dst_port_mask : Uint16T
    mac_addr_byte_mask : Uint8T
    tunnel_id_mask : Uint32T
    tunnel_type_mask : Uint8T
  end

  struct RteEthFdirStats
    collision : Uint32T
    free : Uint32T
    maxhash : Uint32T
    maxlen : Uint32T
    add : Uint64T
    remove : Uint64T
    f_add : Uint64T
    f_remove : Uint64T
    guarant_cnt : Uint32T
    best_cnt : Uint32T
  end

  struct RteEthFlexFilter
    len : Uint16T
    bytes : Uint8T[128]
    mask : Uint8T
    priority : Uint8T
    queue : Uint16T
  end

  struct RteEthFlexPayloadCfg
    type : RteEthPayloadType
    src_offset : Uint16T[16]
  end

  struct RteEthGlobalCfg
    cfg_type : RteEthGlobalCfgType
    cfg : RteEthGlobalCfgCfg
  end

  struct RteEthHashFilterInfo
    info_type : RteEthHashFilterInfoType
    info : RteEthHashFilterInfoInfo
  end

  struct RteEthHashGlobalConf
    hash_func : RteEthHashFunction
    sym_hash_enable_mask : Uint64T
    valid_bit_mask : Uint64T
  end

  struct RteEthInputSetConf
    flow_type : Uint16T
    inset_size : Uint16T
    field : RteEthInputSetField[128]
    op : RteFilterInputSetOp
  end

  struct RteEthIpv4Flow
    src_ip : Uint32T
    dst_ip : Uint32T
    tos : Uint8T
    ttl : Uint8T
    proto : Uint8T
  end

  struct RteEthIpv6Flow
    src_ip : Uint32T[4]
    dst_ip : Uint32T[4]
    tc : Uint8T
    proto : Uint8T
    hop_limits : Uint8T
  end

  struct RteEthL2Flow
    ether_type : Uint16T
  end

  struct RteEthL2TunnelConf
    l2_tunnel_type : RteEthTunnelType
    ether_type : Uint16T
    tunnel_id : Uint32T
    vf_id : Uint16T
    pool : Uint32T
  end

  @[Flags]
  enum RteEthLinkFlags : Uint16T
    FullDuplex
    Autoneg
    StatusUp
  end

  struct RteEthLink
    link_speed : Uint32T
    link_flags : RteEthLinkFlags
  end

  struct RteEthMacFilter
    is_vf : Uint8T
    dst_id : Uint16T
    filter_type : RteMacFilterType
    mac_addr : EtherAddr
  end

  struct RteEthMacVlanFlow
    mac_addr : EtherAddr
  end

  struct RteEthMirrorConf
    rule_type : Uint8T
    dst_pool : Uint8T
    pool_mask : Uint64T
    vlan : RteEthVlanMirror
  end

  struct RteEthNtupleFilter
    flags : Uint16T
    dst_ip : Uint32T
    dst_ip_mask : Uint32T
    src_ip : Uint32T
    src_ip_mask : Uint32T
    dst_port : Uint16T
    dst_port_mask : Uint16T
    src_port : Uint16T
    src_port_mask : Uint16T
    proto : Uint8T
    proto_mask : Uint8T
    tcp_flags : Uint8T
    priority : Uint16T
    queue : Uint16T
  end

  struct RteEthPfcConf
    fc : RteEthFcConf
    priority : Uint8T
  end

  struct RteEthRssConf
    rss_key : Uint8T*
    rss_key_len : Uint8T
    rss_hf : Uint64T
  end

  struct RteEthRssRetaEntry64
    mask : Uint64T
    reta : Uint16T[64]
  end

  struct RteEthRxconf
    rx_thresh : RteEthThresh
    rx_free_thresh : Uint16T
    rx_drop_en : Uint8T
    rx_deferred_start : Uint8T
    offloads : Uint64T
  end

  # added
  @[Flags]
  enum RteEthRxmodeFlags : Uint16T
    HeaderSplit
    HwIpChecksum
    HwVlanFilter
    HwVlanStrip
    HwVlanExtend
    JumboFrame
    HwStripCrc
    EnableScatter
    EnableLro
    HwTimestamp
    Security
    IgnoreOffloadBitfield
  end

  struct RteEthRxmode
    mq_mode : RteEthRxMqMode
    max_rx_pkt_len : Uint32T
    split_hdr_size : Uint16T
    offloads : Uint64T        # !dpdk-17.08
    flags : RteEthRxmodeFlags # changed
  end

  struct RteEthRxqInfo
    mp : RteMempool*
    conf : RteEthRxconf
    scattered_rx : Uint8T
    nb_desc : Uint16T
  end

  struct RteEthRxtxCallback
    next : RteEthRxtxCallback*
    fn : RteEthRxtxCallbackFn
    param : Void*
  end

  struct RteEthSctpv4Flow
    ip : RteEthIpv4Flow
    src_port : Uint16T
    dst_port : Uint16T
    verify_tag : Uint32T
  end

  struct RteEthSctpv6Flow
    ip : RteEthIpv6Flow
    src_port : Uint16T
    dst_port : Uint16T
    verify_tag : Uint32T
  end

  struct RteEthStats
    ipackets : Uint64T
    opackets : Uint64T
    ibytes : Uint64T
    obytes : Uint64T
    imissed : Uint64T
    ierrors : Uint64T
    oerrors : Uint64T
    rx_nombuf : Uint64T
    q_ipackets : Uint64T[16]
    q_opackets : Uint64T[16]
    q_ibytes : Uint64T[16]
    q_obytes : Uint64T[16]
    q_errors : Uint64T[16]
  end

  struct RteEthSynFilter
    hig_pri : Uint8T
    queue : Uint16T
  end

  struct RteEthTcpv4Flow
    ip : RteEthIpv4Flow
    src_port : Uint16T
    dst_port : Uint16T
  end

  struct RteEthTcpv6Flow
    ip : RteEthIpv6Flow
    src_port : Uint16T
    dst_port : Uint16T
  end

  struct RteEthThresh
    pthresh : Uint8T
    hthresh : Uint8T
    wthresh : Uint8T
  end

  struct RteEthTunnelFilterConf
    outer_mac : EtherAddr
    inner_mac : EtherAddr
    inner_vlan : Uint16T
    ip_type : RteTunnelIptype
    ip_addr : RteEthTunnelFilterConfIpAddr
    filter_type : Uint16T
    tunnel_type : RteEthTunnelType
    tenant_id : Uint32T
    queue_id : Uint16T
  end

  struct RteEthTunnelFlow
    tunnel_type : RteEthFdirTunnelType
    tunnel_id : Uint32T
    mac_addr : EtherAddr
  end

  struct RteEthTxconf
    tx_thresh : RteEthThresh
    tx_rs_thresh : Uint16T
    tx_free_thresh : Uint16T
    txq_flags : Uint32T
    tx_deferred_start : Uint8T
    offloads : Uint64T
  end

  # added
  @[Flags]
  enum RteEthTxmodeFlags : Uint8T
    HwVlanRejectTagged
    HwVlanRejectUntagged
    HwVlanInsertPvid
  end

  struct RteEthTxmode
    mq_mode : RteEthTxMqMode
    offloads : Uint64T
    pvid : Uint16T
    flags : RteEthTxmodeFlags # updated
  end

  struct RteEthTxqInfo
    conf : RteEthTxconf
    nb_desc : Uint16T
  end

  struct RteEthUdpTunnel
    udp_port : Uint16T
    prot_type : Uint8T
  end

  struct RteEthUdpv4Flow
    ip : RteEthIpv4Flow
    src_port : Uint16T
    dst_port : Uint16T
  end

  struct RteEthUdpv6Flow
    ip : RteEthIpv6Flow
    src_port : Uint16T
    dst_port : Uint16T
  end

  struct RteEthVlanMirror
    vlan_mask : Uint64T
    vlan_id : Uint16T[64]
  end

  struct RteEthVmdqDcbConf
    nb_queue_pools : RteEthNbPools
    enable_default_pool : Uint8T
    default_pool : Uint8T
    nb_pool_maps : Uint8T
    pool_map : RteEthVmdqDcbConfPoolMap[64]
    dcb_tc : Uint8T[8]
  end

  struct RteEthVmdqDcbConfPoolMap
    vlan_id : Uint16T
    pools : Uint64T
  end

  struct RteEthVmdqDcbTxConf
    nb_queue_pools : RteEthNbPools
    dcb_tc : Uint8T[8]
  end

  struct RteEthVmdqRxConf
    nb_queue_pools : RteEthNbPools
    enable_default_pool : Uint8T
    default_pool : Uint8T
    enable_loop_back : Uint8T
    nb_pool_maps : Uint8T
    rx_mode : Uint32T
    pool_map : RteEthVmdqRxConfPoolMap[64]
  end

  struct RteEthVmdqRxConfPoolMap
    vlan_id : Uint16T
    pools : Uint64T
  end

  struct RteEthVmdqTxConf
    nb_queue_pools : RteEthNbPools
  end

  struct RteEthXstat
    id : Uint64T
    value : Uint64T
  end

  struct RteEthXstatName
    name : LibC::Char[64]
  end

  struct RteEventDevConfig
    dequeue_timeout_ns : Uint32T
    nb_events_limit : Int32T
    nb_event_queues : Uint8T
    nb_event_ports : Uint8T
    nb_event_queue_flows : Uint32T
    nb_event_port_dequeue_depth : Uint32T
    nb_event_port_enqueue_depth : Uint32T
    event_dev_cfg : Uint32T
  end

  struct RteEventDevInfo
    driver_name : LibC::Char*
    dev : RteDevice*
    min_dequeue_timeout_ns : Uint32T
    max_dequeue_timeout_ns : Uint32T
    dequeue_timeout_ns : Uint32T
    max_event_queues : Uint8T
    max_event_queue_flows : Uint32T
    max_event_queue_priority_levels : Uint8T
    max_event_priority_levels : Uint8T
    max_event_ports : Uint8T
    max_event_port_dequeue_depth : Uint8T
    max_event_port_enqueue_depth : Uint32T
    max_num_events : Int32T
    event_dev_cap : Uint32T
  end

  struct RteEventDevXstatsName
    name : LibC::Char[64]
  end

  struct RteEventPortConf
    new_event_threshold : Int32T
    dequeue_depth : Uint16T
    enqueue_depth : Uint16T
    disable_implicit_release : Uint8T
  end

  struct RteEventQueueConf
    nb_atomic_flows : Uint32T
    nb_atomic_order_sequences : Uint32T
    event_queue_cfg : Uint32T
    schedule_type : Uint8T
    priority : Uint8T
  end

  struct RteEventdev
    enqueue : EventEnqueueT
    enqueue_burst : EventEnqueueBurstT
    enqueue_new_burst : EventEnqueueBurstT
    enqueue_forward_burst : EventEnqueueBurstT
    dequeue : EventDequeueT
    dequeue_burst : EventDequeueBurstT
    data : RteEventdevData*
    dev_ops : RteEventdevOps*
    dev : RteDevice*
    attached : Uint8T
  end

  struct RteEventdevData
    socket_id : LibC::Int
    dev_id : Uint8T
    nb_queues : Uint8T
    nb_ports : Uint8T
    ports : Void**
    ports_cfg : RteEventPortConf*
    queues_cfg : RteEventQueueConf*
    links_map : Uint16T*
    dev_private : Void*
    event_dev_cap : Uint32T
    dev_conf : RteEventDevConfig
    service_inited : Uint8T
    service_id : Uint32T
    dev_started : Uint8T
    name : LibC::Char[64]
  end

  struct RteEventdevGlobal
    nb_devs : Uint8T
  end

  struct RteEventdevOps
    dev_infos_get : Void*
    dev_configure : Void*
    dev_start : Void*
    dev_stop : Void*
    dev_close : Void*
    queue_def_conf : Void*
    queue_setup : Void*
    queue_release : Void*
    port_def_conf : Void*
    port_setup : Void*
    port_release : Void*
    port_link : Void*
    port_unlink : Void*
    timeout_ticks : Void*
    dump : Void*
    xstats_get : Void*
    xstats_get_names : Void*
    xstats_get_by_name : Void*
    xstats_reset : Void*
    eth_rx_adapter_caps_get : Void*
    eth_rx_adapter_queue_add : Void*
    eth_rx_adapter_queue_del : Void*
    eth_rx_adapter_start : Void*
    eth_rx_adapter_stop : Void*
    eth_rx_adapter_stats_get : Void*
    eth_rx_adapter_stats_reset : Void*
    dev_selftest : Void*
  end

  struct RteFdirConf
    mode : RteFdirMode
    pballoc : RteFdirPballocType
    status : RteFdirStatusMode
    drop_queue : Uint8T
    mask : RteEthFdirMasks
    flex_conf : RteEthFdirFlexConf
  end

  struct RteFlowAction
    type : RteFlowActionType
    conf : Void*
  end

  struct RteFlowActionDup
    index : Uint16T
  end

  struct RteFlowActionMark
    id : Uint32T
  end

  struct RteFlowActionMeter
    mtr_id : Uint32T
  end

  struct RteFlowActionQueue
    index : Uint16T
  end

  struct RteFlowActionRss
    rss_conf : RteEthRssConf*
    num : Uint16T
    queue : Uint16T*
  end

  struct RteFlowActionSecurity
    security_session : Void*
  end

  struct RteFlowActionVf
    original : Uint32T
    reserved : Uint32T
    id : Uint32T
  end

  struct RteFlowAttr
    group : Uint32T
    priority : Uint32T
    ingress : Uint32T
    egress : Uint32T
    reserved : Uint32T
  end

  struct RteFlowDesc
    size : LibC::Int
    attr : RteFlowAttr
    items : RteFlowItem*
    actions : RteFlowAction*
    data : Uint8T*
  end

  struct RteFlowError
    type : RteFlowErrorType
    cause : Void*
    message : LibC::Char*
  end

  struct RteFlowItem
    type : RteFlowItemType
    spec : Void*
    last : Void*
    mask : Void*
  end

  struct RteFlowItemAny
    num : Uint32T
  end

  struct RteFlowItemETag
    tpid : RteBe16T
    epcp_edei_in_ecid_b : RteBe16T
    rsvd_grp_ecid_b : RteBe16T
    in_ecid_e : Uint8T
    ecid_e : Uint8T
  end

  struct RteFlowItemEsp
    hdr : EspHdr
  end

  struct RteFlowItemEth
    dst : EtherAddr
    src : EtherAddr
    type : RteBe16T
  end

  struct RteFlowItemFuzzy
    thresh : Uint32T
  end

  struct RteFlowItemGeneve
    ver_opt_len_o_c_rsvd0 : RteBe16T
    protocol : RteBe16T
    vni : Uint8T[3]
    rsvd1 : Uint8T
  end

  struct RteFlowItemGre
    c_rsvd0_ver : RteBe16T
    protocol : RteBe16T
  end

  struct RteFlowItemGtp
    v_pt_rsv_flags : Uint8T
    msg_type : Uint8T
    msg_len : RteBe16T
    teid : RteBe32T
  end

  struct RteFlowItemIcmp
    hdr : IcmpHdr
  end

  struct RteFlowItemIpv4
    hdr : Ipv4Hdr
  end

  struct RteFlowItemIpv6
    hdr : Ipv6Hdr
  end

  struct RteFlowItemMpls
    label_tc_s : Uint8T[3]
    ttl : Uint8T
  end

  struct RteFlowItemNvgre
    c_k_s_rsvd0_ver : RteBe16T
    protocol : RteBe16T
    tni : Uint8T[3]
    flow_id : Uint8T
  end

  struct RteFlowItemPort
    index : Uint32T
  end

  struct RteFlowItemRaw
    relative : Uint32T
    search : Uint32T
    reserved : Uint32T
    offset : Int32T
    limit : Uint16T
    length : Uint16T
    pattern : Uint8T*
  end

  struct RteFlowItemSctp
    hdr : SctpHdr
  end

  struct RteFlowItemTcp
    hdr : TcpHdr
  end

  struct RteFlowItemUdp
    hdr : UdpHdr
  end

  struct RteFlowItemVf
    id : Uint32T
  end

  struct RteFlowItemVlan
    tpid : RteBe16T
    tci : RteBe16T
  end

  struct RteFlowItemVxlan
    flags : Uint8T
    rsvd0 : Uint8T[3]
    vni : Uint8T[3]
    rsvd1 : Uint8T
  end

  struct RteFlowQueryCount
    reset : Uint32T
    hits_set : Uint32T
    bytes_set : Uint32T
    reserved : Uint32T
    hits : Uint64T
    bytes : Uint64T
  end

  enum RteIntrConf : Uint32T
    Lsc
    Rxq
    Rmv
  end

  struct RteIntrHandle
    dev_fd : LibC::Int
    fd : LibC::Int
    type : RteIntrHandleType
    max_intr : Uint32T
    nb_efd : Uint32T
    efd_counter_size : Uint8T
    efds : LibC::Int[32]
    elist : RteEpollEvent[32]
    intr_vec : LibC::Int*
  end

  struct RteKniConf
    name : LibC::Char[32]
    core_id : Uint32T
    group_id : Uint16T
    mbuf_size : LibC::UInt
    addr : RtePciAddr
    id : RtePciId
    force_bind : Uint8T
    mac_addr : LibC::Char[6]
    mtu : Uint16T
  end

  struct RteKniDeviceInfo
    name : LibC::Char[32]
    tx_phys : PhysAddrT
    rx_phys : PhysAddrT
    alloc_phys : PhysAddrT
    free_phys : PhysAddrT
    req_phys : PhysAddrT
    resp_phys : PhysAddrT
    sync_phys : PhysAddrT
    sync_va : Void*
    mbuf_va : Void*
    mbuf_phys : PhysAddrT
    vendor_id : Uint16T
    device_id : Uint16T
    bus : Uint8T
    devid : Uint8T
    function : Uint8T
    group_id : Uint16T
    core_id : Uint32T
    force_bind : Uint8T
    mbuf_size : LibC::UInt
    mtu : LibC::UInt
    mac_addr : LibC::Char[6]
  end

  struct RteKniFifo
    write : LibC::UInt
    read : LibC::UInt
    len : LibC::UInt
    elem_size : LibC::UInt
    buffer : Void**
  end

  struct RteKniMbuf
    buf_addr : Void*
    buf_physaddr : Uint64T
    data_off : Uint16T
    pad1 : LibC::Char[2]
    nb_segs : Uint16T
    pad4 : LibC::Char[2]
    ol_flags : Uint64T
    pad2 : LibC::Char[4]
    pkt_len : Uint32T
    data_len : Uint16T
    pad3 : LibC::Char[8]
    pool : Void*
    next : Void*
  end

  struct RteKniOps
    port_id : Uint16T
    change_mtu : (Uint16T, LibC::UInt -> LibC::Int)
    config_network_if : (Uint16T, Uint8T -> LibC::Int)
    config_mac_address : (Uint16T, Uint8T* -> LibC::Int)
    config_promiscusity : (Uint16T, Uint8T -> LibC::Int)
  end

  struct RteKniRequest
    req_id : Uint32T
    result : Int32T
  end

  struct RteKvargs
    str : LibC::Char*
    count : LibC::UInt
    pairs : RteKvargsPair[32]
  end

  struct RteKvargsPair
    key : LibC::Char*
    value : LibC::Char*
  end

  struct RteLogs
    type : Uint32T
    level : Uint32T
    file : Void*
    dynamic_types_len : LibC::Int
    dynamic_types : RteLogDynamicType*
  end

  struct RteLpm
    name : LibC::Char[32]
    max_rules : Uint32T
    number_tbl8s : Uint32T
    rule_info : RteLpmRuleInfo[32]
    tbl24 : RteLpmTblEntry[16777216]
    tbl8 : RteLpmTblEntry*
    rules_tbl : RteLpmRule*
  end

  struct RteLpmConfig
    max_rules : Uint32T
    number_tbl8s : Uint32T
    flags : LibC::Int
  end

  struct RteLpmRule
    ip : Uint32T
    next_hop : Uint32T
  end

  struct RteLpmRuleInfo
    used_rules : Uint32T
    first_rule : Uint32T
  end

  struct RteLpmRuleV20
    ip : Uint32T
    next_hop : Uint8T
  end

  struct RteLpmTblEntry
    next_hop : Uint32T
    valid : Uint32T
    valid_group : Uint32T
    depth : Uint32T
  end

  struct RteLpmTblEntryV20
    valid : Uint8T
    valid_group : Uint8T
    depth : Uint8T
  end

  struct RteLpmV20
    name : LibC::Char[32]
    max_rules : Uint32T
    rule_info : RteLpmRuleInfo[32]
    tbl24 : RteLpmTblEntryV20[16777216]
    tbl8 : RteLpmTblEntryV20[65536]
    rules_tbl : RteLpmRuleV20*
  end

  struct RteMallocSocketStats
    heap_totalsz_bytes : LibC::Int
    heap_freesz_bytes : LibC::Int
    greatest_free_size : LibC::Int
    free_count : LibC::UInt
    alloc_count : LibC::UInt
    heap_allocsz_bytes : LibC::Int
  end

  struct RteMbuf
    cacheline0 : Marker
    buf_addr : Void*
    buf_iova : Uint64T # 8 # !dpdk-17.08
    rearm_data : Marker64
    data_off : Uint16T # 16
    refcnt : Uint16T   # 18
    nb_segs : Uint16T  # 20
    port : Uint16T     # 22
    ol_flags : Uint64T # 24
    rx_descriptor_fields1 : Marker
    packet_type : Uint32T    # 32
    pkt_len : Uint32T        # 36
    data_len : Uint16T       # 40
    vlan_tci : Uint16T       # 42
    hash : RteMbufHash       # 44 (8)
    vlan_tci_outer : Uint16T # 52
    buf_len : Uint16T        # 54
    timestamp : Uint64T      # 56
    cacheline1 : Marker
    userdata : Uint64T   # 64
    pool : RteMempool*   # 72
    next : RteMbuf*      # 80
    tx_offload : Uint64T # 88
    priv_size : Uint16T  # 96
    timesync : Uint16T   # 98
    seqn : Uint32T       # 100
    __padding : Uint64T[3]
  end

  struct RteMbufHashFdir
    lo : Uint32T # added
    hi : Uint32T
  end

  struct RteMbufHashSched
    lo : Uint32T
    hi : Uint32T
  end

  @[Packed]
  struct RteMemConfig
    magic : Uint32T
    nchannel : Uint32T
    nrank : Uint32T
    mlock : RteRwlockT
    qlock : RteRwlockT
    mplock : RteRwlockT
    memzone_cnt : Uint32T
    memseg : RteMemseg*        # updated [256]
    memzone : RteMemzone*      # updated [2560]
    tailq_head : RteTailqHead* # updated [32]
    malloc_heaps : MallocHeap* # updated [8]
    mem_cfg_addr : Uint64T
  end

  struct RteMemResource
    phys_addr : Uint64T
    len : Uint64T
    addr : Void*
  end

  struct RteMempool
    name : LibC::Char[32]
    pool_data : Void* # added
    pool_config : Void*
    mz : RteMemzone*
    flags : LibC::UInt
    socket_id : LibC::Int
    size : Uint32T
    cache_size : Uint32T
    elt_size : Uint32T
    header_size : Uint32T
    trailer_size : Uint32T
    private_data_size : LibC::UInt
    ops_index : Int32T
    local_cache : RteMempoolCache*
    populated_size : Uint32T
    elt_list : RteMempoolObjhdrList
    nb_mem_chunks : Uint32T
    mem_list : RteMempoolMemhdrList
    __padding : LibC::Char[40]
  end

  struct RteMempoolCache
    size : Uint32T
    flushthresh : Uint32T
    len : Uint32T
    objs : Void*[1536]
  end

  struct RteMempoolMemhdr
    next : RteMempoolMemhdrNext
    mp : RteMempool*
    addr : Void*
    phys_addr : PhysAddrT
    len : Uint64T
    free_cb : (RteMempoolMemhdr*, Void* -> Void)
    opaque : Void*
  end

  struct RteMempoolMemhdrList
    stqh_first : RteMempoolMemhdr*
    stqh_last : RteMempoolMemhdr**
  end

  struct RteMempoolMemhdrNext
    stqe_next : RteMempoolMemhdr*
  end

  struct RteMempoolObjhdr
    next : RteMempoolObjhdrNext
    mp : RteMempool*
    physaddr : PhysAddrT
  end

  struct RteMempoolObjhdrList
    stqh_first : RteMempoolObjhdr*
    stqh_last : RteMempoolObjhdr**
  end

  struct RteMempoolObjhdrNext
    stqe_next : RteMempoolObjhdr*
  end

  struct RteMempoolObjsz
    elt_size : Uint32T
    header_size : Uint32T
    trailer_size : Uint32T
    total_size : Uint32T
  end

  struct RteMempoolOps
    name : LibC::Char[32]
    alloc : RteMempoolAllocT
    free : RteMempoolFreeT
    enqueue : RteMempoolEnqueueT
    dequeue : RteMempoolDequeueT
    get_count : RteMempoolGetCount
    get_capabilities : RteMempoolGetCapabilitiesT
    register_memory_area : RteMempoolOpsRegisterMemoryAreaT
  end

  struct RteMempoolOpsTable
    sl : RteSpinlockT
    num_ops : Uint32T
    ops : RteMempoolOps[16]
  end

  @[Packed]
  struct RteMemseg
    phys_addr : PhysAddrT
    addr : Void*
    len : Uint64T
    hugepage_sz : Uint64T
    socket_id : Int32T
    nchannel : Uint32T
    nrank : Uint32T
  end

  @[Packed]
  struct RteMemzone
    name : LibC::Char[32]
    iova : RteIovaT # added
    addr : Void*    # added
    len : Uint64T   # changed
    hugepage_sz : Uint64T
    socket_id : Int32T
    flags : Uint32T
    memseg_id : Uint32T
  end

  struct RteMeterSrtcm
    time : Uint64T
    tc : Uint64T
    te : Uint64T
    cbs : Uint64T
    ebs : Uint64T
    cir_period : Uint64T
    cir_bytes_per_period : Uint64T
  end

  struct RteMeterSrtcmParams
    cir : Uint64T
    cbs : Uint64T
    ebs : Uint64T
  end

  struct RteMeterTrtcm
    time_tc : Uint64T
    time_tp : Uint64T
    tc : Uint64T
    tp : Uint64T
    cbs : Uint64T
    pbs : Uint64T
    cir_period : Uint64T
    cir_bytes_per_period : Uint64T
    pir_period : Uint64T
    pir_bytes_per_period : Uint64T
  end

  struct RteMeterTrtcmParams
    cir : Uint64T
    pir : Uint64T
    cbs : Uint64T
    pbs : Uint64T
  end

  struct RteMetricName
    name : LibC::Char[64]
  end

  struct RteMetricValue
    key : Uint16T
    value : Uint64T
  end

  struct RteMpMsg
    name : LibC::Char[64]
    len_param : LibC::Int
    num_fds : LibC::Int
    param : Uint8T[256]
    fds : LibC::Int[8]
  end

  struct RteMpReply
    nb_sent : LibC::Int
    nb_received : LibC::Int
    msgs : RteMpMsg*
  end

  struct RteMtrCapabilities
    n_max : Uint32T
    n_shared_max : Uint32T
    identical : LibC::Int
    shared_identical : LibC::Int
    shared_n_flows_per_mtr_max : Uint32T
    chaining_n_mtrs_per_flow_max : Uint32T
    chaining_use_prev_mtr_color_supported : LibC::Int
    chaining_use_prev_mtr_color_enforced : LibC::Int
    meter_srtcm_rfc2697_n_max : Uint32T
    meter_trtcm_rfc2698_n_max : Uint32T
    meter_trtcm_rfc4115_n_max : Uint32T
    meter_rate_max : Uint64T
    color_aware_srtcm_rfc2697_supported : LibC::Int
    color_aware_trtcm_rfc2698_supported : LibC::Int
    color_aware_trtcm_rfc4115_supported : LibC::Int
    policer_action_recolor_supported : LibC::Int
    policer_action_drop_supported : LibC::Int
    stats_mask : Uint64T
  end

  struct RteMtrError
    type : RteMtrErrorType
    cause : Void*
    message : LibC::Char*
  end

  struct RteMtrMeterProfile
    alg : RteMtrAlgorithm
  end

  struct RteMtrParams
    meter_profile_id : Uint32T
    use_prev_mtr_color : LibC::Int
    dscp_table : RteMtrColor*
    meter_enable : LibC::Int
    action : RteMtrPolicerAction[3]
    stats_mask : Uint64T
  end

  struct RteMtrStats
    n_pkts : Uint64T[3]
    n_bytes : Uint64T[3]
    n_pkts_dropped : Uint64T
    n_bytes_dropped : Uint64T
  end

  struct RtePciAddr
    domain : Uint32T
    bus : Uint8T
    devid : Uint8T
    function : Uint8T
  end

  struct RtePciBus
    bus : RteBus
    device_list : RtePciDeviceList
    driver_list : RtePciDriverList
  end

  struct RtePciDevice
    next : RtePciDeviceNext
    device : RteDevice
    addr : RtePciAddr
    id : RtePciId
    mem_resource : RteMemResource[6]
    intr_handle : RteIntrHandle
    driver : RtePciDriver*
    max_vfs : Uint16T
    kdrv : RteKernelDriver
    name : LibC::Char[18]
  end

  struct RtePciDeviceList
    tqh_first : RtePciDevice*
    tqh_last : RtePciDevice**
  end

  struct RtePciDeviceNext
    tqe_next : RtePciDevice*
    tqe_prev : RtePciDevice**
  end

  struct RtePciDriver
    next : RtePciDriverNext
    driver : RteDriver
    bus : RtePciBus*
    probe : (RtePciDriver*, RtePciDevice* -> LibC::Int)
    remove : (RtePciDevice* -> LibC::Int)
    id_table : RtePciId*
    drv_flags : Uint32T
  end

  struct RtePciDriverList
    tqh_first : RtePciDriver*
    tqh_last : RtePciDriver**
  end

  struct RtePciDriverNext
    tqe_next : RtePciDriver*
    tqe_prev : RtePciDriver**
  end

  struct RtePciId
    class_id : Uint32T
    vendor_id : Uint16T
    device_id : Uint16T
    subsystem_vendor_id : Uint16T
    subsystem_device_id : Uint16T
  end

  struct RtePciIoport
    dev : RtePciDevice*
    base : Uint64T
    len : Uint64T
  end

  struct RtePktmbufPoolPrivate
    mbuf_data_room_size : Uint16T
    mbuf_priv_size : Uint16T
  end

  struct RtePortInOps
    f_create : RtePortInOpCreate
    f_free : RtePortInOpFree
    f_rx : RtePortInOpRx
    f_stats : RtePortInOpStatsRead
  end

  struct RtePortInStats
    n_pkts_in : Uint64T
    n_pkts_drop : Uint64T
  end

  struct RtePortOutOps
    f_create : RtePortOutOpCreate
    f_free : RtePortOutOpFree
    f_tx : RtePortOutOpTx
    f_tx_bulk : RtePortOutOpTxBulk
    f_flush : RtePortOutOpFlush
    f_stats : RtePortOutOpStatsRead
  end

  struct RtePortOutStats
    n_pkts_in : Uint64T
    n_pkts_drop : Uint64T
  end

  struct RteRawdevBuf
    buf_addr : Void*
  end

  struct RteRawdevXstatsName
    name : LibC::Char[64]
  end

  struct RteRing
    name : LibC::Char[32]
    flags : LibC::Int # 32
    # + 4
    memzone : RteMemzone* # 40
    size : Uint32T        # 48
    mask : Uint32T        # 52
    capacity : Uint32T    # 56
    # + 4
    __padding2 : LibC::Char[64]
    prod : RteRingHeadtail # 128
    __padding3 : LibC::Char[120]
    cons : RteRingHeadtail # 256
    # + 8
    __padding4 : LibC::Char[112]
  end

  struct RteRingHeadtail
    head : Uint32T
    tail : Uint32T
    single : Uint32T
  end

  struct RteRwlockT
    cnt : Int32T
  end

  struct RteSchedPipeParams
    tb_rate : Uint32T
    tb_size : Uint32T
    tc_rate : Uint32T[4]
    tc_period : Uint32T
    wrr_weights : Uint8T[16]
  end

  struct RteSchedPortParams
    name : LibC::Char*
    socket : LibC::Int
    rate : Uint32T
    mtu : Uint32T
    frame_overhead : Uint32T
    n_subports_per_port : Uint32T
    n_pipes_per_subport : Uint32T
    qsize : Uint16T[4]
    pipe_profiles : RteSchedPipeParams*
    n_pipe_profiles : Uint32T
  end

  struct RteSchedQueueStats
    n_pkts : Uint32T
    n_pkts_dropped : Uint32T
    n_bytes : Uint32T
    n_bytes_dropped : Uint32T
  end

  struct RteSchedSubportParams
    tb_rate : Uint32T
    tb_size : Uint32T
    tc_rate : Uint32T[4]
    tc_period : Uint32T
  end

  struct RteSchedSubportStats
    n_pkts_tc : Uint32T[4]
    n_pkts_tc_dropped : Uint32T[4]
    n_bytes_tc : Uint32T[4]
    n_bytes_tc_dropped : Uint32T[4]
  end

  struct RteSecurityCapability
    action : RteSecuritySessionActionType
    protocol : RteSecuritySessionProtocol
    crypto_capabilities : Void*
    ol_flags : Uint32T
  end

  struct RteSecurityCapabilityIdx
    action : RteSecuritySessionActionType
    protocol : RteSecuritySessionProtocol
  end

  struct RteSecurityIpsecSaOptions
    esn : Uint32T
    udp_encap : Uint32T
    copy_dscp : Uint32T
    copy_flabel : Uint32T
    copy_df : Uint32T
    dec_ttl : Uint32T
  end

  struct RteSecurityIpsecStats
    reserved : Uint64T
  end

  struct RteSecurityIpsecTunnelParam
    type : RteSecurityIpsecTunnelType
  end

  struct RteSecurityIpsecXform
    spi : Uint32T
    salt : Uint32T
    options : RteSecurityIpsecSaOptions
    direction : RteSecurityIpsecSaDirection
    proto : RteSecurityIpsecSaProtocol
    mode : RteSecurityIpsecSaMode
    tunnel : RteSecurityIpsecTunnelParam
  end

  struct RteSecurityMacsecStats
    reserved : Uint64T
  end

  struct RteSecurityMacsecXform
    dummy : LibC::Int
  end

  struct RteSecuritySession
    sess_private_data : Void*
  end

  struct RteSecuritySessionConf
    action_type : RteSecuritySessionActionType
    protocol : RteSecuritySessionProtocol
    crypto_xform : RteCryptoSymXform*
    userdata : Void*
  end

  struct RteSecurityStats
    protocol : RteSecuritySessionProtocol
  end

  struct RteSpinlockRecursiveT
    sl : RteSpinlockT
    user : LibC::Int
    count : LibC::Int
  end

  struct RteSpinlockT
    locked : LibC::Int
  end

  struct RteTableAclParams
    name : LibC::Char*
    n_rules : Uint32T
    n_rule_fields : Uint32T
    field_format : RteAclFieldDef[64]
  end

  struct RteTableAclRuleAddParams
    priority : Int32T
    field_value : RteAclField[64]
  end

  struct RteTableAclRuleDeleteParams
    field_value : RteAclField[64]
  end

  struct RteTableOps
    f_create : RteTableOpCreate
    f_free : RteTableOpFree
    f_add : RteTableOpEntryAdd
    f_delete : RteTableOpEntryDelete
    f_add_bulk : RteTableOpEntryAddBulk
    f_delete_bulk : RteTableOpEntryDeleteBulk
    f_lookup : RteTableOpLookup
    f_stats : RteTableOpStatsRead
  end

  struct RteTableStats
    n_pkts_in : Uint64T
    n_pkts_lookup_miss : Uint64T
  end

  struct RteTailqElem
    head : RteTailqHead*
    next : RteTailqElemNext
    name : LibC::Char[32]
  end

  struct RteTailqElemNext
    tqe_next : RteTailqElem*
    tqe_prev : RteTailqElem**
  end

  struct RteTailqEntry
    next : RteTailqEntryNext
    data : Void*
  end

  struct RteTailqEntryHead
    tqh_first : RteTailqEntry*
    tqh_last : RteTailqEntry**
  end

  struct RteTailqEntryNext
    tqe_next : RteTailqEntry*
    tqe_prev : RteTailqEntry**
  end

  struct RteTailqHead
    tailq_head : RteTailqEntryHead
    name : LibC::Char[32]
  end

  struct RteTmCapabilities
    n_nodes_max : Uint32T
    n_levels_max : Uint32T
    non_leaf_nodes_identical : LibC::Int
    leaf_nodes_identical : LibC::Int
    shaper_n_max : Uint32T
    shaper_private_n_max : Uint32T
    shaper_private_dual_rate_n_max : LibC::Int
    shaper_private_rate_min : Uint64T
    shaper_private_rate_max : Uint64T
    shaper_shared_n_max : Uint32T
    shaper_shared_n_nodes_per_shaper_max : Uint32T
    shaper_shared_n_shapers_per_node_max : Uint32T
    shaper_shared_dual_rate_n_max : Uint32T
    shaper_shared_rate_min : Uint64T
    shaper_shared_rate_max : Uint64T
    shaper_pkt_length_adjust_min : LibC::Int
    shaper_pkt_length_adjust_max : LibC::Int
    sched_n_children_max : Uint32T
    sched_sp_n_priorities_max : Uint32T
    sched_wfq_n_children_per_group_max : Uint32T
    sched_wfq_n_groups_max : Uint32T
    sched_wfq_weight_max : Uint32T
    cman_head_drop_supported : LibC::Int
    cman_wred_context_n_max : Uint32T
    cman_wred_context_private_n_max : Uint32T
    cman_wred_context_shared_n_max : Uint32T
    cman_wred_context_shared_n_nodes_per_context_max : Uint32T
    cman_wred_context_shared_n_contexts_per_node_max : Uint32T
    mark_vlan_dei_supported : LibC::Int[3]
    mark_ip_ecn_tcp_supported : LibC::Int[3]
    mark_ip_ecn_sctp_supported : LibC::Int[3]
    mark_ip_dscp_supported : LibC::Int[3]
    dynamic_update_mask : Uint64T
    stats_mask : Uint64T
  end

  struct RteTmError
    type : RteTmErrorType
    cause : Void*
    message : LibC::Char*
  end

  struct RteTmLevelCapabilities
    n_nodes_max : Uint32T
    n_nodes_nonleaf_max : Uint32T
    n_nodes_leaf_max : Uint32T
    non_leaf_nodes_identical : LibC::Int
    leaf_nodes_identical : LibC::Int
  end

  struct RteTmNodeCapabilities
    shaper_private_supported : LibC::Int
    shaper_private_dual_rate_supported : LibC::Int
    shaper_private_rate_min : Uint64T
    shaper_private_rate_max : Uint64T
    shaper_shared_n_max : Uint32T
    stats_mask : Uint64T
  end

  struct RteTmNodeParams
    shaper_profile_id : Uint32T
    shared_shaper_id : Uint32T*
    n_shared_shapers : Uint32T
    stats_mask : Uint64T
  end

  struct RteTmNodeStats
    n_pkts : Uint64T
    n_bytes : Uint64T
    leaf : RteTmNodeStatsLeaf
  end

  struct RteTmNodeStatsLeaf
    n_pkts_dropped : Uint64T[3]
    n_bytes_dropped : Uint64T[3]
    n_pkts_queued : Uint64T
    n_bytes_queued : Uint64T
  end

  struct RteTmRedParams
    min_th : Uint16T
    max_th : Uint16T
    maxp_inv : Uint16T
    wq_log2 : Uint16T
  end

  struct RteTmShaperParams
    committed : RteTmTokenBucket
    peak : RteTmTokenBucket
    pkt_length_adjust : Int32T
  end

  struct RteTmTokenBucket
    rate : Uint64T
    size : Uint64T
  end

  struct RteTmWredParams
    red_params : RteTmRedParams[3]
  end

  struct RteVdevDevice
    next : RteVdevDeviceNext
    device : RteDevice
  end

  struct RteVdevDeviceNext
    tqe_next : RteVdevDevice*
    tqe_prev : RteVdevDevice**
  end

  struct RteVdevDriver
    next : RteVdevDriverNext
    driver : RteDriver
    probe : (RteVdevDevice* -> LibC::Int)
    remove : (RteVdevDevice* -> LibC::Int)
  end

  struct RteVdevDriverNext
    tqe_next : RteVdevDriver*
    tqe_prev : RteVdevDriver**
  end

  struct RteVhostMemRegion
    guest_phys_addr : Uint64T
    guest_user_addr : Uint64T
    host_user_addr : Uint64T
    size : Uint64T
    mmap_addr : Void*
    mmap_size : Uint64T
    fd : LibC::Int
  end

  struct RteVhostMemory
    nregions : Uint32T
    regions : RteVhostMemRegion*
  end

  struct RteVhostVring
    desc : VringDesc*
    avail : VringAvail*
    used : VringUsed*
    log_guest_addr : Uint64T
    callfd : LibC::Int
    kickfd : LibC::Int
    size : Uint16T
  end

  struct RteVlanFilterConf
    ids : Uint64T[64]
  end

  struct SctpHdr
    src_port : Uint16T
    dst_port : Uint16T
    tag : Uint32T
    cksum : Uint32T
  end

  struct TcpHdr
    src_port : Uint16T
    dst_port : Uint16T
    sent_seq : Uint32T
    recv_ack : Uint32T
    data_off : Uint8T
    tcp_flags : Uint8T
    rx_win : Uint16T
    cksum : Uint16T
    tcp_urp : Uint16T
  end

  struct Termios
    c_iflag : TcflagT
    c_oflag : TcflagT
    c_cflag : TcflagT
    c_lflag : TcflagT
    c_line : CcT
    c_cc : CcT[32]
    c_ispeed : SpeedT
    c_ospeed : SpeedT
  end

  struct UdpHdr
    src_port : Uint16T
    dst_port : Uint16T
    dgram_len : Uint16T
    dgram_cksum : Uint16T
  end

  struct VhostDeviceOps
    new_device : (LibC::Int -> LibC::Int)
    destroy_device : (LibC::Int -> Void)
    vring_state_changed : (LibC::Int, Uint16T, LibC::Int -> LibC::Int)
    features_changed : (LibC::Int, Uint64T -> LibC::Int)
    new_connection : (LibC::Int -> LibC::Int)
    destroy_connection : (LibC::Int -> Void)
    reserved : Void*[2]
  end

  struct VringAvail
    flags : X__Virtio16
    idx : X__Virtio16
    ring : X__Virtio16*
  end

  struct VringDesc
    addr : X__Virtio64
    len : X__Virtio32
    flags : X__Virtio16
    next : X__Virtio16
  end

  struct VringUsed
    flags : X__Virtio16
    idx : X__Virtio16
    ring : VringUsedElem*
  end

  struct VringUsedElem
    id : X__Virtio32
    len : X__Virtio32
  end

  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    __pad1 : Void*
    __pad2 : Void*
    __pad3 : Void*
    __pad4 : Void*
    __pad5 : LibC::Int
    _mode : LibC::Int
    _unused2 : LibC::Char
  end

  struct X_IoMarker
    _next : X_IoMarker*
    _sbuf : X_IoFile*
    _pos : LibC::Int
  end

  type CmdlineParseInstT = CmdlineInst
  type CmdlineParseTokenHdrT = CmdlineTokenHdr
  type File = X_IoFile

  union In6AddrIn6U
    __u6_addr8 : Uint8T[16]
    __u6_addr16 : Uint16T[8]
    __u6_addr32 : Uint32T[4]
  end

  union RteAclFieldTypes
    u8 : Uint8T
    u16 : Uint16T
    u32 : Uint32T
    u64 : Uint64T
  end

  union RteBbdevOpCapCap
    turbo_dec : RteBbdevOpCapTurboDec
    turbo_enc : RteBbdevOpCapTurboEnc
  end

  union RteCryptodevSymCapabilityIdxAlgo
    cipher : RteCryptoCipherAlgorithm
    auth : RteCryptoAuthAlgorithm
    aead : RteCryptoAeadAlgorithm
  end

  union RteEthConfTxAdvConf
    vmdq_dcb_tx_conf : RteEthVmdqDcbTxConf
    dcb_tx_conf : RteEthDcbTxConf
    vmdq_tx_conf : RteEthVmdqTxConf
  end

  union RteEthFdirFilterInfoInfo
    input_set_conf : RteEthInputSetConf
  end

  union RteEthFdirFlow
    l2_flow : RteEthL2Flow
    udp4_flow : RteEthUdpv4Flow
    tcp4_flow : RteEthTcpv4Flow
    sctp4_flow : RteEthSctpv4Flow
    ip4_flow : RteEthIpv4Flow
    udp6_flow : RteEthUdpv6Flow
    tcp6_flow : RteEthTcpv6Flow
    sctp6_flow : RteEthSctpv6Flow
    ipv6_flow : RteEthIpv6Flow
    mac_vlan_flow : RteEthMacVlanFlow
    tunnel_flow : RteEthTunnelFlow
  end

  union RteEthGlobalCfgCfg
    gre_key_len : Uint8T
    reserved : Uint64T
  end

  union RteEthHashFilterInfoInfo
    enable : Uint8T
    global_conf : RteEthHashGlobalConf
    input_set_conf : RteEthInputSetConf
  end

  union RteEthRxtxCallbackFn
    rx : RteRxCallbackFn
    tx : RteTxCallbackFn
  end

  union RteEthTunnelFilterConfIpAddr
    ipv4_addr : Uint32T
    ipv6_addr : Uint32T[4]
  end

  union RteMbufHash
    rss : Uint32T
    fdir : RteMbufHashFdir
    sched : RteMbufHashSched
    usr : Uint32T
  end

  union RteXmm
    x : XmmT
    u8 : Uint8T[4]
    u16 : Uint16T[2]
    u32 : Uint32T[1]
    u64 : Uint64T[0]
    pd : LibC::Double[0]
  end
end

require "./lib_rte_bitrate.cr"
require "./lib_rte_sched.cr"
require "./lib_rte_eventdev.cr"
require "./lib_rte_port_kni.cr"
require "./lib_rte_port_ras.cr"
require "./lib_rte_pipeline.cr"
require "./lib_rte_rawdev.cr"
require "./lib_rte_gso.cr"
require "./lib_rte_port_ethdev.cr"
require "./lib_eal_thread.cr"
require "./lib_cmdline_socket.cr"
require "./lib_rte_mbuf_pool_ops.cr"
require "./lib_rte_rawdev_pmd.cr"
require "./lib_rte_ethdev_core.cr"
require "./lib_rte_service_component.cr"
require "./lib_rte_pdump.cr"
require "./lib_rte_distributor_private.cr"
require "./lib_rte_table_array.cr"
require "./lib_rte_random.cr"
require "./lib_rte_gro.cr"
require "./lib_rte_ip_frag.cr"
require "./lib_rte_eth_bond.cr"
require "./lib_rte_table_lpm.cr"
require "./lib_rte_cryptodev_pmd.cr"
require "./lib_rte_flow.cr"
require "./lib_rte_io.cr"
require "./lib_rte_reciprocal.cr"
require "./lib_rte_eth_vhost.cr"
require "./lib_rte_mtr_driver.cr"
require "./lib_rte_ethdev_pci.cr"
require "./lib_rte_hypervisor.cr"
require "./lib_eal_hugepages.cr"
require "./lib_rte_flow_driver.cr"
require "./lib_rte_approx.cr"
require "./lib_rte_table_hash.cr"
require "./lib_rte_bitmap.cr"
require "./lib_rte_pmd_ixgbe.cr"
require "./lib_rte_pmd_bnxt.cr"
require "./lib_rte_memcpy.cr"
require "./lib_rte_eth_ring.cr"
require "./lib_rte_devargs.cr"
require "./lib_rte_power.cr"
require "./lib_rte_security.cr"
require "./lib_rte_fbk_hash.cr"
require "./lib_rte_distributor_v20.cr"
require "./lib_rte_hexdump.cr"
require "./lib_rte_avp_fifo.cr"
require "./lib_cmdline_parse_num.cr"
require "./lib_rte_table_lpm_ipv6.cr"
require "./lib_rte_port_frag.cr"
require "./lib_rte_pci.cr"
require "./lib_eal_private.cr"
require "./lib_rte_port_sched.cr"
require "./lib_malloc_elem.cr"
require "./lib_cmdline_parse_etheraddr.cr"
require "./lib_cmdline_rdline.cr"
require "./lib_rte_jobstats.cr"
require "./lib_cmdline_parse_ipaddr.cr"
require "./lib_rte_pmd_i40e.cr"
require "./lib_rte_net.cr"
require "./lib_rte_distributor.cr"
require "./lib_rte_table_stub.cr"
require "./lib_cmdline_parse_string.cr"
require "./lib_rte_distributor_v1705.cr"
require "./lib_rte_vhost.cr"
require "./lib_cmdline_parse_portlist.cr"
require "./lib_rte_bbdev.cr"
require "./lib_rte_port_ring.cr"
require "./lib_rte_eth_bond_8023ad.cr"
require "./lib_rte_alarm.cr"
require "./lib_rte_timer.cr"
require "./lib_rte_cryptodev_scheduler.cr"
require "./lib_rte_net_crc.cr"
require "./lib_rte_eventdev_pmd_pci.cr"
require "./lib_rte_tm_driver.cr"
require "./lib_rte_flow_classify.cr"
require "./lib_cmdline_cirbuf.cr"
require "./lib_rte_security_driver.cr"
require "./lib_rte_cfgfile.cr"
require "./lib_rte_version.cr"
require "./lib_rte_efd.cr"
require "./lib_malloc_heap.cr"
require "./lib_rte_ethdev_vdev.cr"
require "./lib_rte_thash.cr"
require "./lib_rte_keepalive.cr"
require "./lib_rte_event_ring.cr"
require "./lib_cmdline_vt100.cr"
require "./lib_rte_eth_softnic.cr"
require "./lib_rte_red.cr"
require "./lib_rte_sched_common.cr"
require "./lib_rte_port_source_sink.cr"
require "./lib_rte_hash.cr"
require "./lib_rte_bbdev_pmd.cr"
require "./lib_rte_arp.cr"
require "./lib_rte_member.cr"
require "./lib_rte_byteorder_32.cr"
require "./lib_rte_lpm6.cr"
require "./lib_rte_esp.cr"
require "./lib_rte_gre.cr"
require "./lib_rte_latencystats.cr"
require "./lib_rte_port_fd.cr"
require "./lib_rte_reorder.cr"
require "./lib_rte_ip.cr"
require "./lib_rte_eventdev_pmd_vdev.cr"
require "./lib_rte_event_eth_rx_adapter.cr"
require "./lib_rte_time.cr"
require "./lib_rte_ether.cr"
