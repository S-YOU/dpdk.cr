require "../lib_dpdk"

class Dpdk
  # per core lcore_id
  def rte_lcore_id
    LibDpdk.per_lcore__lcore_id
  end

  # per core socket_id
  def rte_socket_id
    LibDpdk.per_lcore__socket_id
  end

  # per core rte_errno, use with rte_strerror(rte_errno)
  def rte_errno
    LibDpdk.per_lcore__rte_errno
  end

  # Get the number of cycles in one second for the default timer.
  # using rte_get_tsc_hz, not rte_get_hpet_hz
  macro rte_get_timer_hz
    LibDpdk.rte_get_tsc_hz
  end

  # check lcore is enabled or not, return boolean
  def rte_lcore_is_enabled(lcore_id) : Bool
    cfg = rte_eal_get_configuration
    return false if lcore_id >= RTE_MAX_LCORE
    # cfg.lcore_role[lcore_id].role_rte?
    cfg.offset_at(12).as(LibDpdk::RteLcoreRoleT*)[lcore_id].role_rte?
  end

  # return lcore_count
  def rte_lcore_count
    rte_eal_get_configuration.value.lcore_count
  end

  # return master_lcore number
  def rte_get_master_lcore
    rte_eal_get_configuration.value.master_lcore
  end

  # return next available lcore
  def rte_get_next_lcore(i : UInt32, skip_master = 1, wrap = 0) : UInt32
    i += 1
    i %= RTE_MAX_LCORE if wrap == 1

    while i < RTE_MAX_LCORE
      if !rte_lcore_is_enabled(i) || (skip_master == 1 && (i == rte_get_master_lcore))
        i += 1
        i %= RTE_MAX_LCORE if wrap == 1
        next
      end
      break
    end
    i
  end

  # Buffer a single packet for future transmission on a port and queue
  # TODO: measure performance vs C
  @[AlwaysInline]
  def rte_eth_tx_buffer(port_id : UInt16, queue_id : UInt16, buffer : RteEthDevTxBuffer*, tx_pkt : RteMbuf*) : UInt16
    length_ptr = buffer.offset_at(18).as(UInt16*)
    pkts = buffer.offset_at(24).as(RteMbuf**)

    pkts[length_ptr.value] = tx_pkt
    length_ptr.value += 1
    return 0_u16 if length_ptr.value < buffer.value.size

    return rte_eth_tx_buffer_flush(port_id, queue_id, buffer)
  end

  # Send any packets queued up for transmission on a port and HW queue
  # TODO: measure performance vs C
  @[AlwaysInline]
  def rte_eth_tx_buffer_flush(port_id : UInt16, queue_id : UInt16, buffer : RteEthDevTxBuffer*) : UInt16
    length_ptr = buffer.offset_at(18).as(UInt16*)
    pkts = buffer.offset_at(24).as(RteMbuf**)
    to_send = length_ptr.value

    return 0_u16 if to_send == 0

    sent = rte_eth_tx_burst(port_id, queue_id, pkts, to_send)

    length_ptr.value = 0_u16

    # All packets sent, or to be dealt with by callback below
    if unlikely(sent != to_send)
      buffer.as(LibDpdk::BufferTxErrorFn*).value.call(pkts + sent, to_send - sent, buffer.offset_at(8).as(Void*))
    end

    sent
  end

  # RTE_LCORE_FOREACH_SLAVE equivalent
  def rte_lcore_foreach_slave
    lcore_id = rte_get_next_lcore(-1.to_u32)
    while lcore_id < RTE_MAX_LCORE
      yield lcore_id
      lcore_id = rte_get_next_lcore(lcore_id)
    end
  end

  # rte_lcore_foreach_slave with worker_id
  def rte_lcore_foreach_worker(limit = nil)
    worker_id, lcore_id = 0, rte_get_next_lcore(-1.to_u32)
    while lcore_id < RTE_MAX_LCORE
      yield lcore_id, worker_id
      lcore_id = rte_get_next_lcore(lcore_id)
      worker_id += 1
      break if limit && worker_id >= limit
    end
  end
end
