@[Link(ldflags: "-lrte_lpm")]
lib LibDpdk
  struct RteLpm
    name : LibC::Char[32]
    max_rules : Uint32T
    number_tbl8s : Uint32T
    rule_info : RteLpmRuleInfo[32]
    tbl24 : RteLpmTblEntry[16777216]
    tbl8 : RteLpmTblEntry*
    rules_tbl : RteLpmRule*
  end

  struct RteLpmConfig
    max_rules : Uint32T
    number_tbl8s : Uint32T
    flags : LibC::Int
  end

  struct RteLpmRule
    ip : Uint32T
    next_hop : Uint32T
  end

  struct RteLpmRuleInfo
    used_rules : Uint32T
    first_rule : Uint32T
  end

  struct RteLpmTblEntry
    next_hop : Uint32T
    valid : Uint32T
    valid_group : Uint32T
    depth : Uint32T
  end

  fun rte_lpm_add(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  # fun rte_lpm_add_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  # fun rte_lpm_add_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T, next_hop : Uint8T) : LibC::Int
  fun rte_lpm_create(name : LibC::Char*, socket_id : LibC::Int, config : RteLpmConfig*) : RteLpm*
  # fun rte_lpm_create_v1604(name : LibC::Char*, socket_id : LibC::Int, config : RteLpmConfig*) : RteLpm*
  # fun rte_lpm_create_v20(name : LibC::Char*, socket_id : LibC::Int, max_rules : LibC::Int, flags : LibC::Int) : RteLpmV20*
  # fun rte_lpm_delete(lpm : RteLpm*, ip : Uint32T, depth : Uint8T) : LibC::Int
  # fun rte_lpm_delete_all(lpm : RteLpm*)
  # fun rte_lpm_delete_all_v1604(lpm : RteLpm*)
  # fun rte_lpm_delete_all_v20(lpm : RteLpmV20*)
  # fun rte_lpm_delete_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T) : LibC::Int
  # fun rte_lpm_delete_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T) : LibC::Int
  # fun rte_lpm_find_existing(name : LibC::Char*) : RteLpm*
  # fun rte_lpm_find_existing_v1604(name : LibC::Char*) : RteLpm*
  # fun rte_lpm_find_existing_v20(name : LibC::Char*) : RteLpmV20*
  # fun rte_lpm_free(lpm : RteLpm*)
  # fun rte_lpm_free_v1604(lpm : RteLpm*)
  # fun rte_lpm_free_v20(lpm : RteLpmV20*)
  # fun rte_lpm_is_rule_present(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  # fun rte_lpm_is_rule_present_v1604(lpm : RteLpm*, ip : Uint32T, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  # fun rte_lpm_is_rule_present_v20(lpm : RteLpmV20*, ip : Uint32T, depth : Uint8T, next_hop : Uint8T*) : LibC::Int
  fun rte_lpm_lookup(lpm : RteLpm*, ip : Uint32T, next_hop : Uint32T*) : LibC::Int
  # fun rte_lpm_lookup_bulk_func(lpm : RteLpm*, ips : Uint32T*, next_hops : Uint32T*, n : LibC::UInt) : LibC::Int
  # fun rte_lpm_lookupx4(lpm : RteLpm*, ip : XmmT, hop : Uint32T[4], defv : Uint32T)
end
