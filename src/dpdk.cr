require "./lib_dpdk"

require "./dpdk/lib_c"
require "./dpdk/version"
require "./dpdk/constants"
require "./dpdk/constants_extras"
require "./dpdk/core"
require "./dpdk/asm"
require "./dpdk/llvm"
require "./dpdk/natives"
require "./dpdk/aliases"
require "./dpdk/macros_defines"
require "./dpdk/macros_overrides"
require "./dpdk/macros_overloads"
require "./dpdk/inlines"
require "./dpdk/extras"
require "./dpdk/patches"
require "./dpdk/debug"

class Dpdk
  include Constants
end
