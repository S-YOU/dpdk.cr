class Dpdk
  # fill a new mbuf with fixture
  private macro init_packet(fixture, size, packet_type = RTE_PTYPE_L3_IPV4)
    %mbuf = rte_pktmbuf_alloc(pool)
    memcpy(rte_pktmbuf_mtod(%mbuf), LibDpdk.{{fixture}}.as(Void*), LibDpdk.{{fixture}}_size)
    %mbuf.value.pkt_len = {{size}}
    %mbuf.value.data_len = {{size}}.to_u16
    %mbuf.value.packet_type = RTE_PTYPE_L2_ETHER | {{packet_type}}
    %mbuf
  end

  # set mbuf packet lengths
  private macro set_pkt_len(mbuf, pkt_len)
    {{mbuf}}.value.pkt_len = {{pkt_len}}
    {{mbuf}}.value.data_len = {{pkt_len}}.to_u16
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

  # set ip length
  macro ip_len(pkt, pkt_size)
    ({{pkt}} + 0x10).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_SZ)
  end

  # set ip length
  macro ipv6_len(pkt, pkt_size)
    ({{pkt}} + 0x12).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_SZ - IPV6_SZ)
  end

  # set ip checksum
  macro ip_checksum(pkt)
    ({{pkt}} + IP_CHECKSUM).as(UInt16*).value = 0_u16
    ({{pkt}} + IP_CHECKSUM).as(UInt16*).value = checksum({{pkt}} + ETHER_SZ, IP_SZ)
  end

  # :nodoc:
  macro ip_opt_checksum(pkt)
    ({{pkt}} + IP_CHECKSUM).as(UInt16*).value = 0_u16
    ({{pkt}} + IP_CHECKSUM).as(UInt16*).value = checksum({{pkt}} + ETHER_SZ, IP_SZ + PAD_SZ)
  end

  # set ip.udp length
  macro udp_len(pkt, pkt_size)
    ({{pkt}} + 0x26).as(UInt16*).value = bswap16({{pkt_size}} - ETHER_SZ - IP_SZ)
  end

  # set ip.udp.gtp length
  macro gtp_len(pkt, pkt_size)
    ({{pkt}} + 0x2c).as(UInt16*).value = bswap16({{pkt_size}} - IP_UDP_GTP_SZ)
  end

  # set ip.udp.gtp.ip length
  macro gtp_ip_len(pkt, pkt_size)
    ({{pkt}} + 0x34).as(UInt16*).value = bswap16({{pkt_size}} - IP_UDP_GTP_SZ)
  end

  # set ip.gre.ip length
  macro gre_ip_len(pkt, pkt_size)
    ({{pkt}} + 0x28).as(UInt16*).value = bswap16({{pkt_size}} - IP_GRE_SZ)
  end

  # set ip.gre.ipv6 length
  macro gre_ipv6_len(pkt, pkt_size)
    ({{pkt}} + 0x2a).as(UInt16*).value = bswap16({{pkt_size}} - IP_GRE_SZ - IPV6_SZ)
  end

  # set ip.udp.gtp.ipv6 length
  macro gtp_ipv6_len(pkt, pkt_size)
    ({{pkt}} + 0x36).as(UInt16*).value = bswap16({{pkt_size}} - IP_UDP_GTP_SZ - IPV6_SZ)
  end

  # :nodoc:
  macro ip_opt_gre_ipv6_len(pkt, pkt_size)
    ({{pkt}} + 0x36).as(UInt16*).value = bswap16({{pkt_size}} - IP_OPT_GRE_SZ - IPV6_SZ)
  end

  # set gtp_ip checksum
  macro gtp_ip_checksum(pkt)
    ({{pkt}} + 0x3c).as(UInt16*).value = 0_u16
    ({{pkt}} + 0x3c).as(UInt16*).value = checksum({{pkt}} + IP_UDP_GTP_SZ, IP_SZ)
  end

  # set gre_ip checksum
  macro gre_ip_checksum(pkt)
    ({{pkt}} + 0x30).as(UInt16*).value = 0_u16
    ({{pkt}} + 0x30).as(UInt16*).value = checksum({{pkt}} + IP_GRE_SZ, IP_SZ)
  end

  # calculate checksum
  macro checksum(orig_pkt, orig_size)
    %b = ({{orig_pkt}}).as(UInt64*)
    %size = {{orig_size}}
    %sum = 0_u64

    while %size >= 8
      %s1 = %b.value
      %sum += %s1
      %sum += 1 if %sum < %s1
      %size -= 8
      %b += 1
    end

    %b = %b.as(UInt32*)
    if %size & 4 != 0
      %s2 = %b.value
      %sum += %s2
      %sum += 1 if %sum < %s2
      %b += 1
    end

    %b = %b.as(UInt16*)
    if %size & 2 != 0
      %s3 = %b.value
      %sum += %s3
      %sum += 1 if %sum < %s3
      %b += 1
    end

    %b = %b.as(UInt8*)
    if %size & 1 != 0
      %s4 = %b.value
      %sum += %s4
      %sum += 1 if %sum < %s4
    end

    %t1 = %sum.to_u32
    %t2 = (%sum >> 32).to_u32
    %t1 += %t2
    %t1 += 1 if %t1 < %t2
    %t3 = %t1.to_u16
    %t4 = (%t1 >> 16).to_u16
    %t3 += %t4
    %t3 += 1 if %t3 < %t4

    ~%t3
  end
end
