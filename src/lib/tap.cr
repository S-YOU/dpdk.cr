module Tap
  SELF_IP     = 0_u32
  LOOPBACK_IP = 0_u32
  NEXT_HOP    = 0_u32
  SELF_IPV6   = Pointer(UInt64).null
  ROUTES      = [] of UInt32

  @tap_host_fd = 0
  @tap_mirror = false

  private macro tap_rx_to_ring
    pkt = rte_pktmbuf_mtod(mbuf).as(UInt8*)

    nb_rx = tap_read(@tap_host_fd, pkt, ETHER_MTU).to_u16
    next if nb_rx == 0

    mbuf.value.pkt_len = nb_rx
    mbuf.value.data_len = nb_rx
    mbuf.value.packet_type = RTE_PTYPE_L2_ETHER
    pkts[0] = mbuf
    nb_tx = rte_ring_enqueue_burst(ring, pkts, 1_u16, nil)
    mbuf = rte_pktmbuf_alloc(pool) if nb_tx == 1
  end

  private macro valid_write_to_host?
    ((arp? && arp_to_me?) || (ipv4? && ipv4_to_me? && (icmp? || (tcp? && bgp?))) || (ipv6? && icmpv6?))
  end

  private macro write_to_tap_host
    if @tap_host_fd > 0
      LibC.write(@tap_host_fd, pkt, pkt_len)
    end
  end

  private macro write_to_tap(fd)
    if @tap_mirror && tap_{{fd}}
      LibC.write(tap_{{fd}}, pkt, pkt_len)
    end
  end

  private macro setup_tap_host
    if @tap_host_fd < 0
      @tap_host_fd = tap_create("tap_host", mac, ETHER_MAX_LEN, 1)
      tap_setup_ip("tap_host", SELF_IP, LOOPBACK_IP, SELF_IPV6, ROUTES.to_unsafe, ROUTES.size, NEXT_HOP)
    end
  end

  private macro setup_tap_mirror(*args)
    if @tap_mirror
      {% for arg in args %}
        tap_{{arg}} = tap_create("tap_{{arg}}", 0, ETHER_MAX_LEN, 0)
      {% end %}
    end
  end

  private macro clone_to_tap_mbufs(name)
    clone_to_mbufs {{name}} if @tap_mirror
  end

  private macro copy_to_tap_mbufs(name)
    copy_to_mbufs {{name}} if @tap_mirror
  end

  private macro clone_to_tap_host_mbufs
    clone_to_mbufs host if @tap_host_fd > 0
  end

  private macro copy_to_tap_host_mbufs
    copy_to_mbufs host if @tap_host_fd > 0
  end
end
