lib LibDpdk
  fun eal_cpu_core_id(lcore_id : LibC::UInt) : LibC::UInt
  fun eal_cpu_detected(lcore_id : LibC::UInt) : LibC::Int
  fun eal_log_set_default(default_log : File*)
  fun eal_parse_pci_bdf = eal_parse_pci_BDF(input : LibC::Char*, dev_addr : RtePciAddr*) : LibC::Int
  fun eal_parse_pci_dom_bdf = eal_parse_pci_DomBDF(input : LibC::Char*, dev_addr : RtePciAddr*) : LibC::Int
  fun rte_bus_find_by_device_name(str : LibC::Char*) : RteBus*
  fun rte_eal_alarm_init : LibC::Int
  fun rte_eal_check_module(module_name : LibC::Char*) : LibC::Int
  fun rte_eal_cpu_init : LibC::Int
  fun rte_eal_hugepage_attach : LibC::Int
  fun rte_eal_hugepage_init : LibC::Int
  fun rte_eal_intr_init : LibC::Int
  fun rte_eal_log_init(id : LibC::Char*, facility : LibC::Int) : LibC::Int
  fun rte_eal_memory_init : LibC::Int
  fun rte_eal_memzone_init : LibC::Int
  fun rte_eal_tailqs_init : LibC::Int
  fun rte_eal_timer_init : LibC::Int
  fun rte_eal_using_phys_addrs : LibC::Int
  fun rte_pci_add_device(pci_dev : RtePciDevice*)
  fun rte_pci_insert_device(exist_pci_dev : RtePciDevice*, new_pci_dev : RtePciDevice*)
  fun rte_pci_remove_device(pci_device : RtePciDevice*)
end
