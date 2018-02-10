require "../../src/dpdk"

class LoadBalancer < Dpdk
  APP_LCORE_IO_FLUSH     = 100_000
  APP_LCORE_WORKER_FLUSH = 100_000
  APP_STATS              =  10_000

  # APP_IO_RX_DROP_ALL_PACKETS = 0
  # APP_WORKER_DROP_ALL_PACKETS = 0
  # APP_IO_TX_DROP_ALL_PACKETS = 0
  # APP_IO_RX_PREFETCH_ENABLE = 1
  # APP_WORKER_PREFETCH_ENABLE = 1
  # APP_IO_TX_PREFETCH_ENABLE = 1

  def app_lcore_io_rx_buffer_to_send(lp, worker, mbuf : RteMbuf*, bsz) : Void
    mbuf_out_flush_ptr = lp.value.u.io.rx.mbuf_out_flush.pointer_at(worker)
    mbuf_out_ptr = lp.value.u.io.rx.mbuf_out.pointer_at(worker)

    pos = mbuf_out_ptr.value.n_mbufs
    mbuf_out_ptr.value.array.pointer_at(pos).value = mbuf
    pos += 1
    if likely(pos < bsz)
      mbuf_out_ptr.value.n_mbufs = pos
      return
    end

    array_ptr = mbuf_out_ptr.value.array.to_unsafe

    ret = rte_ring_sp_enqueue_bulk(lp.value.u.io.rx.rings[worker], array_ptr.as(Void**), bsz, NULL)

    if unlikely(ret == 0)
      bsz.times do |k|
        rte_pktmbuf_free(array_ptr[k])
      end
    end

    mbuf_out_ptr.value.n_mbufs = 0
    mbuf_out_flush_ptr.value = 0_u8

    {% if LoadBalancer.has_constant?(:APP_STATS) %}
      iter_ptr = lp.value.u.io.rx.rings_iters.pointer_at(worker)
      count_ptr = lp.value.u.io.rx.rings_count.pointer_at(worker)
      iter_ptr.value += 1
      count_ptr.value += 1 if likely(ret == 0)
      if unlikely(iter_ptr.value == APP_STATS)
        lcore = rte_lcore_id
        printf("\tI/O RX %u out (worker %u): enq success rate = %.2f\n",
          lcore, worker, count_ptr.value.to_f / iter_ptr.value.to_f)
        iter_ptr.value = 0_u32
        count_ptr.value = 0_u32
      end
    {% end %}
  end

  def app_lcore_io_rx(lp, n_workers, bsz_rd, bsz_wr, pos_lb : UInt8) : Void
    stats = uninitialized RteEthStats
    lp.value.u.io.rx.n_nic_queues.times do |i|
      port = lp.value.u.io.rx.nic_queues.pointer_at(i).value.port
      queue = lp.value.u.io.rx.nic_queues.pointer_at(i).value.queue

      array_ptr = lp.value.u.io.rx.mbuf_in.array.to_unsafe
      n_mbufs = rte_eth_rx_burst(port, queue, array_ptr, bsz_rd.to_u16)

      next if unlikely(n_mbufs == 0)

      {% if LoadBalancer.has_constant?(:APP_STATS) %}
        iter_ptr = lp.value.u.io.rx.nic_queues_iters.pointer_at(i)
        count_ptr = lp.value.u.io.rx.nic_queues_count.pointer_at(i)
        iter_ptr.value += 1
        count_ptr.value += n_mbufs
        if unlikely(iter_ptr.value == APP_STATS)
          lcore = rte_lcore_id
          rte_eth_stats_get(port, pointerof(stats))

          printf("I/O RX %u in (NIC port %hu): NIC drop ratio = %.2f avg burst size = %.2f\n",
            lcore, port, stats.imissed.to_f / (stats.imissed + stats.ipackets).to_f,
            count_ptr.value.to_f / iter_ptr.value.to_f)
          iter_ptr.value = 0_u32
          count_ptr.value = 0_u32
        end
      {% end %}

      mbuf_1_0 = array_ptr[0].as(Void*)
      mbuf_1_1 = array_ptr[1].as(Void*)
      data_1_0 = rte_pktmbuf_mtod(mbuf_1_0)
      if likely(n_mbufs > 1)
        data_1_1 = rte_pktmbuf_mtod(mbuf_1_1)
      end

      mbuf_2_0 = array_ptr[2].as(Void*)
      mbuf_2_1 = array_ptr[3].as(Void*)
      rte_prefetch0(mbuf_2_0)
      rte_prefetch0(mbuf_2_1)

      j = 0
      while j + 3 < n_mbufs
        mbuf_0_0 = mbuf_1_0
        mbuf_0_1 = mbuf_1_1
        data_0_0 = data_1_0
        data_0_1 = data_1_1

        mbuf_1_0 = mbuf_2_0
        mbuf_1_1 = mbuf_2_1
        data_1_0 = rte_pktmbuf_mtod(mbuf_2_0)
        data_1_1 = rte_pktmbuf_mtod(mbuf_2_1)
        rte_prefetch0(data_1_0)
        rte_prefetch0(data_1_1)

        mbuf_2_0 = array_ptr[j + 4].as(Void*)
        mbuf_2_1 = array_ptr[j + 5].as(Void*)
        rte_prefetch0(mbuf_2_0)
        rte_prefetch0(mbuf_2_1)

        worker_0 = data_0_0.not_nil!.as(UInt8*)[pos_lb] & (n_workers - 1)
        worker_1 = data_0_1.not_nil!.as(UInt8*)[pos_lb] & (n_workers - 1)

        app_lcore_io_rx_buffer_to_send(lp, worker_0, mbuf_0_0.as(RteMbuf*), bsz_wr)
        app_lcore_io_rx_buffer_to_send(lp, worker_1, mbuf_0_1.as(RteMbuf*), bsz_wr)
        j += 2
      end

      # Handle the last 1, 2 (when n_mbufs is even) or 3 (when n_mbufs is odd) packets
      while j < n_mbufs
        mbuf = mbuf_1_0
        mbuf_1_0 = mbuf_1_1
        mbuf_1_1 = mbuf_2_0
        mbuf_2_0 = mbuf_2_1

        data = rte_pktmbuf_mtod(mbuf).as(UInt8*)

        rte_prefetch0(mbuf_1_0)

        worker = data[pos_lb] & (n_workers - 1)

        app_lcore_io_rx_buffer_to_send(lp, worker, mbuf.as(RteMbuf*), bsz_wr)
        j += 1
      end
    end
  end

  def app_lcore_io_rx_flush(lp, n_workers) : Void
    n_workers.times do |worker|
      mbuf_out_flush_ptr = lp.value.u.io.rx.mbuf_out_flush.pointer_at(worker)
      mbuf_out_ptr = lp.value.u.io.rx.mbuf_out.pointer_at(worker)

      if likely(mbuf_out_flush_ptr.value == 0 || mbuf_out_ptr.value.n_mbufs == 0)
        mbuf_out_flush_ptr.value = 1_u8
        next
      end

      ret = rte_ring_sp_enqueue_bulk(lp.value.u.io.rx.rings[worker], mbuf_out_ptr.value.array.to_unsafe.as(Void**), mbuf_out_ptr.value.n_mbufs, NULL)

      if unlikely(ret == 0)
        mbuf_out_ptr.value.n_mbufs.times do |k|
          rte_pktmbuf_free(mbuf_out_ptr.value.array[k])
        end
      end

      mbuf_out_ptr.value.n_mbufs = 0
      mbuf_out_flush_ptr.value = 1_u8
    end
  end

  def app_lcore_io_tx(lp, n_workers, bsz_rd, bsz_wr) : Void
    n_workers.times do |worker|
      lp.value.u.io.tx.n_nic_ports.times do |i|
        port = lp.value.u.io.tx.nic_ports[i]
        ring = lp.value.u.io.tx.rings[port][worker]

        mbuf_out_ptr = lp.value.u.io.tx.mbuf_out.pointer_at(port)
        array_ptr = mbuf_out_ptr.value.array.to_unsafe

        n_mbufs = mbuf_out_ptr.value.n_mbufs
        ret = rte_ring_sc_dequeue_bulk(ring, (array_ptr + n_mbufs).as(Void**), bsz_rd, NULL)

        next if unlikely(ret == 0)

        n_mbufs += bsz_rd

        if unlikely(n_mbufs < bsz_wr)
          mbuf_out_ptr.value.n_mbufs = n_mbufs
          next
        end

        n_pkts = rte_eth_tx_burst(port, 0_u16, array_ptr, n_mbufs.to_u16)

        {% if LoadBalancer.has_constant?(:APP_STATS) %}
          iter_ptr = lp.value.u.io.tx.nic_ports_iters.pointer_at(port)
          count_ptr = lp.value.u.io.tx.nic_ports_iters.pointer_at(port)
          iter_ptr.value += 1
          count_ptr.value += n_pkts
          if unlikely(iter_ptr.value == APP_STATS)
            lcore = rte_lcore_id

            printf("\t\t\tI/O TX %u out (port %hu): avg burst size = %.2f\n",
              lcore, port, count_ptr.value.to_f / iter_ptr.value.to_f)
            iter_ptr.value = 0_u32
            count_ptr.value = 0_u32
          end
        {% end %}

        if unlikely(n_pkts < n_mbufs)
          (n_pkts...n_mbufs).each do |k|
            rte_pktmbuf_free(mbuf_out_ptr.value.array[k])
          end
        end
        mbuf_out_ptr.value.n_mbufs = 0
        lp.value.u.io.tx.mbuf_out_flush.pointer_at(port).value = 0_u8
      end
    end
  end

  def app_lcore_io_tx_flush(lp) : Void
    lp.value.u.io.tx.n_nic_ports.times do |i|
      port = lp.value.u.io.tx.nic_ports[i]
      mbuf_out_flush_ptr = lp.value.u.io.tx.mbuf_out_flush.pointer_at(port)
      mbuf_out_ptr = lp.value.u.io.tx.mbuf_out.pointer_at(port)

      if likely(mbuf_out_flush_ptr.value == 0 || mbuf_out_ptr.value.n_mbufs == 0)
        mbuf_out_flush_ptr.value = 1_u8
        next
      end

      n_pkts = rte_eth_tx_burst(port, 0_u16, mbuf_out_ptr.value.array, mbuf_out_ptr.value.n_mbufs.to_u16)

      if unlikely(n_pkts < mbuf_out_ptr.value.n_mbufs)
        (n_pkts...mbuf_out_ptr.value.n_mbufs).each do |k|
          rte_pktmbuf_free(mbuf_out_ptr.value.array[k])
        end
      end

      mbuf_out_ptr.value.n_mbufs = 0
      mbuf_out_flush_ptr.value = 1_u8
    end
  end

  def app_lcore_main_loop_io : Void
    lcore = rte_lcore_id
    lp = @app.lcore_params.pointer_at(lcore)
    n_workers = app_get_lcores_worker
    i = 0

    bsz_rx_rd = @app.burst_size_io_rx_read
    bsz_rx_wr = @app.burst_size_io_rx_write
    bsz_tx_rd = @app.burst_size_io_tx_read
    bsz_tx_wr = @app.burst_size_io_tx_write

    pos_lb = @app.pos_lb.to_u8

    while true
      if unlikely(i == APP_LCORE_IO_FLUSH)
        app_lcore_io_rx_flush(lp, n_workers) if likely(lp.value.u.io.rx.n_nic_queues > 0)
        app_lcore_io_tx_flush(lp) if likely(lp.value.u.io.tx.n_nic_ports > 0)
        i = 0
      end

      if likely(lp.value.u.io.rx.n_nic_queues > 0)
        app_lcore_io_rx(lp, n_workers, bsz_rx_rd, bsz_rx_wr, pos_lb)
      end

      if likely(lp.value.u.io.tx.n_nic_ports > 0)
        app_lcore_io_tx(lp, n_workers, bsz_tx_rd, bsz_tx_wr)
      end

      i += 1
    end
  end

  def app_lcore_worker(lp, bsz_rd, bsz_wr) : Void
    lp.value.u.worker.n_rings_in.times do |i|
      ring_in = lp.value.u.worker.rings_in[i]
      mbuf_in_array = lp.value.u.worker.mbuf_in.array.to_unsafe.as(Void**)
      ret = rte_ring_sc_dequeue_bulk(ring_in, mbuf_in_array, bsz_rd, NULL)
      next if unlikely(ret == 0)

      rte_prefetch1(rte_pktmbuf_mtod(mbuf_in_array[0]))
      rte_prefetch0(mbuf_in_array[1])

      bsz_rd.times do |j|
        port = 0_u32

        rte_prefetch1(rte_pktmbuf_mtod(mbuf_in_array[j + 1])) if likely(j < bsz_rd - 1)
        rte_prefetch0(mbuf_in_array[j + 2]) if likely(j < bsz_rd - 2)

        pkt = mbuf_in_array[j].as(RteMbuf*)
        ipv4_hdr = rte_pktmbuf_mtod_offset(pkt, sizeof(EtherHdr)).as(Ipv4Hdr*)
        ipv4_dst = rte_be_to_cpu_32(ipv4_hdr.value.dst_addr)

        if unlikely(rte_lpm_lookup(lp.value.u.worker.lpm_table, ipv4_dst, pointerof(port)) != 0)
          port = pkt.value.port.to_u32
        end

        mbuf_out_ptr = lp.value.u.worker.mbuf_out.pointer_at(port)
        pos = mbuf_out_ptr.value.n_mbufs

        mbuf_out_ptr.value.array.pointer_at(pos).value = pkt
        pos += 1
        if likely(pos < bsz_wr)
          mbuf_out_ptr.value.n_mbufs = pos
          next
        end

        ret = rte_ring_sp_enqueue_bulk(lp.value.u.worker.rings_out[port], mbuf_out_ptr.value.array.to_unsafe.as(Void**), bsz_wr, NULL)

        {% if LoadBalancer.has_constant?(:APP_STATS) %}
          iter_ptr = lp.value.u.worker.rings_out_iters.pointer_at(port)
          count_ptr = lp.value.u.worker.rings_out_count.pointer_at(port)
          iter_ptr.value += 1
          count_ptr.value += 1 if ret > 0
          if unlikely(iter_ptr.value == APP_STATS)
            printf("\t\tWorker %u out (NIC port %hu): enq success rate = %.2f\n",
              lp.value.u.worker.worker_id, port, count_ptr.value.to_f / iter_ptr.value.to_f)
            iter_ptr.value = 0_u32
            count_ptr.value = 0_u32
          end
        {% end %}

        if unlikely(ret == 0)
          bsz_wr.times do |k|
            rte_pktmbuf_free(mbuf_out_ptr.value.array[k])
          end
        end

        mbuf_out_ptr.value.n_mbufs = 0
        lp.value.u.worker.mbuf_out_flush.pointer_at(port).value = 0_u8
      end
    end
  end

  def app_lcore_worker_flush(lp) : Void
    APP_MAX_NIC_PORTS.times do |port|
      next if unlikely(lp.value.u.worker.rings_out[port].null?)

      mbuf_out_ptr = lp.value.u.worker.mbuf_out.pointer_at(port)
      mbuf_out_flush_ptr = lp.value.u.worker.mbuf_out_flush.pointer_at(port)

      if likely(mbuf_out_flush_ptr.value == 0 || mbuf_out_ptr.value.n_mbufs == 0)
        mbuf_out_flush_ptr.value = 1_u8
        next
      end

      ret = rte_ring_sp_enqueue_bulk(lp.value.u.worker.rings_out[port],
        mbuf_out_ptr.value.array.to_unsafe.as(Void**), mbuf_out_ptr.value.n_mbufs, NULL)

      if unlikely(ret == 0)
        mbuf_out_ptr.value.n_mbufs.times do |k|
          rte_pktmbuf_free(mbuf_out_ptr.value.array[k])
        end
      end

      mbuf_out_ptr.value.n_mbufs = 0
      mbuf_out_flush_ptr.value = 1_u8
    end
  end

  def app_lcore_main_loop_worker : Void
    lcore = rte_lcore_id
    lp = @app.@lcore_params.pointer_at(lcore)
    i = 0
    bsz_rd = @app.burst_size_worker_read
    bsz_wr = @app.burst_size_worker_write
    while true
      if unlikely(i == APP_LCORE_WORKER_FLUSH)
        app_lcore_worker_flush(lp)
        i = 0
      end
      app_lcore_worker(lp, bsz_rd, bsz_wr)
      i += 1
    end
  end

  def app_lcore_main_loop : Void
    lcore = rte_lcore_id
    lp = @app.lcore_params.pointer_at(lcore)

    if lp.value.type.e_app_lcore_io?
      printf("Logical core %u (I/O) main loop.\n", lcore)
      app_lcore_main_loop_io
    end

    if lp.value.type.e_app_lcore_worker?
      printf("Logical core %u (worker %u) main loop.\n", lcore, lp.value.u.worker.worker_id)
      app_lcore_main_loop_worker
    end
  end
end
