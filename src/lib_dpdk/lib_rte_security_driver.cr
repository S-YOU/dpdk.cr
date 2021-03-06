lib LibDpdk
  struct RteSecurityCtx
    device : Void*
    ops : RteSecurityOps*
    sess_cnt : Uint16T
  end

  struct RteSecurityOps
    session_create : Void*
    session_update : Void*
    session_get_size : Void*
    session_stats_get : Void*
    session_destroy : Void*
    set_pkt_metadata : Void*
    get_userdata : Void*
    capabilities_get : Void*
  end
end
