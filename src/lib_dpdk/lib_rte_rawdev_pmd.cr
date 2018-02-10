lib LibDpdk
  $rte_rawdev_globals : RteRawdevGlobal*
  fun rte_rawdev_close(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_configure(dev_id : Uint16T, dev_conf : RteRawdevInfo*) : LibC::Int
  fun rte_rawdev_count : Uint8T
  fun rte_rawdev_dequeue_buffers(dev_id : Uint16T, buffers : RteRawdevBuf**, count : LibC::UInt, context : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_dump(dev_id : Uint16T, f : File*) : LibC::Int
  fun rte_rawdev_enqueue_buffers(dev_id : Uint16T, buffers : RteRawdevBuf**, count : LibC::UInt, context : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_firmware_load(dev_id : Uint16T, firmware_image : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_firmware_status_get(dev_id : Uint16T, status_info : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_firmware_unload(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_firmware_version_get(dev_id : Uint16T, version_info : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_get_attr(dev_id : Uint16T, attr_name : LibC::Char*, attr_value : Uint64T*) : LibC::Int
  fun rte_rawdev_get_dev_id(name : LibC::Char*) : Uint16T
  fun rte_rawdev_info_get(dev_id : Uint16T, dev_info : RteRawdevInfo*) : LibC::Int
  fun rte_rawdev_pmd_allocate(name : LibC::Char*, dev_private_size : LibC::Int, socket_id : LibC::Int) : RteRawdev*
  fun rte_rawdev_pmd_get_named_dev(name : LibC::Char*) : RteRawdev*
  fun rte_rawdev_pmd_init(name : LibC::Char*, dev_private_size : LibC::Int, socket_id : LibC::Int) : RteRawdev*
  fun rte_rawdev_pmd_is_valid_dev(dev_id : Uint8T) : LibC::UInt
  fun rte_rawdev_pmd_release(rawdev : RteRawdev*) : LibC::Int
  fun rte_rawdev_pmd_uninit(name : LibC::Char*) : LibC::Int
  fun rte_rawdev_queue_conf_get(dev_id : Uint16T, queue_id : Uint16T, queue_conf : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_queue_count(dev_id : Uint16T) : Uint16T
  fun rte_rawdev_queue_release(dev_id : Uint16T, queue_id : Uint16T) : LibC::Int
  fun rte_rawdev_queue_setup(dev_id : Uint16T, queue_id : Uint16T, queue_conf : RteRawdevObjT) : LibC::Int
  fun rte_rawdev_reset(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_selftest(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_set_attr(dev_id : Uint16T, attr_name : LibC::Char*, attr_value : Uint64T) : LibC::Int
  fun rte_rawdev_socket_id(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_start(dev_id : Uint16T) : LibC::Int
  fun rte_rawdev_stop(dev_id : Uint16T)
  fun rte_rawdev_xstats_by_name_get(dev_id : Uint16T, name : LibC::Char*, id : LibC::UInt*) : Uint64T
  fun rte_rawdev_xstats_get(dev_id : Uint16T, ids : LibC::UInt*, values : Uint64T*, n : LibC::UInt) : LibC::Int
  fun rte_rawdev_xstats_names_get(dev_id : Uint16T, xstats_names : RteRawdevXstatsName*, size : LibC::UInt) : LibC::Int
  fun rte_rawdev_xstats_reset(dev_id : Uint16T, ids : Uint32T*, nb_ids : Uint32T) : LibC::Int

  struct RteRawdev
    socket_id : LibC::Int
    dev_id : Uint16T
    dev_ops : RteRawdevOps*
    device : RteDevice*
    driver_name : LibC::Char*
    attached : Uint8T
    started : Uint8T
    dev_private : RteRawdevObjT
    name : LibC::Char[64]
  end

  struct RteRawdevGlobal
    nb_devs : Uint16T
  end

  struct RteRawdevInfo
    driver_name : LibC::Char*
    device : RteDevice*
    socket_id : LibC::Int
    dev_private : RteRawdevObjT
  end

  struct RteRawdevOps
    dev_info_get : Void*
    dev_configure : Void*
    dev_start : Void*
    dev_stop : Void*
    dev_close : Void*
    dev_reset : Void*
    queue_def_conf : Void*
    queue_setup : Void*
    queue_release : Void*
    enqueue_bufs : Void*
    dequeue_bufs : Void*
    dump : Void*
    attr_get : Void*
    attr_set : Void*
    xstats_get : Void*
    xstats_get_names : Void*
    xstats_get_by_name : Void*
    xstats_reset : Void*
    firmware_status_get : Void*
    firmware_version_get : Void*
    firmware_load : Void*
    firmware_unload : Void*
    dev_selftest : Void*
  end
end
