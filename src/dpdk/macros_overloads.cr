require "../lib_dpdk"

class Dpdk
  # :nodoc:
  RTE_MBUF_DEFAULT_BUF_SIZE = RTE_MBUF_DEFAULT_DATAROOM + RTE_PKTMBUF_HEADROOM

  # pool creation shortcut with only numbers of pool, and cache_size
  macro pool_create(n, cache_size)
    # call the overload, not original
    buf = rte_pktmbuf_pool_create("mbuf_pool", {{n}}, {{cache_size}}, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id)
  end

  # pool creation shortcut with only name, numbers of pool, and cache_size
  macro pool_create(name, n, cache_size)
    # call the overload, not original
    buf = rte_pktmbuf_pool_create({{name}}, {{n}}, {{cache_size}}, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id)
  end

  # similar to rte_pktmbuf_mtod, but without type parameters, use .as(...) after this
  macro rte_pktmbuf_mtod(m)
    # m.buf_addr + m.data_off
    Pointer(Void).new({{m}}.as(UInt64*).value + {{m}}.offset_at(16).as(UInt16*).value)
  end

  # similar to rte_pktmbuf_mtod_offset, but without type parameters, use .as(...) after this
  macro rte_pktmbuf_mtod_offset(m, o)
    # m.buf_addr + m.data_off
    Pointer(Void).new({{m}}.as(UInt64*).value + {{m}}.offset_at(16).as(UInt16*).value + {{o}})
  end

  # similar to rte_eal_mp_remote_launch without writing proc directly
  macro rte_eal_mp_remote_launch(call)
    LibDpdk.rte_eal_mp_remote_launch(->(_arg : Void*) {
      typeof(self).instance.{{call.name}}; 0
    }, nil, LibDpdk::RteRmtCallMasterT::CallMaster)
  end

  # rte_distributor_create with error handling
  macro distributor_create(cores)
    ret = rte_distributor_create("PKT_DIST", rte_socket_id, {{cores}}, RTE_DIST_ALG_BURST)
    fail("Cannot create distributor\n") if ret.null?
    ret
  end

  # uninitialized as pointer (mainly for StaticArray)
  macro uninitialized_ptr(arg)
    %name = uninitialized {{arg}}
    %name.to_unsafe
  end
end
