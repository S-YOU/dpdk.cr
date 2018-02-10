require "../lib_dpdk"

# Crystal bindings to Intel's DPDK
abstract class Dpdk
  # :nodoc:
  forward_missing_to LibDpdk

  # :nodoc:
  abstract def main(argc, argv) : Void

  macro inherited
    def self.instance
      @@instance ||= new
    end

    def self.run
      self.instance.main(ARGC_UNSAFE, ARGV_UNSAFE)
    end

    private def initialize; end
  end
end
