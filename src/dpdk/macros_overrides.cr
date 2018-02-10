require "../lib_dpdk"

class Dpdk
  # rte_pktmbuf_pool_create with error handling
  macro rte_pktmbuf_pool_create(*args)
    buf = LibDpdk.rte_pktmbuf_pool_create({{*args}})
    fail("Cannot create mbuf pool\n") if buf.null?
    buf
  end

  # rte_pktmbuf_alloc with error handling
  macro rte_pktmbuf_alloc(arg)
    buf = LibDpdk.rte_pktmbuf_alloc({{arg}})
    fail("Cannot allocate mbuf") if buf.null?
    buf
  end

  # rte_eal_init with error handling
  macro rte_eal_init(*args)
    ret = LibDpdk.rte_eal_init({{*args}})
    fail("Error with EAL initialization\n") if ret < 0
    # panic("Cannot init EAL\n") if ret < 0
    ret
  end

  # rte_ring_create with error handling
  macro rte_ring_create(*args)
    ret = LibDpdk.rte_ring_create({{*args}})
    fail("%s\n", rte_strerror(rte_errno)) if ret.null?
    ret
  end

  # rte_zmalloc_socket with error handling
  macro rte_zmalloc_socket(type, size, align, socket)
    ret = LibDpdk.rte_zmalloc_socket({{type}}, {{size}}, {{align}}, {{socket}})
    fail("Cannot allocate buffer for %s on socket %d\n", {{type}}, {{socket}}) if ret.null?
    ret
  end

  # rte_ring_dequeue_burst with casting to Void**
  macro rte_ring_dequeue_burst(r, obj_table, n, available)
    LibDpdk.rte_ring_dequeue_burst({{r}}, {{obj_table}}.as(Void**), {{n}}, {{available}})
  end

  # rte_ring_enqueue_burst with casting to Void**
  macro rte_ring_enqueue_burst(r, obj_table, n, free_space)
    LibDpdk.rte_ring_enqueue_burst({{r}}, {{obj_table}}.as(Void**), {{n}}, {{free_space}})
  end

  # rte_ring_lookup with error handling
  # macro rte_ring_lookup(name)
  #   ret = LibDpdk.rte_ring_lookup({{name}})
  #   fail("Cannot find ring: " + {{name}} + "\n") if ret.null?
  #   ret
  # end

  # rte_eth_dev_configure with error handling
  macro rte_eth_dev_configure(*args)
    ret = LibDpdk.rte_eth_dev_configure({{*args}})
    fail("Cannot configure device: err=%d, port=%u\n", ret, {{args[0]}}) if ret < 0
  end

  # rte_eth_dev_adjust_nb_rx_tx_desc with error handling
  macro rte_eth_dev_adjust_nb_rx_tx_desc(*args)
    ret = LibDpdk.rte_eth_dev_adjust_nb_rx_tx_desc({{*args}})
    fail("Cannot adjust number of descriptors: err=%d, port=%u\n", ret, {{args[0]}}) if ret < 0
  end

  # rte_eth_rx_queue_setup with error handling
  macro rte_eth_rx_queue_setup(*args)
    ret = LibDpdk.rte_eth_rx_queue_setup({{*args}})
    fail("rte_eth_rx_queue_setup:err=%d, port=%u\n", ret, {{args[0]}}) if ret < 0
  end

  # rte_eth_tx_queue_setup with error handling
  macro rte_eth_tx_queue_setup(*args)
    ret = LibDpdk.rte_eth_tx_queue_setup({{*args}})
    fail("rte_eth_tx_queue_setup:err=%d, port=%u\n", ret, {{args[0]}}) if ret < 0
  end

  # rte_eth_dev_start with error handling
  macro rte_eth_dev_start(portid)
    ret = LibDpdk.rte_eth_dev_start({{portid}})
    fail("rte_eth_dev_start:err=%d, port=%u\n", ret, {{portid}}) if ret < 0
  end

  # rte_lpm_create with error handling
  macro rte_lpm_create(*args)
    ret = LibDpdk.rte_lpm_create({{*args}})
    fail("Unable to create LPM table on socket %u\n", {{args[1]}}) if ret.null?
    ret
  end

  # rte_eal_remote_launch with automatic proc creation
  macro rte_eal_remote_launch(call, *args)
    LibDpdk.rte_eal_remote_launch(->(arg : Void*) {
      typeof(self).instance.{{call.name}}(arg); 0
    }, {{*args}})
  end

  # LibC.signal shortcut with automatic proc creation
  macro signal(signum, call)
    LibC.signal(LibC::{{signum}}, ->(signum : LibC::Int) {
      typeof(self).instance.{{call.name}}(signum)
    })
  end

  # :nodoc:
  macro rte_be_to_cpu_32(x)
    Intrinsics.bswap32({{x}})
  end

  # rte_eth_dev_info_get with buffer allocation
  macro rte_eth_dev_info_get(port)
    dev_info = uninitialized RteEthDevInfo
    LibDpdk.rte_eth_dev_info_get({{port}}, pointerof(dev_info))
    dev_info
  end
end
