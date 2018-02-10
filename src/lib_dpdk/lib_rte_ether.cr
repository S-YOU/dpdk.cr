lib LibDpdk
  fun ether_addr_copy(ea_from : EtherAddr*, ea_to : EtherAddr*)
  fun ether_format_addr(buf : LibC::Char*, size : Uint16T, eth_addr : EtherAddr*)

  struct EtherHdr
    d_addr : EtherAddr
    s_addr : EtherAddr
    ether_type : Uint16T
  end
end
