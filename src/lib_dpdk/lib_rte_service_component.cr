lib LibDpdk
  alias RteServiceFunc = (Void* -> Int32T)
  fun rte_service_component_register(spec : RteServiceSpec*, service_id : Uint32T*) : Int32T
  fun rte_service_component_runstate_set(id : Uint32T, runstate : Uint32T) : Int32T
  fun rte_service_component_unregister(id : Uint32T) : Int32T
  fun rte_service_finalize
  fun rte_service_init : Int32T
  fun rte_service_start_with_defaults : Int32T

  struct RteServiceSpec
    name : LibC::Char[32]
    callback : RteServiceFunc
    callback_userdata : Void*
    capabilities : Uint32T
    socket_id : LibC::Int
  end
end
