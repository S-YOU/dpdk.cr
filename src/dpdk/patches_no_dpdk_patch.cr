# :nodoc:
# {% skip_file() if flag?(:dpdk_patch) && Crystal.has_constant?(:DPDK_PATCHED) %}

# fun __crystal_raise_string(message : UInt8*)
#   LibC.puts(message)
#   LibC.exit(1)
# end

# fun __crystal_personality(version : Int32, actions : LibUnwind::Action, exception_class : UInt64, exception_object : LibUnwind::Exception*, context : Void*) : LibUnwind::ReasonCode
#   LibUnwind::ReasonCode::NO_REASON
# end

# fun __crystal_raise(unwind_ex : LibUnwind::Exception*) : NoReturn
#   LibC.exit(1)
# end

# fun __crystal_get_exception(unwind_ex : LibUnwind::Exception*) : UInt64
#   0_u64
# end
