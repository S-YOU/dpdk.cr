require "c/arpa/inet"
require "option_parser"
require "../../src/dpdk"

class LoadBalancer < Dpdk
  def app_print_usage
    usage = "
    load_balancer <EAL PARAMS> -- <APP PARAMS>

Application manadatory parameters:
  --rx \ (PORT, QUEUE, LCORE), ...\  : List of NIC RX ports and queues
         handled by the I/O RX lcores
  --tx \ (PORT, LCORE), ...\  : List of NIC TX ports handled by the I/O TX
         lcores
  --w \ LCORE, ...\  : List of the worker lcores
  --lpm \ IP / PREFIX => PORT; ...\  : List of LPM rules used by the worker
         lcores for packet forwarding

Application optional parameters:
  --rsz \ A, B, C, D\  : Ring sizes
         A = Size (in number of buffer descriptors) of each of the NIC RX
             rings read by the I/O RX lcores (default value is %u)
         B = Size (in number of elements) of each of the SW rings used by the
             I/O RX lcores to send packets to worker lcores (default value is
             %u)
         C = Size (in number of elements) of each of the SW rings used by the
             worker lcores to send packets to I/O TX lcores (default value is
             %u)
         D = Size (in number of buffer descriptors) of each of the NIC TX
             rings written by I/O TX lcores (default value is %u)
  --bsz \ (A, B), (C, D), (E, F)\  :  Burst sizes
         A = I/O RX lcore read burst size from NIC RX (default value is %u)
         B = I/O RX lcore write burst size to output SW rings (default value
             is %u)
         C = Worker lcore read burst size from input SW rings (default value
             is %u)
         D = Worker lcore write burst size to output SW rings (default value
             is %u)
         E = I/O TX lcore read burst size from input SW rings (default value
             is %u)
         F = I/O TX lcore write burst size to NIC TX (default value is %u)
  --pos-lb POS : Position of the 1-byte field within the input packet used by
         the I/O RX lcores to identify the worker lcore for the current
         packet (default value is %u)
