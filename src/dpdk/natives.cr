lib LibDpdk
  fun print_dev
  fun rte_ring_sc_dequeue_burst_peek(r : RteRing*, obj_table : Void**, n : UInt32, cons_next : UInt32*) : UInt32
  fun update_sc_tail(r : RteRing*, new_val : UInt32)
  fun inet_pton6(ipv6 : UInt8*, buf : UInt64*)
  fun tap_read(fd : Int32, buf : UInt8*, buf_size : UInt32) : UInt32
  fun tap_create(name : UInt8*, mac : UInt64, mtu : UInt32, rw : Int32) : Int32
  fun tap_setup_ip(name : UInt8*, ip : UInt32, loopback : UInt32, ipv6 : UInt64*,
                   routes : UInt32*, nb_routes : UInt32, gw : UInt32)
  # fun kni_create(name : UInt8*, pool : RteMempool*, port_id : UInt16, lcore_id : UInt32, rw : Int32) : RteKni*
  # fun kni_setup_ip(name : UInt8*, ip : UInt32, loopback : UInt32, ipv6 : UInt64*,
  #                  routes : UInt32*, nb_routes : UInt32, gw : UInt32)
  $stdin : Void*
  $stdout : Void*
  $stderr : Void*
end
