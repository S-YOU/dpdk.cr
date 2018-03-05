lib LibDpdk
  $rte_cryptodev_globals : RteCryptodevGlobal*
  fun rte_cryptodev_pmd_allocate(name : LibC::Char*, socket_id : LibC::Int) : RteCryptodev*
  fun rte_cryptodev_pmd_callback_process(dev : RteCryptodev*, event : RteCryptodevEventType)
  fun rte_cryptodev_pmd_create_dev_name(name : LibC::Char*, dev_name_prefix : LibC::Char*) : LibC::Int
  fun rte_cryptodev_pmd_get_dev(dev_id : Uint8T) : RteCryptodev*
  fun rte_cryptodev_pmd_get_named_dev(name : LibC::Char*) : RteCryptodev*
  fun rte_cryptodev_pmd_is_valid_dev(dev_id : Uint8T) : LibC::UInt
  fun rte_cryptodev_pmd_release_device(cryptodev : RteCryptodev*) : LibC::Int

  # struct RteCryptodev

  struct RteCryptodevGlobal
    devs : RteCryptodev*
    data : RteCryptodevData*[64]
    nb_devs : Uint8T
    max_devs : Uint8T
  end

  struct RteCryptodevOps
    dev_configure : Void*
    dev_start : Void*
    dev_stop : Void*
    dev_close : Void*
    dev_infos_get : Void*
    stats_get : Void*
    stats_reset : Void*
    queue_pair_setup : Void*
    queue_pair_release : Void*
    queue_pair_start : Void*
    queue_pair_stop : Void*
    queue_pair_count : Void*
    session_get_size : Void*
    session_configure : Void*
    session_clear : Void*
    qp_attach_session : Void*
    qp_detach_session : Void*
  end
end
