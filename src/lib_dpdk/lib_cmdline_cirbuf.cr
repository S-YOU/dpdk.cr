lib LibDpdk
  fun cirbuf_add_buf_head(cbuf : Cirbuf*, c : LibC::Char*, n : LibC::UInt) : LibC::Int
  fun cirbuf_add_buf_tail(cbuf : Cirbuf*, c : LibC::Char*, n : LibC::UInt) : LibC::Int
  fun cirbuf_add_head(cbuf : Cirbuf*, c : LibC::Char)
  fun cirbuf_add_head_safe(cbuf : Cirbuf*, c : LibC::Char) : LibC::Int
  fun cirbuf_add_tail(cbuf : Cirbuf*, c : LibC::Char)
  fun cirbuf_add_tail_safe(cbuf : Cirbuf*, c : LibC::Char) : LibC::Int
  fun cirbuf_align_left(cbuf : Cirbuf*) : LibC::Int
  fun cirbuf_align_right(cbuf : Cirbuf*) : LibC::Int
  fun cirbuf_del_buf_head(cbuf : Cirbuf*, size : LibC::UInt) : LibC::Int
  fun cirbuf_del_buf_tail(cbuf : Cirbuf*, size : LibC::UInt) : LibC::Int
  fun cirbuf_del_head(cbuf : Cirbuf*)
  fun cirbuf_del_head_safe(cbuf : Cirbuf*) : LibC::Int
  fun cirbuf_del_tail(cbuf : Cirbuf*)
  fun cirbuf_del_tail_safe(cbuf : Cirbuf*) : LibC::Int
  fun cirbuf_get_buf_head(cbuf : Cirbuf*, c : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cirbuf_get_buf_tail(cbuf : Cirbuf*, c : LibC::Char*, size : LibC::UInt) : LibC::Int
  fun cirbuf_get_head(cbuf : Cirbuf*) : LibC::Char
  fun cirbuf_get_tail(cbuf : Cirbuf*) : LibC::Char
  fun cirbuf_init(cbuf : Cirbuf*, buf : LibC::Char*, start : LibC::UInt, maxlen : LibC::UInt) : LibC::Int
end
