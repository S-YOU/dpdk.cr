lib LibDpdk
  struct IpMreq
    imr_multiaddr : InAddr
    imr_interface : InAddr
  end

  struct IpMreqSource
    imr_multiaddr : InAddr
    imr_interface : InAddr
    imr_sourceaddr : InAddr
  end

  struct IpMreqn
    imr_multiaddr : InAddr
    imr_address : InAddr
    imr_ifindex : LibC::Int
  end

  struct IpMsfilter
    imsf_multiaddr : InAddr
    imsf_interface : InAddr
    imsf_fmode : Uint32T
    imsf_numsrc : Uint32T
    imsf_slist : InAddr[1]
  end

  struct IpOpts
    ip_dst : InAddr
    ip_opts : LibC::Char[40]
  end

  struct Ipv6Mreq
    ipv6mr_multiaddr : In6Addr
    ipv6mr_interface : LibC::UInt
  end
end
