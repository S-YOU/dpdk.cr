lib LibDpdk
  alias EventdevPmdPciCallbackT = (RteEventdev* -> LibC::Int)
  fun rte_event_pmd_pci_probe(pci_drv : RtePciDriver*, pci_dev : RtePciDevice*, private_data_size : LibC::Int, devinit : EventdevPmdPciCallbackT) : LibC::Int
  fun rte_event_pmd_pci_remove(pci_dev : RtePciDevice*, devuninit : EventdevPmdPciCallbackT) : LibC::Int
end