"
    printf(usage,
      APP_DEFAULT_NIC_RX_RING_SIZE,
      APP_DEFAULT_RING_RX_SIZE,
      APP_DEFAULT_RING_TX_SIZE,
      APP_DEFAULT_NIC_TX_RING_SIZE,
      APP_DEFAULT_BURST_SIZE_IO_RX_READ,
      APP_DEFAULT_BURST_SIZE_IO_RX_WRITE,
      APP_DEFAULT_BURST_SIZE_WORKER_READ,
      APP_DEFAULT_BURST_SIZE_WORKER_WRITE,
      APP_DEFAULT_BURST_SIZE_IO_TX_READ,
      APP_DEFAULT_BURST_SIZE_IO_TX_WRITE,
      APP_DEFAULT_IO_RX_LB_POS
    )
  end

  def parse_arg_w(arg)
    lcores = arg.split(',').map &.to_u32
    lcores.each do |lcore|
      @app.lcore_params.pointer_at(lcore).value.type = LibLoadBalancer::AppLcoreType::EAppLcoreWorker
    end
  end

  def parse_arg_rx(arg)
    matches = arg.scan(/\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/) # (0,0,3)
    matches.each do |m|
      port, queue, lcore = m[1].to_u32, m[2].to_u8, m[3].to_u32
      @app.nic_rx_queue_mask.pointer_at(port).value.pointer_at(queue).value = 1_u8
      lp = @app.lcore_params.pointer_at(lcore)
      lp.value.type = LibLoadBalancer::AppLcoreType::EAppLcoreIo
      n_nic_queues = lp.value.u.io.rx.n_nic_queues
      lp.value.u.io.rx.nic_queues.pointer_at(n_nic_queues).value.port = port
      lp.value.u.io.rx.nic_queues.pointer_at(n_nic_queues).value.queue = queue
      lp.value.u.io.rx.n_nic_queues = lp.value.u.io.rx.n_nic_queues + 1
      # TODO: add error check
    end
  end

  def parse_arg_tx(arg)
    matches = arg.scan(/\(\s*(\d+)\s*,\s*(\d+)\s*\)/) # (0,4)
    matches.each do |m|
      port, lcore = m[1].to_u16, m[2].to_u32
      @app.nic_tx_port_mask.pointer_at(port).value = 1_u8
      lp = @app.lcore_params.pointer_at(lcore)
      lp.value.type = LibLoadBalancer::AppLcoreType::EAppLcoreIo
      n_nic_ports = lp.value.u.io.tx.n_nic_ports
      lp.value.u.io.tx.nic_ports[n_nic_ports] = port
      lp.value.u.io.tx.n_nic_ports = lp.value.u.io.tx.n_nic_ports + 1
      # TODO: add error check
    end
  end

  def parse_arg_lpm(arg)
    matches = arg.scan(/(\d+.\d+.\d+.\d+)\s*\/\s*(\d+)\s*=>\s*(\d+)/) # 1.0.0.0/23=>0
    matches.each do |m|
      ip, depth, if_out = pton(m[1]), m[2].to_u8, m[3].to_u8
      n_lpm_rules = @app.n_lpm_rules
      @app.lpm_rules.pointer_at(n_lpm_rules).value.ip = ip
		  @app.lpm_rules.pointer_at(n_lpm_rules).value.depth = depth
		  @app.lpm_rules.pointer_at(n_lpm_rules).value.if_out = if_out
      pointerof(@app.@n_lpm_rules).value += 1
      # TODO : add error check
    end
  end

  def parse_arg_pos_lb(arg)
    @app.pos_lb = arg.to_u8
    # TODO : add error check
  end

  def app_parse_args
    arg_rsz = arg_bsz = arg_pos_lb = 0
    OptionParser.parse! do |opts|
      opts.on("--w LCORE, ...", "List of the worker lcores") { |arg| arg_ret_check(w,arg) }
      opts.on("--rx (PORT, QUEUE, LCORE), ...", "List of NIC RX ports and queues handled by the I/O RX lcores") { |arg| arg_ret_check(rx,arg) }
      opts.on("--tx (PORT, LCORE), ...", "List of NIC TX ports handled by the I/O TX lcores") { |arg| arg_ret_check(tx,arg) }
      opts.on("--lpm IP / PREFIX => PORT; ...", "List of LPM rules used by the worker lcores for packet forwarding") { |arg| arg_ret_check(lpm,arg) }
      opts.on("--pos-lb POS", "Position of the 1-byte field within the input packet") { |arg| arg_ret_check(pos_lb,arg) }
      opts.invalid_option do |arg|
        app_print_usage
        fail("Invalid arguments: %s\n", arg)
      end
    end

    if arg_rsz == 0
      @app.nic_rx_ring_size = APP_DEFAULT_NIC_RX_RING_SIZE
      @app.nic_tx_ring_size = APP_DEFAULT_NIC_TX_RING_SIZE
      @app.ring_rx_size = APP_DEFAULT_RING_RX_SIZE
      @app.ring_tx_size = APP_DEFAULT_RING_TX_SIZE
    end

    if arg_bsz == 0
      @app.burst_size_io_rx_read = APP_DEFAULT_BURST_SIZE_IO_RX_READ
      @app.burst_size_io_rx_write = APP_DEFAULT_BURST_SIZE_IO_RX_WRITE
      @app.burst_size_io_tx_read = APP_DEFAULT_BURST_SIZE_IO_TX_READ
      @app.burst_size_io_tx_write = APP_DEFAULT_BURST_SIZE_IO_TX_WRITE
      @app.burst_size_worker_read = APP_DEFAULT_BURST_SIZE_WORKER_READ
      @app.burst_size_worker_write = APP_DEFAULT_BURST_SIZE_WORKER_WRITE
    end

    if arg_pos_lb == 0
      @app.pos_lb = APP_DEFAULT_IO_RX_LB_POS
    end

    # Check cross-consistency of arguments
    if (ret = app_check_lpm_table) < 0
      fail("At least one LPM rule is inconsistent (%d)\n", ret)
    end

    if app_check_every_rx_port_is_tx_enabled < 0
      fail("On LPM lookup miss, packet is sent back on the input port.
At least one RX port is not enabled for TX.\n")
    end
  end

  def app_print_params
    # Print NIC RX configuration
    printf("NIC RX ports: ")
    APP_MAX_NIC_PORTS.times do |port|
      n_rx_queues = app_get_nic_rx_queues_per_port(port)
      next if n_rx_queues == 0

      printf("%u (", port)
      APP_MAX_RX_QUEUES_PER_NIC_PORT.times do |queue|
        if @app.nic_rx_queue_mask[port][queue] == 1
          printf("%u ", queue)
        end
      end
      printf(")  ")
    end
    printf(";\n")

    # Print I/O lcore RX params
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.rx.n_nic_queues == 0

      printf("I/O lcore %u (socket %u): ", lcore, rte_lcore_to_socket_id(lcore))

      printf("RX ports  ")
      lp.value.u.io.rx.n_nic_queues.times do |i|
        printf("(%u, %u)  ", lp.value.u.io.rx.nic_queues[i].port, lp.value.u.io.rx.nic_queues[i].queue)
      end
      printf("; ")

      printf("Output rings  ")
      lp.value.u.io.rx.n_rings.times do |i|
        printf("%p  ", lp.value.u.io.rx.rings[i])
      end
      printf(";\n")
    end

    # Print worker lcore RX params
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_worker?

      printf("Worker lcore %u (socket %u) ID %u: ", lcore, rte_lcore_to_socket_id(lcore), lp.value.u.worker.worker_id)

      printf("Input rings  ")
      lp.value.u.worker.n_rings_in.times do |i|
        printf("%p  ", lp.value.u.worker.rings_in[i])
      end

      printf(";\n")
    end

    printf("\n")

    # Print NIC TX configuration
    printf("NIC TX ports:  ")
    APP_MAX_NIC_PORTS.times do |port|
      printf("%u  ", port) if @app.nic_tx_port_mask[port] == 1
    end
    printf(";\n")

    # Print I/O TX lcore params
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      n_workers = app_get_lcores_worker

      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.tx.n_nic_ports == 0

      printf("I/O lcore %u (socket %u): ", lcore, rte_lcore_to_socket_id(lcore))

      printf("Input rings per TX port  ")
      lp.value.u.io.tx.n_nic_ports.times do |i|
        port = lp.value.u.io.tx.nic_ports[i]

        printf("%u (", port)
        n_workers.times do |j|
          printf("%p  ", lp.value.u.io.tx.rings[port][j])
        end
        printf(")  ")
      end
      printf(";\n")
    end

    # Print worker lcore TX params
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_worker?

      printf("Worker lcore %u (socket %u) ID %u: \n", lcore, rte_lcore_to_socket_id(lcore), lp.value.u.worker.worker_id)

      printf("Output rings per TX port  ")
      APP_MAX_NIC_PORTS.times do |port|
        unless lp.value.u.worker.rings_out[port].null?
          printf("%u (%p)  ", port, lp.value.u.worker.rings_out[port])
        end
      end

      printf(";\n")
    end

    # Print LPM rules
    printf("LPM rules: \n")
    @app.n_lpm_rules.times do |rule|
      ip = @app.lpm_rules[rule].ip
      depth = @app.lpm_rules[rule].depth
      if_out = @app.lpm_rules[rule].if_out

      printf("\t%u: %u.%u.%u.%u/%hhu => %hhu;\n",
        rule,
        (ip & 0xFF000000) >> 24,
        (ip & 0x00FF0000) >> 16,
        (ip & 0x0000FF00) >> 8,
        ip & 0x000000FF,
        depth,
        if_out
      )
    end

    # Rings
    printf("Ring sizes: NIC RX = %u; Worker in = %u; Worker out = %u; NIC TX = %u;\n",
      @app.nic_rx_ring_size,
      @app.ring_rx_size,
      @app.ring_tx_size,
      @app.nic_tx_ring_size)

    # Bursts
    printf("Burst sizes: I/O RX (rd = %u, wr = %u); Worker (rd = %u, wr = %u); I/O TX (rd = %u, wr = %u)\n",
      @app.burst_size_io_rx_read,
      @app.burst_size_io_rx_write,
      @app.burst_size_worker_read,
      @app.burst_size_worker_write,
      @app.burst_size_io_tx_read,
      @app.burst_size_io_tx_write)
  end

  def app_get_nic_rx_queues_per_port(port)
    return -1 if port >= APP_MAX_NIC_PORTS
    count = 0
    APP_MAX_RX_QUEUES_PER_NIC_PORT.times do |i|
      count += 1 if @app.nic_rx_queue_mask.pointer_at(port).value[i] == 1
    end
    count
  end

  def app_get_lcores_io_rx
    count = 0_u32
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next if !lp.value.type.e_app_lcore_io? || lp.value.u.io.rx.n_nic_queues == 0
      count += 1
    end
    count
  end

  def app_get_lcores_worker
    count = 0_u32
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_worker?
      count += 1
    end

    fail("Algorithmic error (too many worker lcores)\n") if count > APP_MAX_WORKER_LCORES
    count
  end

  def app_get_lcore_for_nic_rx(port, queue, lcore_out : UInt32*)
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_io?

      n_queues = rte_min(lp.value.u.io.rx.n_nic_queues, lp.value.u.io.rx.nic_queues.size)
      n_queues.times do |i|
        if lp.value.u.io.rx.nic_queues.pointer_at(i).value.port == port &&
          lp.value.u.io.rx.nic_queues.pointer_at(i).value.queue == queue
          lcore_out.value = lcore.to_u32
          return 0
        end
      end
    end
    -1
  end

  def app_get_lcore_for_nic_tx(port, lcore_out : UInt32*)
    APP_MAX_LCORES.times do |lcore|
      lp = @app.lcore_params.pointer_at(lcore)
      next unless lp.value.type.e_app_lcore_io?

      n_ports = rte_min(lp.value.u.io.tx.n_nic_ports, lp.value.u.io.tx.nic_ports.size)
      n_ports.times do |i|
        if lp.value.u.io.tx.nic_ports[i] == port
          lcore_out.value = lcore.to_u32
          return 0
        end
      end
    end
    -1
  end

  private def app_check_lpm_table
    @app.n_lpm_rules.times do |rule|
      port = @app.lpm_rules.pointer_at(rule).value.if_out
      return -1 if @app.nic_tx_port_mask[port] == 0
    end
    0
  end

  private def app_check_every_rx_port_is_tx_enabled
    APP_MAX_NIC_PORTS.times do |port|
		  return -1 if app_get_nic_rx_queues_per_port(port) > 0 && @app.nic_tx_port_mask[port] == 0
    end
    0
  end

  private macro arg_ret_check(type, arg)
    arg_{{type}} = 1
    parse_arg_{{type}}({{arg}})
  end

  private def pton(address) : UInt32
    addr = uninitialized LibC::InAddr
    return Intrinsics.bswap32(addr.s_addr) if LibC.inet_pton(LibC::AF_INET, address, pointerof(addr)) == 1
    0_u32
  end
end
