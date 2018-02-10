module Packets
  private macro ether_type
    (pkt.u16(ETH_TYPE_OFS))
  end

  private macro gre?
    (pkt[IP_VH_OFS] == 0x45 && pkt[IP_PROTO_OFS] == IPPROTO_GRE)
  end

  private macro udp?
    (pkt[IP_VH_OFS] == 0x45 && pkt[IP_PROTO_OFS] == IPPROTO_UDP)
  end

  private macro tcp?
    (pkt[IP_VH_OFS] == 0x45 && pkt[IP_PROTO_OFS] == IPPROTO_TCP)
  end

  private macro bgp?
    (pkt.u16(0x22) == 0xb300 || pkt.u16(0x24) == 0xb300)
  end

  private macro icmp?
    (pkt[IP_PROTO_OFS] == IPPROTO_ICMP)
  end

  private macro icmp_req?
    (pkt[ICMP_TYPE_OFS] == ICMP_REQ)
  end

  private macro icmpv6?
    (pkt[IPV6_PROTO_OFS] == IPPROTO_ICMPV6)
  end

  private macro ipv4?
    (pkt.u16(ETH_TYPE_OFS) == 8)
  end

  private macro ipv4_from_me?
    ((pkt.u32(IP_SRC_OFS) == SELF_IP) || (pkt.u32(IP_SRC_OFS) == LOOPBACK_IP))
  end

  private macro ipv4_to_me?
    ((pkt.u32(IP_DST_OFS) == SELF_IP) || (pkt.u32(IP_DST_OFS) == LOOPBACK_IP))
  end

  private macro ipv6?
    (pkt.u16(ETH_TYPE_OFS) == ETH_TYPE_IPV6)
  end

  private macro ipv6_from_me?
    (pkt.u64(IPV6_SRC_OFS) == SELF_IPV6[0] && pkt.u64(IPV6_SRC_OFS + 8) == SELF_IPV6[1])
  end

  private macro ipv6_to_me?
    (pkt.u64(IPV6_DST_OFS) == SELF_IPV6[0] && pkt.u64(IPV6_DST_OFS + 8) == SELF_IPV6[1])
  end

  private macro ipv6_ndp?
    (pkt.u64(IPV6_DST_OFS) == IPV6_NDP_SOL)
  end

  private macro arp?
    (pkt.u16(ETH_TYPE_OFS) == ETH_TYPE_ARP)
  end

  private macro arp_req?
    pkt[ARP_TYPE_OFS] == ARP_REQ
  end

  private macro gtpu?
    (pkt.u32(UDP_OFS) == 0x6808_6808_u32)
  end

  private macro arp_from_me?
    ((pkt.u32(ARP_SRC_IP_OFS) == SELF_IP) || (pkt.u32(ARP_SRC_IP_OFS) == LOOPBACK_IP))
  end

  private macro arp_to_me?
    ((pkt.u32(ARP_DST_IP_OFS) == SELF_IP) || (pkt.u32(ARP_DST_IP_OFS) == LOOPBACK_IP))
  end

  private macro icmp_reply
    pkt[ICMP_TYPE_OFS] = ICMP_REPLY
    pkt.u16(ICMP_CHECKSUM, pkt.u16(ICMP_CHECKSUM) - 8_u16) # quick way
    # other headers
    ip_src = pkt.u32(IP_SRC_OFS)
    set_ipv4_header(SELF_IP, ip_src)
    set_checksums(pkt, ip_checksum)
    set_ether_header
  end

  private macro arp_reply
    pkt[ARP_TYPE_OFS] = ARP_REPLY
    pkt.u32(0x20, pkt.u32(0x16)) # copy sender MAC to target MAC
    pkt.u64(0x22, pkt.u64(0x18)) # copy sender to target, copy 8 bytes from offset 2
    pkt.u64(0x16, mac) # Set Sender MAC, extra 2 bytes
    pkt.u32(ARP_SRC_IP_OFS, SELF_IP) # Sender IP
    # other headers
    set_ether_header
  end

  MARKER_DROP = 1

  private macro drop_unsupported
    if nb_rx > 0
      %j = 0_u16
      nb_rx.times do |idx|
        if pkts[idx].value.userdata == MARKER_DROP
          pkts[idx].value.userdata = 0
          rte_pktmbuf_free(pkts[idx])
        else
          pkts[%j] = pkts[idx] if %j < idx
          %j += 1
        end
      end
      if %j < nb_rx
        # printf("unknown packets dropped: %hu\n", nb_rx - %j)
        nb_rx = %j
      end
    end
  end

  private macro alloc_mbufs(*args)
    {% for arg in args %}
      pkts_{{arg}} = uninitialized_ptr RteMbuf*[MAX_PKTS_BURST]
      nb_{{arg}} = 0
    {% end %}
  end

  private macro reset_indexes(*args)
    {% for arg in args %}
      nb_{{arg}} = 0
    {% end %}
  end

  private macro mark(marker)
    pkts[i].value.userdata = {{marker}}
  end

  private macro mark_drop
    pkts[i].value.userdata = MARKER_DROP
  end

  private macro mark_drop_and_next
    mark_drop
    next
  end

  private macro clone_to_mbufs(name)
    %mbuf = rte_pktmbuf_clone(pkts[i], pool)
    pkts_{{name}}[nb_{{name}}] = %mbuf
    nb_{{name}} += 1
  end

  private macro copy_to_mbufs(name)
    %mbuf = rte_pktmbuf_copy(pkts[i], pool)
    pkts_{{name}}[nb_{{name}}] = %mbuf
    nb_{{name}} += 1
  end

  private macro set_ether_header
    ether_addr_copy(pkt + 6, pkt)
    ether_addr_copy(pointerof(mac), pkt + 6) # No offloads?
  end

  private macro destroy_ether_header
    pkt.u64(0, 0_u64)
    pkt.u64(6, 0_u64)
  end

  private macro set_ipv4_header(src_ip, dst_ip)
    pkt.u32(IP_SRC_OFS, {{src_ip}})
    pkt.u32(IP_DST_OFS, {{dst_ip}})
  end

  private macro pass_through
    next
  end

  private macro each_packet
    nb_rx.times do |i|
      pkt = rte_pktmbuf_mtod(pkts[i]).as(UInt8*)
      pkt_len = pkts[i].value.pkt_len
      {{yield}}
    end
  end
end
