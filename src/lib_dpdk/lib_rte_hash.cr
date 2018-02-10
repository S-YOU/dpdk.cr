lib LibDpdk
  alias HashSigT = Uint32T
  alias RteHash = Void
  alias RteHashCmpEqT = (Void*, Void*, LibC::Int -> LibC::Int)
  alias RteHashFunction = (Void*, Uint32T, Uint32T -> Uint32T)
  fun rte_hash_add_key(h : RteHash*, key : Void*) : Int32T
  fun rte_hash_add_key_data(h : RteHash*, key : Void*, data : Void*) : LibC::Int
  fun rte_hash_add_key_with_hash(h : RteHash*, key : Void*, sig : HashSigT) : Int32T
  fun rte_hash_add_key_with_hash_data(h : RteHash*, key : Void*, sig : HashSigT, data : Void*) : Int32T
  fun rte_hash_create(params : RteHashParameters*) : RteHash*
  fun rte_hash_del_key(h : RteHash*, key : Void*) : Int32T
  fun rte_hash_del_key_with_hash(h : RteHash*, key : Void*, sig : HashSigT) : Int32T
  fun rte_hash_find_existing(name : LibC::Char*) : RteHash*
  fun rte_hash_free(h : RteHash*)
  fun rte_hash_get_key_with_position(h : RteHash*, position : Int32T, key : Void**) : LibC::Int
  fun rte_hash_hash(h : RteHash*, key : Void*) : HashSigT
  fun rte_hash_iterate(h : RteHash*, key : Void**, data : Void**, next : Uint32T*) : Int32T
  fun rte_hash_lookup(h : RteHash*, key : Void*) : Int32T
  fun rte_hash_lookup_bulk(h : RteHash*, keys : Void**, num_keys : Uint32T, positions : Int32T*) : LibC::Int
  fun rte_hash_lookup_bulk_data(h : RteHash*, keys : Void**, num_keys : Uint32T, hit_mask : Uint64T*, data : Void**) : LibC::Int
  fun rte_hash_lookup_data(h : RteHash*, key : Void*, data : Void**) : LibC::Int
  fun rte_hash_lookup_with_hash(h : RteHash*, key : Void*, sig : HashSigT) : Int32T
  fun rte_hash_lookup_with_hash_data(h : RteHash*, key : Void*, sig : HashSigT, data : Void**) : LibC::Int
  fun rte_hash_reset(h : RteHash*)
  fun rte_hash_set_cmp_func(h : RteHash*, func : RteHashCmpEqT)

  struct RteHashParameters
    name : LibC::Char*
    entries : Uint32T
    reserved : Uint32T
    key_len : Uint32T
    hash_func : RteHashFunction
    hash_func_init_val : Uint32T
    socket_id : LibC::Int
    extra_flag : Uint8T
  end
end
