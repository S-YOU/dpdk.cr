# memcpy, non-overlap
macro memcpy(dst, src, len)
  Intrinsics.memcpy({{dst}}, {{src}}, {{len}}, 0_u32, false)
end

# memmove, can overlap
macro memmove(dst, src, len)
  Intrinsics.memmove({{dst}}, {{src}}, {{len}}, 0_u32, false)
end

# memset
macro memset(dst, val, len)
  Intrinsics.memset({{dst}}, {{val}}, {{len}}, 0_u32, false)
end
