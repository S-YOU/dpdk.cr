lib LibDpdk
  struct ArpHdr
    arp_hrd : Uint16T
    arp_pro : Uint16T
    arp_hln : Uint8T
    arp_pln : Uint8T
    arp_op : Uint16T
    arp_data : ArpIpv4
  end

  struct ArpIpv4
    arp_sha : EtherAddr
    arp_sip : Uint32T
    arp_tha : EtherAddr
    arp_tip : Uint32T
  end
end
