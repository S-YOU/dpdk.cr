lib LibDpdk
  alias EfdValueT = Uint8T
  alias RteEfdTable = Void
  fun rte_efd_create(name : LibC::Char*, max_num_rules : Uint32T, key_len : Uint32T, online_cpu_socket_bitmask : Uint8T, offline_cpu_socket : Uint8T) : RteEfdTable*
  fun rte_efd_delete(table : RteEfdTable*, socket_id : LibC::UInt, key : Void*, prev_value : EfdValueT*) : LibC::Int
  fun rte_efd_find_existing(name : LibC::Char*) : RteEfdTable*
  fun rte_efd_free(table : RteEfdTable*)
  fun rte_efd_lookup(table : RteEfdTable*, socket_id : LibC::UInt, key : Void*) : EfdValueT
  fun rte_efd_lookup_bulk(table : RteEfdTable*, socket_id : LibC::UInt, num_keys : LibC::Int, key_list : Void**, value_list : EfdValueT*)
  fun rte_efd_update(table : RteEfdTable*, socket_id : LibC::UInt, key : Void*, value : EfdValueT) : LibC::Int
end
