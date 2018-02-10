lib LibDpdk
  fun rte_reciprocal_divide(a : Uint32T, r : RteReciprocal) : Uint32T
  fun rte_reciprocal_value_u64(d : Uint64T) : RteReciprocalU64

  struct RteReciprocal
    m : Uint32T
    sh1 : Uint8T
    sh2 : Uint8T
  end

  struct RteReciprocalU64
    m : Uint64T
    sh1 : Uint8T
    sh2 : Uint8T
  end
end
