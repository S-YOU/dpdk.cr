lib LibDpdk
  fun rte_ip_frag_free_death_row(dr : RteIpFragDeathRow*, prefetch : Uint32T)
  fun rte_ip_frag_table_create(bucket_num : Uint32T, bucket_entries : Uint32T, max_entries : Uint32T, max_cycles : Uint64T, socket_id : LibC::Int) : RteIpFragTbl*
  fun rte_ip_frag_table_destroy(tbl : RteIpFragTbl*)
  fun rte_ip_frag_table_statistics_dump(f : File*, tbl : RteIpFragTbl*)
  fun rte_ipv4_frag_pkt_is_fragmented(hdr : Ipv4Hdr*) : LibC::Int
  fun rte_ipv4_frag_reassemble_packet(tbl : RteIpFragTbl*, dr : RteIpFragDeathRow*, mb : RteMbuf*, tms : Uint64T, ip_hdr : Ipv4Hdr*) : RteMbuf*
  fun rte_ipv4_fragment_packet(pkt_in : RteMbuf*, pkts_out : RteMbuf**, nb_pkts_out : Uint16T, mtu_size : Uint16T, pool_direct : RteMempool*, pool_indirect : RteMempool*) : Int32T
  fun rte_ipv6_frag_get_ipv6_fragment_header(hdr : Ipv6Hdr*) : Ipv6ExtensionFragment*
  fun rte_ipv6_frag_reassemble_packet(tbl : RteIpFragTbl*, dr : RteIpFragDeathRow*, mb : RteMbuf*, tms : Uint64T, ip_hdr : Ipv6Hdr*, frag_hdr : Ipv6ExtensionFragment*) : RteMbuf*
  fun rte_ipv6_fragment_packet(pkt_in : RteMbuf*, pkts_out : RteMbuf**, nb_pkts_out : Uint16T, mtu_size : Uint16T, pool_direct : RteMempool*, pool_indirect : RteMempool*) : Int32T

  struct IpFrag
    ofs : Uint16T
    len : Uint16T
    mb : RteMbuf*
  end

  struct IpFragKey
    src_dst : Uint64T[4]
    id : Uint32T
    key_len : Uint32T
  end

  struct IpFragPkt
    lru : IpFragPktLru
    key : IpFragKey
    start : Uint64T
    total_size : Uint32T
    frag_size : Uint32T
    last_idx : Uint32T
    frags : IpFrag[4]
  end

  struct IpFragPktLru
    tqe_next : IpFragPkt*
    tqe_prev : IpFragPkt**
  end

  struct IpFragTblStat
    find_num : Uint64T
    add_num : Uint64T
    del_num : Uint64T
    reuse_num : Uint64T
    fail_total : Uint64T
    fail_nospace : Uint64T
  end

  struct IpPktList
    tqh_first : IpFragPkt*
    tqh_last : IpFragPkt**
  end

  struct Ipv6ExtensionFragment
    next_header : Uint8T
    reserved : Uint8T
    frag_data : Uint16T
    id : Uint32T
  end

  struct RteIpFragDeathRow
    cnt : Uint32T
    row : RteMbuf*[160]
  end

  struct RteIpFragTbl
    max_cycles : Uint64T
    entry_mask : Uint32T
    max_entries : Uint32T
    use_entries : Uint32T
    bucket_entries : Uint32T
    nb_entries : Uint32T
    nb_buckets : Uint32T
    last : IpFragPkt*
    lru : IpPktList
    stat : IpFragTblStat
    pkt : IpFragPkt[0]
  end
end
