lib LibDpdk
  enum RteHypervisor
    RteHypervisorNone    = 0
    RteHypervisorKvm     = 1
    RteHypervisorHyperv  = 2
    RteHypervisorVmware  = 3
    RteHypervisorUnknown = 4
  end
  fun rte_hypervisor_get : RteHypervisor
  fun rte_hypervisor_get_name(id : RteHypervisor) : LibC::Char*
end
