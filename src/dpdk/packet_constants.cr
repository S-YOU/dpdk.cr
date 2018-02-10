module Constants
  ETH_TYPE_OFS = 0x0c

  IP_VH_OFS    = 0x0e
  IP_TTL_OFS   = 0x16
  IP_PROTO_OFS = 0x17
  IP_SRC_OFS   = 0x1a
  IP_DST_OFS   = 0x1e
  IP_CHECKSUM  = 0x18

  IPV6_PROTO_OFS =      0x14
  IPV6_SRC_OFS   =      0x16
  IPV6_DST_OFS   =      0x26
  IPV6_NDP_SOL   = 0x2ff_u64

  ARP_TYPE_OFS    = 0x15
  ARP_SRC_MAC_OFS = 0x16
  ARP_SRC_IP_OFS  = 0x1c
  ARP_DST_IP_OFS  = 0x26
  ARP_REQ         = 1_u8
  ARP_REPLY       = 2_u8

  ICMP_TYPE_OFS = 0x22
  ICMP_REQ      = 8_u8
  ICMP_REPLY    = 0_u8
  ICMP_CHECKSUM = 0x24

  UDP_OFS          = 0x22
  UDP_CHECKSUM_OFS = 0x28
  # UDP_SRC_PORT_OFS = 0x22
  # UDP_DST_PORT_OFS = 0x24

  GRE_OFS        = 0x22
  GRE_PROTO_OFS  = 0x24
  GRE_IP_SRC_OFS = 0x32
  GRE_IP_DST_OFS = 0x36

  # GTPU_MSG_OFS     = 0x2b
  GTPU_VER_OFS     = 0x2a
  GTPU_LEN_OFS     = 0x2c
  GTPU_PAYLOAD_OFS = 0x32
  GTPU_TEID_OFS    = 0x2e
  GTPU_SRC_IP_OFS  = 0x3e
  GTPU_DST_IP_OFS  = 0x42
  # GTPU_PORT        = 2152
  GTPU_SRC_DST_PORT = 0x6808_6808_u32
  GTPV1_TPDU        =      0xff30_u16

  ETHER_SZ = 14
  IP_SZ    = 20
  GRE_SZ   =  4
  UDP_SZ   =  8
  GTP_SZ   =  8
  IPV6_SZ  = 40
  PAD_SZ   = 12

  IP_UDP_GTP_SZ = ETHER_SZ + IP_SZ + UDP_SZ + GTP_SZ
  IP_OPT_GRE_SZ = ETHER_SZ + IP_SZ + PAD_SZ + GRE_SZ
  IP_GRE_SZ     = ETHER_SZ + IP_SZ + GRE_SZ

  # ETHER_TYPE Big Endian
  ETH_TYPE_IPV4 = 0x0008_u16 # IPv4 Protocol
  ETH_TYPE_IPV6 = 0xDD86_u16 # IPv6 Protocol
  ETH_TYPE_ARP  = 0x0608_u16 # Arp Protocol
  ETH_TYPE_VLAN = 0x0081_u16 # IEEE 802.1Q VLAN tagging
  ETH_TYPE_LLDP = 0xCC88_u16 # LLDP Protocol
end
