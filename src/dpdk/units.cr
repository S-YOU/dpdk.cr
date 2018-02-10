require "../lib_dpdk"

class Dpdk
  # SI Measure Units (T, G, M, k) to number converter
  macro apply_from_si_measure(var, s)
    {{var}} = {{s}}.upcase.sub("G", "000000000").sub("M", "000000").sub("K", "000").to_u64.unsafe_as(typeof({{var}}))
  end

  # number to SI Measure Units (T, G, M, k) string converter
  macro to_si_measure(n)
    if {{n}} >= 1000000000 && {{n}} % 1000000000 == 0
      "#{{{n}} / 1000000000}G"
    elsif {{n}} >= 1000000 && {{n}} % 1000000 == 0
      "#{{{n}} / 1000000}M"
    elsif {{n}} >= 1000 && {{n}} % 1000 == 0
      "#{{{n}} / 1000}k"
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
      "#{{{n}} / 1000000}s"
    elsif {{n}} >= 1000
      "#{{{n}} / 1000}ms"
    else
      "#{{{n}}}us"
    end
  end
end
