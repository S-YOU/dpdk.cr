lib LibDpdk
  $rte_table_lpm_ops : RteTableOps

  struct RteTableLpmKey
    ip : Uint32T
    depth : Uint8T
  end

  struct RteTableLpmParams
    name : LibC::Char*
    n_rules : Uint32T
    number_tbl8s : Uint32T
    flags : LibC::Int
    entry_unique_size : Uint32T
    offset : Uint32T
  end
end
