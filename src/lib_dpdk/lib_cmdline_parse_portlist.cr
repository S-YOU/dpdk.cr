lib LibDpdk
  $cmdline_token_portlist_ops : CmdlineTokenOps
  fun cmdline_get_help_portlist(tk : CmdlineParseTokenHdrT*, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_parse_portlist(tk : CmdlineParseTokenHdrT*, srcbuf : LibC::Char*, res : Void*, ressize : LibC::UInt) : LibC::Int

  struct CmdlinePortlist
    map : Uint32T
  end

  struct CmdlineTokenPortlist
    hdr : CmdlineTokenHdr
  end
end
