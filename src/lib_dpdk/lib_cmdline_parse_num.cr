lib LibDpdk
  $cmdline_token_num_ops : CmdlineTokenOps
  enum CmdlineNumtype
    Uint8  = 0
    Uint16 = 1
    Uint32 = 2
    Uint64 = 3
    Int8   = 4
    Int16  = 5
    Int32  = 6
    Int64  = 7
  end
  fun cmdline_get_help_num(tk : CmdlineParseTokenHdrT*, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_parse_num(tk : CmdlineParseTokenHdrT*, srcbuf : LibC::Char*, res : Void*, ressize : LibC::UInt) : LibC::Int

  struct CmdlineTokenNum
    hdr : CmdlineTokenHdr
    num_data : CmdlineTokenNumData
  end

  struct CmdlineTokenNumData
    type : CmdlineNumtype
  end
end
