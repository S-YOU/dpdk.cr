module Kni
  @kni_host = Pointer(LibDpdk::RteKni).null
  @kni_mirror = false

  macro setup_kni_host
    if @kni_host
      @kni_host = kni_create("kni_host", pool, port, rte_lcore_id, 1)
      kni_setup_ip("kni_host", SELF_IP, LOOPBACK_IP, SELF_IPV6, ROUTES.to_unsafe, ROUTES.size, NEXT_HOP)
    end
  end

  macro setup_kni_mirror(*args)
    if @kni_mirror
      {% for arg in args %}
        kni_{{arg}} = kni_create("kni_{{arg}}", pool, port, rte_lcore_id, 0)
      {% end %}
    end
  end

  macro cleanup_kni(*args)
    {% for arg in args %}
      LibDpdk.rte_kni_release(kni_{{arg}})
    {% end %}
  end

  private macro kni_rx_to_ring
    nb_rx = rte_kni_rx_burst(@kni_host, pkts, MAX_PKTS_BURST).to_u16
    next if nb_rx == 0

    nb_tx = rte_ring_enqueue_burst(ring, pkts, nb_rx, nil)
    while unlikely(nb_tx < nb_rx)
      nb_tx += rte_ring_enqueue_burst(ring, pkts + nb_tx, nb_rx - nb_tx, nil)
    end
  end

  private macro rte_kni_tx_burst(kni, pkts_, nb_rx_)
    if {{nb_rx_}} > 0
      nb_tx = LibDpdk.rte_kni_tx_burst({{kni}}, {{pkts_}}, {{nb_rx_}})
      while unlikely(nb_tx < {{nb_rx_}})
        nb_tx += LibDpdk.rte_kni_tx_burst({{kni}}, {{pkts_}} + nb_tx, {{nb_rx_}} - nb_tx)
      end
    end
  end

  private macro clone_to_kni_mbufs(name)
    clone_to_mbufs {{name}} if @kni_mirror
  end

  private macro copy_to_kni_mbufs(name)
    copy_to_mbufs {{name}} if @kni_mirror
  end

  private macro clone_to_kni_host_mbufs
    clone_to_mbufs host if @kni_host
  end

  private macro copy_to_kni_host_mbufs
    copy_to_mbufs host if @kni_host
  end
end
