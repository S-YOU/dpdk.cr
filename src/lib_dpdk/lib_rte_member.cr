lib LibDpdk
  alias MemberSetT = Uint16T
  enum RteMemberSetsumType
    RteMemberTypeHt  = 0
    RteMemberTypeVbf = 1
    RteMemberNumType = 2
  end
  enum RteMemberSigCompareFunction
    RteMemberCompareScalar = 0
    RteMemberCompareAvx2   = 1
    RteMemberCompareNum    = 2
  end
  fun rte_member_add(setsum : RteMemberSetsum*, key : Void*, set_id : MemberSetT) : LibC::Int
  fun rte_member_create(params : RteMemberParameters*) : RteMemberSetsum*
  fun rte_member_delete(setsum : RteMemberSetsum*, key : Void*, set_id : MemberSetT) : LibC::Int
  fun rte_member_find_existing(name : LibC::Char*) : RteMemberSetsum*
  fun rte_member_free(setsum : RteMemberSetsum*)
  fun rte_member_lookup(setsum : RteMemberSetsum*, key : Void*, set_id : MemberSetT*) : LibC::Int
  fun rte_member_lookup_bulk(setsum : RteMemberSetsum*, keys : Void**, num_keys : Uint32T, set_ids : MemberSetT*) : LibC::Int
  fun rte_member_lookup_multi(setsum : RteMemberSetsum*, key : Void*, max_match_per_key : Uint32T, set_id : MemberSetT*) : LibC::Int
  fun rte_member_lookup_multi_bulk(setsum : RteMemberSetsum*, keys : Void**, num_keys : Uint32T, max_match_per_key : Uint32T, match_count : Uint32T*, set_ids : MemberSetT*) : LibC::Int
  fun rte_member_reset(setsum : RteMemberSetsum*)

  struct RteMemberParameters
    name : LibC::Char*
    type : RteMemberSetsumType
    is_cache : Uint8T
    num_keys : Uint32T
    key_len : Uint32T
    num_set : Uint32T
    false_positive_rate : LibC::Float
    prim_hash_seed : Uint32T
    sec_hash_seed : Uint32T
    socket_id : LibC::Int
  end

  struct RteMemberSetsum
    type : RteMemberSetsumType
    key_len : Uint32T
    prim_hash_seed : Uint32T
    sec_hash_seed : Uint32T
    bucket_cnt : Uint32T
    bucket_mask : Uint32T
    sig_cmp_fn : RteMemberSigCompareFunction
    cache : Uint8T
    num_set : Uint32T
    bits : Uint32T
    bit_mask : Uint32T
    num_hashes : Uint32T
    mul_shift : Uint32T
    div_shift : Uint32T
    table : Void*
    socket_id : Uint32T
    name : LibC::Char[32]
  end
end
