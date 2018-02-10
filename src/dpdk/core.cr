# Crystal bindings to Intel's DPDK
abstract class Dpdk
  # :nodoc:
  abstract def main(argc, argv) : Void

  macro inherited
    # :nodoc:
    forward_missing_to LibDpdk

    # :nodoc:
    def self.instance
      @@instance ||= new
    end

    # :nodoc:
    def self.run
      self.instance.main(ARGC_UNSAFE, ARGV_UNSAFE)
    end

    # :nodoc:
    private def initialize; end
  end
end
