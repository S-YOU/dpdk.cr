class LoadBalancer < Dpdk
  @port_conf = uninitialized RteEthConf

  def app_assign_worker_ids
    worker_id = 0_u32
    APP_MAX_LCORES.times do |lcore|
      next unless @app.lcore_params.pointer_at(lcore).value.type.e_app_lcore_worker?
      @app.lcore_params.pointer_at(lcore).value.u.worker.worker_id = worker_id
      worker_id += 1
    end
  end

  def app_init_mbuf_pools
    # Init the buffer pools
    name = uninitialized UInt8[32]
    APP_MAX_SOCKETS.times do |socket|
      next if app_is_socket_used(socket) == 0

      snprintf(name, name.size, "mbuf_pool_%u", socket)
      printf("Creating the mbuf pool for socket %u ...\n", socket)

      @app.pools[socket] = rte_pktmbuf_pool_create(name, APP_DEFAULT_MEMPOOL_BUFFERS,
        APP_DEFAULT_MEMPOOL_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, socket)
      fail("Cannot create mbuf pool on socket %u\n", socket) if @app.pools[socket].null?
    end

    APP_MAX_LCORES.times do |lcore|
      next if @app.lcore_params.pointer_at(lcore).value.type.e_app_lcore_disabled?

      socket = rte_lcore_to_socket_id(lcore)
      @app.lcore_params.pointer_at(lcore).value.pool = @app.pools[socket]
    end
  end

  def app_is_socket_used(socket)
    APP_MAX_LCORES.times do |lcore|
      next if @app.lcore_params.pointer_at(lcore).value.type.e_app_lcore_disabled?
      return 1 if socket == rte_lcore_to_socket_id(lcore)
    end
    0
  end

  def app_init_lpm_tables
    name = uninitialized UInt8[32]
    # Init the LPM tables
    APP_MAX_SOCKETS.times do |socket|
      next if app_is_socket_used(socket) == 0

      lpm_config = LibDpdk::RteLpmConfig.new(
        max_rules: APP_MAX_LPM_RULES,
        number_tbl8s: 256,
        flags: 0
      )
      snprintf(name, name.size, "lpm_table_%u", socket)
      printf("Creating the LPM table for socket %u ...\n", socket)
      @app.lpm_tables.pointer_at(socket).value = rte_lpm_create(name, socket, pointerof(lpm_config))

      @app.n_lpm_rules.times do |rule|
        ret = rte_lpm_add(
          @app.lpm_tables[socket],
          @app.lpm_rules[rule].ip,
          @app.lpm_rules[rule].depth,
          @app.lpm_rules[rule].if_out)

        if ret < 0
          fail("Unable to add entry %u (%x/%u => %u) to the LPM table on socket %u (%d)\n",
            rule,
            @app.lpm_rules[rule].ip,
            @app.lpm_rules[rule].depth,
            @app.lpm_rules[rule].if_out,
            socket,
            ret)
        end
      end
    end

    APP_MAX_LCORES.times do |lcore|
      next unless @app.lcore_params.pointer_at(lcore).value.type.e_app_lcore_worker?

      socket = rte_lcore_to_socket_id(lcore)
      @app.lcore_params.pointer_at(lcore).value.u.worker.lpm_table = @app.lpm_tables[socket]
    end
  end

  def app_init_rings_rx
    name = uninitialized UInt8[32]
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.rx.n_nic_queues == 0

      socket_io = rte_lcore_to_socket_id(lcore)
      APP_MAX_LCORES.times do |lcore_worker|
        lwp = @app.lcore_params.pointer_at(lcore_worker)
        next unless lwp.value.type.e_app_lcore_worker?

        printf("Creating ring to connect I/O lcore %u (socket %u) with worker lcore %u ...\n", lcore, socket_io, lcore_worker)
        snprintf(name, name.size, "app_ring_rx_s%u_io%u_w%u", socket_io, lcore, lcore_worker)
        ring = rte_ring_create(name, @app.ring_rx_size, socket_io, RING_F_SP_ENQ | RING_F_SC_DEQ)

        n_rings = lp.value.u.io.rx.n_rings
        lp.value.u.io.rx.rings.pointer_at(n_rings).value = ring
        lp.value.u.io.rx.n_rings = n_rings + 1

        n_rings_in = lwp.value.u.worker.n_rings_in
        lwp.value.u.worker.rings_in.pointer_at(n_rings_in).value = ring
        lwp.value.u.worker.n_rings_in = n_rings_in + 1
      end
    end

    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.rx.n_nic_queues == 0

      fail("Algorithmic error (I/O RX rings)\n") if lp.value.u.io.rx.n_rings != app_get_lcores_worker
    end

    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_worker?

      fail("Algorithmic error (worker input rings)\n") if lp.value.u.worker.n_rings_in != app_get_lcores_io_rx
    end
  end

  def app_init_rings_tx
    name = uninitialized UInt8[32]
    lcore_io = 0_u32

    # Initialize the rings for the TX side
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_worker?

      APP_MAX_NIC_PORTS.times do |port|
        next if @app.nic_tx_port_mask[port] == 0

        if app_get_lcore_for_nic_tx(port, pointerof(lcore_io)) < 0
          fail("Algorithmic error (no I/O core to handle TX of port %u)\n", port)
        end

        lp_io = @app.lcore_params.pointer_at(lcore_io)
        socket_io = rte_lcore_to_socket_id(lcore_io)
        printf("Creating ring to connect worker lcore %u with TX port %u (through I/O lcore %u) (socket %u) ...\n", lcore, port, lcore_io, socket_io)
        snprintf(name, name.size, "app_ring_tx_s%u_w%u_p%u", socket_io, lcore, port)
        ring = rte_ring_create(name, @app.ring_tx_size, socket_io, RING_F_SP_ENQ | RING_F_SC_DEQ)

        lp.value.u.worker.rings_out.pointer_at(port).value = ring
        lp_io.value.u.io.tx.rings.pointer_at(port).value.pointer_at(lp.value.u.worker.worker_id).value = ring
      end
    end

    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)

      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.tx.n_nic_ports == 0

      lp.value.u.io.tx.n_nic_ports.times do |i|
        port = lp.value.u.io.tx.nic_ports[i]
        app_get_lcores_worker.times do |j|
          if lp.value.u.io.tx.rings[port][j].null?
            printf("port: %u, j: %u\n", port, j)
            fail("Algorithmic error (I/O TX rings)\n")
          end
        end
      end
    end
  end

  def app_init_nics
    lcore = 0_u32

    @port_conf.rxmode.mq_mode = RteEthRxMqMode::EthMqRxRss
    @port_conf.rxmode.flags = RteEthRxmodeFlags::IgnoreOffloadBitfield
    {% if LibDpdk::HAS_OFFLOAD %}
      @port_conf.rxmode.offloads = DEV_RX_OFFLOAD_CHECKSUM | DEV_RX_OFFLOAD_CRC_STRIP
    {% end %}
    @port_conf.rx_adv_conf.rss_conf.rss_hf = ETH_RSS_IP

    APP_MAX_NIC_PORTS.times do |port|
      n_rx_queues = app_get_nic_rx_queues_per_port(port)
      n_tx_queues = @app.nic_tx_port_mask[port]
      next if n_rx_queues == 0 && n_tx_queues == 0

      # Init port
      printf("Initializing NIC port %u ...\n", port)
      dev_info = uninitialized RteEthDevInfo
      LibDpdk.rte_eth_dev_info_get(port, pointerof(dev_info))
      txconf_ptr = configure_tx_offload(@port_conf, dev_info)

      rte_eth_dev_configure(port, n_rx_queues.to_u8, n_tx_queues.to_u8, pointerof(@port_conf))

      rte_eth_promiscuous_enable(port)

      nic_rx_ring_size = @app.nic_rx_ring_size.to_u16
      nic_tx_ring_size = @app.nic_tx_ring_size.to_u16
      rte_eth_dev_adjust_nb_rx_tx_desc(port, pointerof(nic_rx_ring_size), pointerof(nic_tx_ring_size))
      @app.nic_rx_ring_size = nic_rx_ring_size
      @app.nic_tx_ring_size = nic_tx_ring_size

      rxq_conf = dev_info.default_rxconf
      {% if LibDpdk::HAS_OFFLOAD %}
        rxq_conf.offloads = @port_conf.rxmode.offloads
      {% end %}

      # Init RX queues
      APP_MAX_RX_QUEUES_PER_NIC_PORT.times do |queue|
        next if @app.nic_rx_queue_mask.pointer_at(port).value[queue] == 0

        app_get_lcore_for_nic_rx(port, queue, pointerof(lcore))
        socket = rte_lcore_to_socket_id(lcore)
        pool = @app.lcore_params.pointer_at(lcore).value.pool

        printf("Initializing NIC port %u RX queue %u ...\n", port, queue)
        rte_eth_rx_queue_setup(port, queue, @app.nic_rx_ring_size, socket, pointerof(rxq_conf), pool)
      end

      # Init TX queues
      if @app.nic_tx_port_mask[port] == 1
        app_get_lcore_for_nic_tx(port, pointerof(lcore))
        socket = rte_lcore_to_socket_id(lcore)
        printf("Initializing NIC port %u TX queue 0 ...\n", port)
        rte_eth_tx_queue_setup(port, 0, @app.nic_tx_ring_size.to_u16, socket, txconf_ptr)
      end

      # Start port
      ret = rte_eth_dev_start(port)
    end

    check_all_ports_link_status(APP_MAX_NIC_PORTS, (~0x0))
  end

  # Check the link status of all ports in up to 9s, and print them finally
  def check_all_ports_link_status(nb_ports, port_mask)
    check_interval = 100 # 100ms
    max_check_time = 90  # 9s (90 * 100ms) in total
    print_flag = 0_u8
    link = uninitialized RteEthLink

    printf("\nChecking link status")
    fflush(stdout)

    max_check_time.times do |count|
      all_ports_up = 1_u8

      nb_ports.times do |portid|
        next if (port_mask & (1 << portid)) == 0

        n_rx_queues = app_get_nic_rx_queues_per_port(portid)
        n_tx_queues = @app.nic_tx_port_mask[portid]
        next if n_rx_queues == 0 && n_tx_queues == 0

        rte_eth_link_get_nowait(portid, pointerof(link))

        # print link status if flag set
        if print_flag == 1
          if link.link_flags.status_up?
            printf("Port%d Link Up - speed %uMbps - %s\n", portid, link.link_speed,
              link.link_flags.full_duplex? ? "full-duplex" : "half-duplex\n")
          else
            printf("Port %d Link Down\n", portid)
          end
          next
        end

        # clear all_ports_up flag if any link down
        if link.link_flags.none?
          all_ports_up = 0
          break
        end
      end

      # after finally printing all link status, get out
      break if print_flag == 1

      if all_ports_up == 0
        printf(".")
        fflush(stdout)
        rte_delay_us_block(check_interval * 1000)
      end

      # set the print_flag if all ports up or timeout
      if all_ports_up == 1 || count == max_check_time - 1
        print_flag = 1
        puts("done")
      end
    end
  end

  def app_init
    app_assign_worker_ids
    app_init_mbuf_pools
    app_init_lpm_tables
    app_init_rings_rx
    app_init_rings_tx
    app_init_nics

    printf("Initialization completed.\n")
  end
end
