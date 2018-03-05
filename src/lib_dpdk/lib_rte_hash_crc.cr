lib LibDpdk
  fun rte_hash_crc(data : Void*, data_len : Uint32T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_1byte(data : Uint8T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_2byte(data : Uint16T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_4byte(data : Uint32T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_8byte(data : Uint64T, init_val : Uint32T) : Uint32T
  fun rte_hash_crc_init_alg
  fun rte_hash_crc_set_alg(alg : Uint8T)
end
