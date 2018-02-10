lib LibDpdk
  fun random : LibC::Long
  fun random_r(__buf : RandomData*, __result : Int32T*) : LibC::Int

  struct RandomData
    fptr : Int32T*
    rptr : Int32T*
    state : Int32T*
    rand_type : LibC::Int
    rand_deg : LibC::Int
    rand_sep : LibC::Int
    end_ptr : Int32T*
  end
end
