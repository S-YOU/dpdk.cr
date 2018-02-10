lib LibDpdk
  $rte_table_array_ops : RteTableOps

  struct RteTableArrayKey
    pos : Uint32T
  end

  struct RteTableArrayParams
    n_entries : Uint32T
    offset : Uint32T
  end
end
