lib LibDpdk
  $rte_table_hash_cuckoo_ops : RteTableOps
  $rte_table_hash_ext_ops : RteTableOps
  $rte_table_hash_key16_ext_ops : RteTableOps
  $rte_table_hash_key16_lru_ops : RteTableOps
  $rte_table_hash_key32_ext_ops : RteTableOps
  $rte_table_hash_key32_lru_ops : RteTableOps
  $rte_table_hash_key8_ext_ops : RteTableOps
  $rte_table_hash_key8_lru_ops : RteTableOps
  $rte_table_hash_lru_ops : RteTableOps
  alias RteTableHashOpHash = (Void*, Void*, Uint32T, Uint64T -> Uint64T)

  struct RteTableHashParams
    name : LibC::Char*
    key_size : Uint32T
    key_offset : Uint32T
    key_mask : Uint8T*
    n_keys : Uint32T
    n_buckets : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
  end
end
