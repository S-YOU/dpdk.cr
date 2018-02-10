lib LibDpdk
  fun rdline_add_history(rdl : Rdline*, buf : LibC::Char*) : LibC::Int
  fun rdline_char_in(rdl : Rdline*, c : LibC::Char) : LibC::Int
  fun rdline_clear_history(rdl : Rdline*)
  fun rdline_get_buffer(rdl : Rdline*) : LibC::Char*
  fun rdline_get_history_item(rdl : Rdline*, i : LibC::UInt) : LibC::Char*
  fun rdline_init(rdl : Rdline*, write_char : (Rdline*, LibC::Char -> LibC::Int), validate : (Rdline*, LibC::Char*, LibC::UInt -> Void), complete : (Rdline*, LibC::Char*, LibC::Char*, LibC::UInt, LibC::Int* -> LibC::Int)) : LibC::Int
  fun rdline_newline(rdl : Rdline*, prompt : LibC::Char*)
  fun rdline_quit(rdl : Rdline*)
  fun rdline_redisplay(rdl : Rdline*)
  fun rdline_reset(rdl : Rdline*)
  fun rdline_restart(rdl : Rdline*)
  fun rdline_stop(rdl : Rdline*)
end
