lib LibDpdk
  alias RteKeepalive = Void
  alias RteKeepaliveFailureCallbackT = (Void*, LibC::Int -> Void)
  alias RteKeepaliveRelayCallbackT = (Void*, LibC::Int, RteKeepaliveState, Uint64T -> Void)
  enum RteKeepaliveState
    RteKaStateUnused  = 0
    RteKaStateAlive   = 1
    RteKaStateMissing = 4
    RteKaStateDead    = 2
    RteKaStateGone    = 3
    RteKaStateDozing  = 5
    RteKaStateSleep   = 6
  end
  fun rte_keepalive_create(callback : RteKeepaliveFailureCallbackT, data : Void*) : RteKeepalive*
  fun rte_keepalive_dispatch_pings(ptr_timer : Void*, ptr_data : Void*)
  fun rte_keepalive_mark_alive(keepcfg : RteKeepalive*)
  fun rte_keepalive_mark_sleep(keepcfg : RteKeepalive*)
  fun rte_keepalive_register_core(keepcfg : RteKeepalive*, id_core : LibC::Int)
  fun rte_keepalive_register_relay_callback(keepcfg : RteKeepalive*, callback : RteKeepaliveRelayCallbackT, data : Void*)
end
