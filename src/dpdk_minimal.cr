require "./lib_dpdk_minimal"

require "./dpdk/lib_c"
require "./dpdk/lib_llvm"
require "./dpdk/version"
require "./dpdk/constants"
require "./dpdk/constants_extras"
require "./dpdk/packet_constants"
require "./dpdk/globals"
require "./dpdk/core"
require "./dpdk/asm"
require "./dpdk/llvm"
require "./dpdk/natives"
require "./dpdk/aliases_minimal"
require "./dpdk/macros_defines"
require "./dpdk/macros_overrides"
require "./dpdk/macros_overloads"
require "./dpdk/inlines"
require "./dpdk/packets"
require "./dpdk/extras"
require "./dpdk/units"
require "./dpdk/atomic_pointer"
require "./dpdk/patches"
require "./dpdk/debug"

class Dpdk
  include Constants
end
