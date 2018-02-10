lib LibC
  alias UsecondsT = UInt32
  fun usleep(usec : UsecondsT)
  fun calloc(count : SizeT, size : SizeT) : UInt8*
  fun free(ptr : Void*)
  fun putchar(c : Char)
  fun sprintf(s : Char*, format : Char*, ...) : Int
  fun fprintf(stream : Void*, format : Char*, ...) : Int
  fun fflush(stream : Void*)
  fun puts(s : Char*)
  fun fputs(s : Char*, fd : Void*)
  fun fdopen(fd : Int32, mode : Char*) : Void*
  fun getline(s : Char**, size : SizeT*, fd : Void*) : Int32
  fun perror(s : Char*)

  $stdin : Void*
  $stdout : Void*
  $stderr : Void*
end
