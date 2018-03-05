lib LibDpdk
  alias RteStatsBitrates = Void
  fun rte_stats_bitrate_calc(bitrate_data : RteStatsBitrates*, port_id : Uint8T) : LibC::Int
  fun rte_stats_bitrate_create : RteStatsBitrates*
  fun rte_stats_bitrate_reg(bitrate_data : RteStatsBitrates*) : LibC::Int
end
