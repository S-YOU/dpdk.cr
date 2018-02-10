lib LibDpdk
  fun pci_map_resource(requested_addr : Void*, fd : LibC::Int, offset : OffT, size : LibC::Int, additional_flags : LibC::Int) : Void*
  fun pci_unmap_resource(requested_addr : Void*, size : LibC::Int)

  struct PciMap
    addr : Void*
    path : LibC::Char*
    offset : Uint64T
    size : Uint64T
    phaddr : Uint64T
  end

  struct PciMsixTable
    bar_index : LibC::Int
    offset : Uint32T
    size : Uint32T
  end
end
