lib LibDpdk
  $cmdline_token_etheraddr_ops : CmdlineTokenOps
  fun cmdline_get_help_etheraddr(tk : CmdlineParseTokenHdrT*, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_parse_etheraddr(tk : CmdlineParseTokenHdrT*, srcbuf : LibC::Char*, res : Void*, ressize : LibC::UInt) : LibC::Int

  struct CmdlineTokenEtheraddr
    hdr : CmdlineTokenHdr
  end
end
