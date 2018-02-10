lib LibDpdk
  fun cmdline_file_new(ctx : CmdlineParseCtxT*, prompt : LibC::Char*, path : LibC::Char*) : Cmdline*
  fun cmdline_stdin_exit(cl : Cmdline*)
  fun cmdline_stdin_new(ctx : CmdlineParseCtxT*, prompt : LibC::Char*) : Cmdline*
end
