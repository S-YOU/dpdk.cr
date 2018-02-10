require "../lib_dpdk"

class Dpdk
  # copy fixture to a packet
  private macro init_packet(mbuf, fixture, size, packet_type = 0)
    {{mbuf}} = mbuf = rte_pktmbuf_alloc(pool)
    Intrinsics.memcpy(rte_pktmbuf_mtod(mbuf), LibDpdk.{{fixture}}.as(Void*), LibDpdk.{{fixture}}_size, 0_u32, false)
    mbuf.value.pkt_len = mbuf.value.data_len = {{size}}
    mbuf.value.packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 | {{packet_type}}
    mbuf.value.nb_segs = 1_u16
    mbuf.value.next = NULL
  end

  # set length fields of a packet
  macro set_lengths(pkt, pkt_size, *args)
    {% for arg in args %}
      {{arg}}({{pkt}}, {{pkt_size}})
    {% end %}
  end

  # set checksums fields of a packet
  macro set_checksums(pkt, *args)
    {% for arg in args %}
      {{arg}}({{pkt}})
    {% end %}
  end

  ETHER_SZ            = 14
  IP_SZ               = 20
  UDP_SZ              =  8
  GTP_SZ              =  8
  ETHER_IP_UDP_GTP_SZ = ETHER_SZ + IP_SZ + UDP_SZ + GTP_SZ

  GTPU_LEN_OFFSET    = 0x2c
  TEID_OFFSET        = 0x2e
  GTPU_SRC_IP_OFFSET = TEID_OFFSET + 4 * 4
  GTPU_DST_IP_OFFSET = TEID_OFFSET + 5 * 4

  # set ip length
  macro ip_len(pkt, pkt_size)
    ({{pkt}} + 0x10).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_SZ)
  end

  # set ip checksum
  macro ip_checksum(pkt)
    ({{pkt}} + 0x18).as(UInt16*).value = 0_u16
    ({{pkt}} + 0x18).as(UInt16*).value = checksum({{pkt}} + ETHER_SZ, IP_SZ)
  end

  # set ip.udp length
  macro udp_len(pkt, pkt_size)
    ({{pkt}} + 0x26).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_SZ - IP_SZ)
  end

  # set ip.udp.gtp length
  macro gtp_len(pkt, pkt_size)
    ({{pkt}} + 0x2c).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_IP_UDP_GTP_SZ)
  end

  # set ip.udp.gtp.ip length
  macro gtp_ip_len(pkt, pkt_size)
    ({{pkt}} + 0x34).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_IP_UDP_GTP_SZ)
  end

  # set gtp_ip checksum
  macro gtp_ip_checksum(pkt)
    ({{pkt}} + 0x3c).as(UInt16*).value = 0_u16
    ({{pkt}} + 0x3c).as(UInt16*).value = checksum({{pkt}} + ETHER_IP_UDP_GTP_SZ, IP_SZ)
  end

  # calculate checksum
  macro checksum(pkt, size)
    acc = 0_u32
    start = ({{pkt}}).as(UInt16*)
    ({{size}} / 2).times do |i|
      acc += (start + i).value
      acc -= 0xffff if acc > 0xffff
    end
    (~acc).to_u16
  end
end
