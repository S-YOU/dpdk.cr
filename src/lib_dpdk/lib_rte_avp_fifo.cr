lib LibDpdk
  fun avp_fifo_count(fifo : RteAvpFifo*) : LibC::UInt
  fun avp_fifo_free_count(fifo : RteAvpFifo*) : LibC::UInt
  fun avp_fifo_get(fifo : RteAvpFifo*, data : Void**, num : LibC::UInt) : LibC::UInt
  fun avp_fifo_init(fifo : RteAvpFifo*, size : LibC::UInt)
  fun avp_fifo_put(fifo : RteAvpFifo*, data : Void**, num : LibC::UInt) : LibC::UInt
end
