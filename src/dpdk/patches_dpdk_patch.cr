# :nodoc:
{% skip_file() unless flag?(:dpdk_patch) && Crystal.has_constant?(:DPDK_PATCHED) %}

require "./lib_c"

fun main(argc : Int32, argv : UInt8**) : Int32
  _crystal_main(argc, argv); 0
end

{% unless flag?(:fiber_none) %}
fun _fiber_get_stack_top : Void*
  Pointer(Void).null
end

# fun __crystal_personality(version : Int32, actions : LibUnwind::Action, exception_class : UInt64, exception_object : LibUnwind::Exception*, context : Void*) : LibUnwind::ReasonCode
#   LibUnwind::ReasonCode::NO_REASON
# end

# fun __crystal_raise(unwind_ex : LibUnwind::Exception*) : NoReturn
#   LibC.exit(1)
# end

# fun __crystal_get_exception(unwind_ex : LibUnwind::Exception*) : UInt64
#   0_u64
# end
{% end %}
