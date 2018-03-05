lib LibDpdk
  fun rte_service_init : Int32T
  fun rte_service_register(spec : RteServiceSpec*) : Int32T
  fun rte_service_start_with_defaults : Int32T
  fun rte_service_unregister(service : RteServiceSpec*) : Int32T

  struct RteServiceSpec
    name : LibC::Char[32]
    callback : Void*
    callback_userdata : Void*
    capabilities : Uint32T
    socket_id : LibC::Int
  end
end
