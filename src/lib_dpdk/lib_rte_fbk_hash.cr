lib LibDpdk
  alias RteFbkHashFn = (Uint32T, Uint32T -> Uint32T)
  fun rte_fbk_hash_add_key(ht : RteFbkHashTable*, key : Uint32T, value : Uint16T) : LibC::Int
  fun rte_fbk_hash_add_key_with_bucket(ht : RteFbkHashTable*, key : Uint32T, value : Uint16T, bucket : Uint32T) : LibC::Int
  fun rte_fbk_hash_clear_all(ht : RteFbkHashTable*)
  fun rte_fbk_hash_create(params : RteFbkHashParams*) : RteFbkHashTable*
  fun rte_fbk_hash_delete_key(ht : RteFbkHashTable*, key : Uint32T) : LibC::Int
  fun rte_fbk_hash_delete_key_with_bucket(ht : RteFbkHashTable*, key : Uint32T, bucket : Uint32T) : LibC::Int
  fun rte_fbk_hash_find_existing(name : LibC::Char*) : RteFbkHashTable*
  fun rte_fbk_hash_free(ht : RteFbkHashTable*)
  fun rte_fbk_hash_get_bucket(ht : RteFbkHashTable*, key : Uint32T) : Uint32T
  fun rte_fbk_hash_get_load_factor(ht : RteFbkHashTable*) : LibC::Double
  fun rte_fbk_hash_lookup(ht : RteFbkHashTable*, key : Uint32T) : LibC::Int
  fun rte_fbk_hash_lookup_with_bucket(ht : RteFbkHashTable*, key : Uint32T, bucket : Uint32T) : LibC::Int

  struct RteFbkHashEntryEntry
    is_entry : Uint16T
    value : Uint16T
    key : Uint32T
  end

  struct RteFbkHashParams
    name : LibC::Char*
    entries : Uint32T
    entries_per_bucket : Uint32T
    socket_id : LibC::Int
    hash_func : RteFbkHashFn
    init_val : Uint32T
  end

  struct RteFbkHashTable
    name : LibC::Char[32]
    entries : Uint32T
    entries_per_bucket : Uint32T
    used_entries : Uint32T
    bucket_mask : Uint32T
    bucket_shift : Uint32T
    hash_func : RteFbkHashFn
    init_val : Uint32T
    t : RteFbkHashEntry*
  end

  union RteFbkHashEntry
    whole_entry : Uint64T
    entry : RteFbkHashEntryEntry
  end
end
