lib LibDpdk
  alias X__U8 = UInt8

  struct VhostIotlbMsg
    iova : X__U64
    size : X__U64
    uaddr : X__U64
    perm : X__U8
    type : X__U8
  end

  struct VhostMemory
    nregions : X__U32
    padding : X__U32
    regions : VhostMemoryRegion[0]
  end

  struct VhostMemoryRegion
    guest_phys_addr : X__U64
    memory_size : X__U64
    userspace_addr : X__U64
    flags_padding : X__U64
  end

  struct VhostMsg
    type : LibC::Int
  end

  struct VhostScsiTarget
    abi_version : LibC::Int
    vhost_wwpn : LibC::Char[224]
    vhost_tpgt : LibC::UShort
    reserved : LibC::UShort
  end

  struct VhostVringAddr
    index : LibC::UInt
    flags : LibC::UInt
    desc_user_addr : X__U64
    used_user_addr : X__U64
    avail_user_addr : X__U64
    log_guest_addr : X__U64
  end

  struct VhostVringFile
    index : LibC::UInt
    fd : LibC::Int
  end

  struct VhostVringState
    index : LibC::UInt
    num : LibC::UInt
  end
end
