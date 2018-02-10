class Dpdk
  # SI Measure Units (T, G, M, k) to number converter
  macro apply_from_si_measure(var, s)
    {{var}} = {{s}}.upcase.sub("G", "000000000").sub("M", "000000").sub("K", "000").to_u64.unsafe_as(typeof({{var}}))
  end

  # number to SI Measure Units (T, G, M, k) string converter
  macro to_si_measure(n)
    if {{n}} >= 1000000000 && {{n}} % 1000000000 == 0
      ({{n}} / 1000000000).to_s + "G"
    elsif {{n}} >= 1000000 && {{n}} % 1000000 == 0
      ({{n}} / 1000000).to_s + "M"
    elsif {{n}} >= 1000 && {{n}} % 1000 == 0
      ({{n}} / 1000).to_s + "k"
    else
      {{n}}.to_s
    end
  end

  # SI Time Units (s, ms, us) to number converter
  macro apply_from_si_time(var, s)
    {{var}} = {{s}}.downcase.sub("us", "").sub("ms", "000").sub("s", "000000").to_u64.unsafe_as(typeof({{var}}))
  end

  # number to SI Time Units (s, ms, us) string converter
  macro to_si_time(n)
    if {{n}} >= 1000000
      ({{n}} / 1000000).to_s + "s"
    elsif {{n}} >= 1000
      ({{n}} / 1000).to_s + "ms"
    else
      ({{n}}).to_s + "us"
    end
  end

  macro ipv4(a, b, c, d)
    {{((d << 24) + (c << 16) + (b << 8) + a)}}_u32
  end

  macro ipv4x(a, b, c, d)
    {{((d << 24) + (c << 16) + (b << 8) + a)}}.to_u32
  end

  macro b16(x)
    {{(((x >> 8) & 0x00FF) | ((x << 8) & 0xFF00))}}_u16
  end

  macro b32(x)
    {{(((x >> 24) & 0x000000FF) | ((x >> 8) & 0x0000FF00) | ((x << 8) & 0x00FF0000) | ((x << 24) & 0xFF000000))}}_u32
  end
end
