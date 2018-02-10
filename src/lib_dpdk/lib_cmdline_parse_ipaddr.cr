lib LibDpdk
  $cmdline_token_ipaddr_ops : CmdlineTokenOps
  fun cmdline_get_help_ipaddr(tk : CmdlineParseTokenHdrT*, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_parse_ipaddr(tk : CmdlineParseTokenHdrT*, srcbuf : LibC::Char*, res : Void*, ressize : LibC::UInt) : LibC::Int

  struct CmdlineIpaddr
    family : Uint8T
    addr : CmdlineIpaddrAddr
    prefixlen : LibC::UInt
  end

  struct CmdlineTokenIpaddr
    hdr : CmdlineTokenHdr
    ipaddr_data : CmdlineTokenIpaddrData
  end

  struct CmdlineTokenIpaddrData
    flags : Uint8T
  end

  union CmdlineIpaddrAddr
    ipv4 : InAddr
    ipv6 : In6Addr
  end
end
