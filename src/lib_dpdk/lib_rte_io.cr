lib LibDpdk
  fun rte_read16(addr : Void*) : Uint16T
  fun rte_read16_relaxed(addr : Void*) : Uint16T
  fun rte_read32(addr : Void*) : Uint32T
  fun rte_read32_relaxed(addr : Void*) : Uint32T
  fun rte_read64(addr : Void*) : Uint64T
  fun rte_read64_relaxed(addr : Void*) : Uint64T
  fun rte_read8(addr : Void*) : Uint8T
  fun rte_read8_relaxed(addr : Void*) : Uint8T
  fun rte_write16(value : Uint16T, addr : Void*)
  fun rte_write16_relaxed(value : Uint16T, addr : Void*)
  fun rte_write32(value : Uint32T, addr : Void*)
  fun rte_write32_relaxed(value : Uint32T, addr : Void*)
  fun rte_write64(value : Uint64T, addr : Void*)
  fun rte_write64_relaxed(value : Uint64T, addr : Void*)
  fun rte_write8(value : Uint8T, addr : Void*)
  fun rte_write8_relaxed(value : Uint8T, addr : Void*)
end
