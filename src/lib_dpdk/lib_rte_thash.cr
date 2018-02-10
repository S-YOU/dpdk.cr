lib LibDpdk
  $rte_thash_ipv6_bswap_mask : LibC::Int
  fun rte_convert_rss_key(orig : Uint32T*, targ : Uint32T*, len : LibC::Int)
  fun rte_softrss(input_tuple : Uint32T*, input_len : Uint32T, rss_key : Uint8T*) : Uint32T
  fun rte_softrss_be(input_tuple : Uint32T*, input_len : Uint32T, rss_key : Uint8T*) : Uint32T
  fun rte_thash_load_v6_addrs(orig : Ipv6Hdr*, targ : RteThashTuple*)

  struct RteIpv4Tuple
    src_addr : Uint32T
    dst_addr : Uint32T
  end

  struct RteIpv6Tuple
    src_addr : Uint8T[16]
    dst_addr : Uint8T[16]
  end

  union RteThashTuple
    v4 : RteIpv4Tuple
    v6 : RteIpv6Tuple
  end
end
