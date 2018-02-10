require "../lib_dpdk"

class Dpdk
  # char* to mac address format
  @[AlwaysInline]
  def mac_to_s(mac : UInt8*)
    sprintf("%02X:%02X:%02X:%02X:%02X:%02X", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5])
  end

  @[AlwaysInline]
  def macaddr_get(port)
    addr = uninitialized LibDpdk::EtherAddr
    rte_eth_macaddr_get(port, pointerof(addr))
    mac_to_s(addr.addr_bytes.to_unsafe)
  end

  # set txmode.offloads and return txconf pointer
  macro configure_tx_offload(port_conf, dev_info)
    txconf = pointerof({{dev_info}}.@default_txconf)
    {% if LibDpdk::HAS_OFFLOAD %}
      unless ({{dev_info}}.tx_offload_capa & DEV_TX_OFFLOAD_MBUF_FAST_FREE) == 0
        pointerof({{port_conf}}.@txmode.@offloads).value |= DEV_TX_OFFLOAD_MBUF_FAST_FREE
      end
      txconf.value.txq_flags = ETH_TXQ_FLAGS_IGNORE
      txconf.value.offloads = {{port_conf}}.txmode.offloads
    {% end %}
    txconf
  end
end
