module Constants
  APP_MAX_LCORES                     = RTE_MAX_LCORE
  APP_MAX_IO_LCORES                  = APP_MAX_LCORES
  APP_MAX_WORKER_LCORES              = APP_MAX_LCORES
  APP_MAX_NIC_PORTS                  = RTE_MAX_ETHPORTS
  APP_MAX_RX_QUEUES_PER_NIC_PORT     = 128
  APP_MAX_TX_QUEUES_PER_NIC_PORT     = 128
  APP_MAX_NIC_RX_QUEUES_PER_IO_LCORE =  16
  APP_MAX_NIC_TX_PORTS_PER_IO_LCORE  =  16
  APP_MAX_LPM_RULES                  =   8 # 1024
  APP_MAX_SOCKETS                    =   2
  APP_MBUF_ARRAY_SIZE                = 512

  APP_DEFAULT_MBUF_DATA_SIZE     = RTE_MBUF_DEFAULT_BUF_SIZE
  APP_DEFAULT_MEMPOOL_BUFFERS    = 65535 # 8192*4
  APP_DEFAULT_MEMPOOL_CACHE_SIZE =   256
  APP_DEFAULT_NIC_RX_RING_SIZE   =  1024
  # APP_DEFAULT_NIC_RX_PTHRESH = 8
  # APP_DEFAULT_NIC_RX_HTHRESH = 8
  # APP_DEFAULT_NIC_RX_WTHRESH = 4
  # APP_DEFAULT_NIC_RX_FREE_THRESH = 64
  # APP_DEFAULT_NIC_RX_DROP_EN = 0
  APP_DEFAULT_NIC_TX_RING_SIZE = 1024
  # APP_DEFAULT_NIC_TX_PTHRESH = 36
  # APP_DEFAULT_NIC_TX_HTHRESH = 0
  # APP_DEFAULT_NIC_TX_WTHRESH = 0
  # APP_DEFAULT_NIC_TX_FREE_THRESH = 0
  # APP_DEFAULT_NIC_TX_RS_THRESH = 0
  APP_DEFAULT_RING_RX_SIZE            = 16384 # 1024
  APP_DEFAULT_RING_TX_SIZE            = 16384 # 1024
  APP_DEFAULT_BURST_SIZE_IO_RX_READ   =   144
  APP_DEFAULT_BURST_SIZE_IO_RX_WRITE  =   144
  APP_DEFAULT_BURST_SIZE_IO_TX_READ   =   144
  APP_DEFAULT_BURST_SIZE_IO_TX_WRITE  =   144
  APP_DEFAULT_BURST_SIZE_WORKER_READ  =   144
  APP_DEFAULT_BURST_SIZE_WORKER_WRITE =   144
  APP_DEFAULT_IO_RX_LB_POS            =    29
end
