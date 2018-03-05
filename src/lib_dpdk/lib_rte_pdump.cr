lib LibDpdk
  enum RtePdumpSocktype
    RtePdumpSocketServer = 1
    RtePdumpSocketClient = 2
  end
  fun rte_pdump_disable(port : Uint8T, queue : Uint16T, flags : Uint32T) : LibC::Int
  fun rte_pdump_disable_by_deviceid(device_id : LibC::Char*, queue : Uint16T, flags : Uint32T) : LibC::Int
  fun rte_pdump_enable(port : Uint8T, queue : Uint16T, flags : Uint32T, ring : RteRing*, mp : RteMempool*, filter : Void*) : LibC::Int
  fun rte_pdump_enable_by_deviceid(device_id : LibC::Char*, queue : Uint16T, flags : Uint32T, ring : RteRing*, mp : RteMempool*, filter : Void*) : LibC::Int
  fun rte_pdump_init(path : LibC::Char*) : LibC::Int
  fun rte_pdump_set_socket_dir(path : LibC::Char*, type : RtePdumpSocktype) : LibC::Int
  fun rte_pdump_uninit : LibC::Int
end
