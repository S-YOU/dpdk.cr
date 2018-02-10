lib LibDpdk
  fun rte_net_get_ptype(m : RteMbuf*, hdr_lens : RteNetHdrLens*, layers : Uint32T) : Uint32T
  fun rte_net_intel_cksum_flags_prepare(m : RteMbuf*, ol_flags : Uint64T) : LibC::Int
  fun rte_net_intel_cksum_prepare(m : RteMbuf*) : LibC::Int

  struct RteNetHdrLens
    l2_len : Uint8T
    l3_len : Uint8T
    l4_len : Uint8T
    tunnel_len : Uint8T
    inner_l2_len : Uint8T
    inner_l3_len : Uint8T
    inner_l4_len : Uint8T
  end
end
