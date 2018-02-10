lib LibDpdk
  alias RteLpm6 = Void
  fun rte_lpm6_add(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  fun rte_lpm6_add_v1705(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint32T) : LibC::Int
  fun rte_lpm6_add_v20(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint8T) : LibC::Int
  fun rte_lpm6_create(name : LibC::Char*, socket_id : LibC::Int, config : RteLpm6Config*) : RteLpm6*
  fun rte_lpm6_delete(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T) : LibC::Int
  fun rte_lpm6_delete_all(lpm : RteLpm6*)
  fun rte_lpm6_delete_bulk_func(lpm : RteLpm6*, ips : Uint8T[16]*, depths : Uint8T*, n : LibC::UInt) : LibC::Int
  fun rte_lpm6_find_existing(name : LibC::Char*) : RteLpm6*
  fun rte_lpm6_free(lpm : RteLpm6*)
  fun rte_lpm6_is_rule_present(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm6_is_rule_present_v1705(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm6_is_rule_present_v20(lpm : RteLpm6*, ip : Uint8T*, depth : Uint8T, next_hop : Uint8T*) : LibC::Int
  fun rte_lpm6_lookup(lpm : RteLpm6*, ip : Uint8T*, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm6_lookup_bulk_func(lpm : RteLpm6*, ips : Uint8T[16]*, next_hops : Int32T*, n : LibC::UInt) : LibC::Int
  fun rte_lpm6_lookup_bulk_func_v1705(lpm : RteLpm6*, ips : Uint8T[16]*, next_hops : Int32T*, n : LibC::UInt) : LibC::Int
  fun rte_lpm6_lookup_bulk_func_v20(lpm : RteLpm6*, ips : Uint8T[16]*, next_hops : Int16T*, n : LibC::UInt) : LibC::Int
  fun rte_lpm6_lookup_v1705(lpm : RteLpm6*, ip : Uint8T*, next_hop : Uint32T*) : LibC::Int
  fun rte_lpm6_lookup_v20(lpm : RteLpm6*, ip : Uint8T*, next_hop : Uint8T*) : LibC::Int

  struct RteLpm6Config
    max_rules : Uint32T
    number_tbl8s : Uint32T
    flags : LibC::Int
  end
end
