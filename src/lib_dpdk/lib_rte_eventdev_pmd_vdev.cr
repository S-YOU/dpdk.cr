lib LibDpdk
  fun rte_event_pmd_vdev_init(name : LibC::Char*, dev_private_size : LibC::Int, socket_id : LibC::Int) : RteEventdev*
  fun rte_event_pmd_vdev_uninit(name : LibC::Char*) : LibC::Int
end
