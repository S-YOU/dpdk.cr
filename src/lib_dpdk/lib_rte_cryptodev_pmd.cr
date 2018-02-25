lib LibDpdk
  $cryptodev_pmd_valid_params : LibC::Char*[4]
  $rte_cryptodev_globals : RteCryptodevGlobal*
  fun rte_cryptodev_allocate_driver(crypto_drv : CryptodevDriver*, drv : RteDriver*) : Uint8T
  fun rte_cryptodev_pmd_allocate(name : LibC::Char*, socket_id : LibC::Int) : RteCryptodev*
  fun rte_cryptodev_pmd_callback_process(dev : RteCryptodev*, event : RteCryptodevEventType)
  fun rte_cryptodev_pmd_create(name : LibC::Char*, device : RteDevice*, params : RteCryptodevPmdInitParams*) : RteCryptodev*
  fun rte_cryptodev_pmd_create_dev_name(name : LibC::Char*, dev_name_prefix : LibC::Char*) : LibC::Int
  fun rte_cryptodev_pmd_destroy(cryptodev : RteCryptodev*) : LibC::Int
  fun rte_cryptodev_pmd_get_dev(dev_id : Uint8T) : RteCryptodev*
  fun rte_cryptodev_pmd_get_named_dev(name : LibC::Char*) : RteCryptodev*
  fun rte_cryptodev_pmd_is_valid_dev(dev_id : Uint8T) : LibC::UInt
  fun rte_cryptodev_pmd_parse_input_args(params : RteCryptodevPmdInitParams*, args : LibC::Char*) : LibC::Int
  fun rte_cryptodev_pmd_release_device(cryptodev : RteCryptodev*) : LibC::Int

  struct CryptodevDriver
    next : CryptodevDriverNext
    driver : RteDriver*
    id : Uint8T
  end

  struct CryptodevDriverNext
    tqe_next : CryptodevDriver*
    tqe_prev : CryptodevDriver**
  end

  # struct RteCryptodev

  struct RteCryptodevGlobal
    devs : RteCryptodev*
    data : RteCryptodevData*
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

  struct RteCryptodevPmdInitParams
    name : LibC::Char[64]
    private_data_size : LibC::Int
    socket_id : LibC::Int
    max_nb_queue_pairs : LibC::UInt
    max_nb_sessions : LibC::UInt
  end
end
