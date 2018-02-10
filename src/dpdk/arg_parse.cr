require "./globals"
require "./stack_buffer"

struct ArgParse
  @@arg_buf = uninitialized UInt8[2048]
  @@buf = StackBuffer.new(@@arg_buf.to_unsafe)
  @@arg_names = uninitialized UInt8[32][16]
  @@arg_flags = uninitialized Bool[16]
  @@handlers = uninitialized (String -> Void)[16]
  @@invalid_option = ->(option : String) {}
  @@pos = 0

  def self.parse(argc, argv) : Void
    parser_buf = uninitialized UInt8[instance_sizeof(ArgParse)]
    parser = parser_buf.unsafe_as(ArgParse)
    yield parser
    parser.parse(argc, argv)
  end

  def <<(arg : String) : Void
    @@buf << arg
  end

  def parse(argc, argv) : Void
    i = 0
    while i < argc
      if flag_index = find_arg(argv[i])
        handler = @@handlers[flag_index]
        if @@arg_flags[flag_index]
          i += 1
          raise "out of bound" if i >= argc
          handler.call(String.new(argv[i]))
        else
          handler.call("")
        end
      else
        @@invalid_option.not_nil!.call(String.new(argv[i])) if @@invalid_option
      end
      i += 1
    end
  end

  def on(opt, help, &block : String ->) : Void
    append_buf do
      @@buf << opt
      @@buf.write_byte(32_u8, (20 - (opt.size))) if opt.size < 20
    end
    flag = !!(idx = opt.find(32_u8))
    memcpy(@@arg_names.pointer_at(@@pos), opt.to_unsafe, idx || opt.size)
    @@arg_flags[@@pos] = flag
    @@handlers[@@pos] = block
    @@pos += 1
  end

  def on(short, long, help, &block : String ->) : Void
    append_buf do
      @@buf << short
      @@buf << ", "
      @@buf << long
      if short.size + long.size < 18
        @@buf.write_byte(32_u8, (18 - (short.size + long.size)))
      end
    end
    flag = !!(idx = short.find(32_u8))
    @@arg_flags[@@pos] = flag
    memcpy(@@arg_names.pointer_at(@@pos), short.to_unsafe, idx || short.size)
    @@handlers[@@pos] = block
    @@pos += 1
    @@arg_flags[@@pos] = flag
    memcpy(@@arg_names.pointer_at(@@pos), long.to_unsafe, long.find(32_u8) || long.size)
    @@handlers[@@pos] = block
    @@pos += 1
  end

  def invalid_option(&@@invalid_option : String ->) : Void
  end

  def print_help : Void
    LibC.puts(@@buf)
  end

  private def find_arg(sub : UInt8*)
    @@pos.times do |i|
      return i if LibC.strcmp(@@arg_names.pointer_at(i).value, sub) == 0
    end
  end

  private macro append_buf
    @@buf << "    "
    {{yield}}
    @@buf << help
    @@buf << "\n"
  end
end
