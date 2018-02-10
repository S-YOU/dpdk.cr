lib LibDpdk
  struct HugepageFile
    orig_va : Void*
    final_va : Void*
    physaddr : Uint64T
    size : LibC::Int
    socket_id : LibC::Int
    file_id : LibC::Int
    memseg_id : LibC::Int
    filepath : LibC::Char[4096]
  end
end
