lib LibDpdk
  enum RteNetCrcAlg
    RteNetCrcScalar = 0
    RteNetCrcSse42  = 1
    RteNetCrcNeon   = 2
  end
  enum RteNetCrcType
    RteNetCrc16Ccitt = 0
    RteNetCrc32Eth   = 1
    RteNetCrcReqs    = 2
  end
  fun rte_net_crc_calc(data : Void*, data_len : Uint32T, type : RteNetCrcType) : Uint32T
  fun rte_net_crc_set_alg(alg : RteNetCrcAlg)
end
