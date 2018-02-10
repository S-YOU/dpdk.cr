lib LibDpdk
  fun eal_thread_dump_affinity(str : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun eal_thread_init_master(lcore_id : LibC::UInt)
  fun eal_thread_loop(arg : Void*) : Void*
end
