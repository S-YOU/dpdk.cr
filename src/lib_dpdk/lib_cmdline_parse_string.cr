lib LibDpdk
  $cmdline_token_string_ops : CmdlineTokenOps
  fun cmdline_complete_get_elt_string(tk : CmdlineParseTokenHdrT*, idx : LibC::Int, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_complete_get_nb_string(tk : CmdlineParseTokenHdrT*) : LibC::Int
  fun cmdline_get_help_string(tk : CmdlineParseTokenHdrT*, dstbuf : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cmdline_parse_string(tk : CmdlineParseTokenHdrT*, srcbuf : LibC::Char*, res : Void*, ressize : LibC::UInt) : LibC::Int

  struct CmdlineTokenString
    hdr : CmdlineTokenHdr
    string_data : CmdlineTokenStringData
  end

  struct CmdlineTokenStringData
    str : LibC::Char*
  end
end
