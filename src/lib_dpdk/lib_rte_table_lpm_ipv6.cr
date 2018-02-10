lib LibDpdk
  $rte_table_lpm_ipv6_ops : RteTableOps

  struct RteTableLpmIpv6Key
    ip : Uint8T[16]
    depth : Uint8T
  end

  struct RteTableLpmIpv6Params
    name : LibC::Char*
    n_rules : Uint32T
    number_tbl8s : Uint32T
    entry_unique_size : Uint32T
    offset : Uint32T
  end
end
