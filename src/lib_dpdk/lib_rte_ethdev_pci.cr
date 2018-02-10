lib LibDpdk
  alias EthDevPciCallbackT = (RteEthDev* -> LibC::Int)
  fun rte_eth_copy_pci_info(eth_dev : RteEthDev*, pci_dev : RtePciDevice*)
  fun rte_eth_dev_pci_allocate(dev : RtePciDevice*, private_data_size : LibC::Int) : RteEthDev*
  fun rte_eth_dev_pci_generic_probe(pci_dev : RtePciDevice*, private_data_size : LibC::Int, dev_init : EthDevPciCallbackT) : LibC::Int
  fun rte_eth_dev_pci_generic_remove(pci_dev : RtePciDevice*, dev_uninit : EthDevPciCallbackT) : LibC::Int
  fun rte_eth_dev_pci_release(eth_dev : RteEthDev*)
end
