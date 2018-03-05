lib LibDpdk
  fun rte_reciprocal_divide(a : Uint32T, r : RteReciprocal) : Uint32T
  fun rte_reciprocal_value(d : Uint32T) : RteReciprocal

  struct RteReciprocal
    m : Uint32T
    sh1 : Uint8T
    sh2 : Uint8T
  end
end
