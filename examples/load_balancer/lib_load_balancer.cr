require "../../src/lib_dpdk"
require "../../src/dpdk/constants"

lib LibLoadBalancer
  RTE_MAX_LCORE    = Constants::RTE_MAX_LCORE
  RTE_MAX_ETHPORTS = Constants::RTE_MAX_ETHPORTS

  APP_MAX_LCORES                     = RTE_MAX_LCORE
  APP_MAX_IO_LCORES                  = APP_MAX_LCORES
  APP_MAX_WORKER_LCORES              = APP_MAX_LCORES
  APP_MAX_NIC_PORTS                  = RTE_MAX_ETHPORTS
  APP_MAX_RX_QUEUES_PER_NIC_PORT     = 128
  APP_MAX_TX_QUEUES_PER_NIC_PORT     = 128
  APP_MAX_NIC_RX_QUEUES_PER_IO_LCORE =  16
  APP_MAX_NIC_TX_PORTS_PER_IO_LCORE  =  16
  APP_MAX_LPM_RULES                  =   8
  APP_MAX_SOCKETS                    =   2
  APP_MBUF_ARRAY_SIZE                = 512

  alias RteMbuf = LibDpdk::RteMbuf
  alias RteRing = LibDpdk::RteRing
  alias RteLpm = LibDpdk::RteLpm
  alias RteMempool = LibDpdk::RteMempool
  alias Uint16T = LibC::UShort
  alias Uint32T = LibC::UInt
  alias Uint64T = LibC::ULong
  alias Uint8T = UInt8

  enum AppLcoreType
    EAppLcoreDisabled = 0
    EAppLcoreIo       = 1
    EAppLcoreWorker   = 2
  end

  struct AppLcoreParams
    u : AppLcoreParamsU
    type : AppLcoreType
    pool : RteMempool*
  end

  struct AppLcoreParamsIo
    rx : AppLcoreParamsIoRx
    tx : AppLcoreParamsIoTx
  end

  struct AppLcoreParamsIoRx
    nic_queues : AppLcoreParamsIoRxNicQueues[APP_MAX_NIC_RX_QUEUES_PER_IO_LCORE]
    n_nic_queues : Uint32T
    rings : RteRing*[APP_MAX_WORKER_LCORES]
    n_rings : Uint32T
    mbuf_in : AppMbufArray
    mbuf_out : AppMbufArray[APP_MAX_WORKER_LCORES]
    mbuf_out_flush : Uint8T[APP_MAX_WORKER_LCORES]
    nic_queues_count : Uint32T[APP_MAX_NIC_RX_QUEUES_PER_IO_LCORE]
    nic_queues_iters : Uint32T[APP_MAX_NIC_RX_QUEUES_PER_IO_LCORE]
    rings_count : Uint32T[APP_MAX_WORKER_LCORES]
    rings_iters : Uint32T[APP_MAX_WORKER_LCORES]
  end

  struct AppLcoreParamsIoRxNicQueues
    port : Uint16T
    queue : Uint8T
  end

  struct AppLcoreParamsIoTx
    rings : RteRing*[APP_MAX_WORKER_LCORES][APP_MAX_NIC_PORTS]
    nic_ports : Uint16T[APP_MAX_NIC_TX_PORTS_PER_IO_LCORE]
    n_nic_ports : Uint32T
    mbuf_out : AppMbufArray[APP_MAX_NIC_TX_PORTS_PER_IO_LCORE]
    mbuf_out_flush : Uint8T[APP_MAX_NIC_TX_PORTS_PER_IO_LCORE]
    rings_count : Uint32T[APP_MAX_WORKER_LCORES][APP_MAX_NIC_PORTS]
    rings_iters : Uint32T[APP_MAX_WORKER_LCORES][APP_MAX_NIC_PORTS]
    nic_ports_count : Uint32T[APP_MAX_NIC_TX_PORTS_PER_IO_LCORE]
    nic_ports_iters : Uint32T[APP_MAX_NIC_TX_PORTS_PER_IO_LCORE]
  end

  struct AppLcoreParamsWorker
    rings_in : RteRing*[APP_MAX_IO_LCORES]
    n_rings_in : Uint32T
    rings_out : RteRing*[APP_MAX_NIC_PORTS]
    lpm_table : RteLpm*
    worker_id : Uint32T
    mbuf_in : AppMbufArray
    mbuf_out : AppMbufArray[APP_MAX_NIC_PORTS]
    mbuf_out_flush : Uint8T[APP_MAX_NIC_PORTS]
    rings_in_count : Uint32T[APP_MAX_IO_LCORES]
    rings_in_iters : Uint32T[APP_MAX_IO_LCORES]
    rings_out_count : Uint32T[APP_MAX_NIC_PORTS]
    rings_out_iters : Uint32T[APP_MAX_NIC_PORTS]
  end

  struct AppLpmRule
    ip : Uint32T
    depth : Uint8T
    if_out : Uint8T
  end

  struct AppMbufArray
    array : RteMbuf*[APP_MBUF_ARRAY_SIZE]
    n_mbufs : Uint32T
  end

  struct AppParams
    lcore_params : AppLcoreParams[APP_MAX_LCORES]
    nic_rx_queue_mask : Uint8T[APP_MAX_RX_QUEUES_PER_NIC_PORT][APP_MAX_NIC_PORTS]
    nic_tx_port_mask : Uint8T[APP_MAX_NIC_PORTS]
    pools : RteMempool*[APP_MAX_SOCKETS]
    lpm_tables : RteLpm*[APP_MAX_SOCKETS]
    lpm_rules : AppLpmRule[APP_MAX_LPM_RULES]
    n_lpm_rules : Uint32T
    nic_rx_ring_size : Uint32T
    nic_tx_ring_size : Uint32T
    ring_rx_size : Uint32T
    ring_tx_size : Uint32T
    burst_size_io_rx_read : Uint32T
    burst_size_io_rx_write : Uint32T
    burst_size_io_tx_read : Uint32T
    burst_size_io_tx_write : Uint32T
    burst_size_worker_read : Uint32T
    burst_size_worker_write : Uint32T
    pos_lb : Uint8T
  end

  union AppLcoreParamsU
    io : AppLcoreParamsIo
    worker : AppLcoreParamsWorker
  end
end
