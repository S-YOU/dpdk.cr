lib LibDpdk
  $rte_table_hash_cuckoo_dosig_ops : RteTableOps
  $rte_table_hash_ext_dosig_ops : RteTableOps
  $rte_table_hash_ext_ops : RteTableOps
  $rte_table_hash_key16_ext_dosig_ops : RteTableOps
  $rte_table_hash_key16_ext_ops : RteTableOps
  $rte_table_hash_key16_lru_dosig_ops : RteTableOps
  $rte_table_hash_key16_lru_ops : RteTableOps
  $rte_table_hash_key32_ext_ops : RteTableOps
  $rte_table_hash_key32_lru_ops : RteTableOps
  $rte_table_hash_key8_ext_dosig_ops : RteTableOps
  $rte_table_hash_key8_ext_ops : RteTableOps
  $rte_table_hash_key8_lru_dosig_ops : RteTableOps
  $rte_table_hash_key8_lru_ops : RteTableOps
  $rte_table_hash_lru_dosig_ops : RteTableOps
  $rte_table_hash_lru_ops : RteTableOps
  alias RteTableHashOpHash = (Void*, Uint32T, Uint64T -> Uint64T)

  struct RteTableHashCuckooParams
    key_size : Uint32T
    n_keys : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint32T
    signature_offset : Uint32T
    key_offset : Uint32T
    name : LibC::Char*
  end

  struct RteTableHashExtParams
    key_size : Uint32T
    n_keys : Uint32T
    n_buckets : Uint32T
    n_buckets_ext : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
  end

  struct RteTableHashKey16ExtParams
    n_entries : Uint32T
    n_entries_ext : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
    key_mask : Uint8T*
  end

  struct RteTableHashKey16LruParams
    n_entries : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
    key_mask : Uint8T*
  end

  struct RteTableHashKey32ExtParams
    n_entries : Uint32T
    n_entries_ext : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
  end

  struct RteTableHashKey32LruParams
    n_entries : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
  end

  struct RteTableHashKey8ExtParams
    n_entries : Uint32T
    n_entries_ext : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
    key_mask : Uint8T*
  end

  struct RteTableHashKey8LruParams
    n_entries : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
    key_mask : Uint8T*
  end

  struct RteTableHashLruParams
    key_size : Uint32T
    n_keys : Uint32T
    n_buckets : Uint32T
    f_hash : RteTableHashOpHash
    seed : Uint64T
    signature_offset : Uint32T
    key_offset : Uint32T
  end
end
