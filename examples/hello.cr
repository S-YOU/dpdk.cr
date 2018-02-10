require "../src/dpdk"

class Hello < Dpdk
  def hello_thread
    printf("Hello from lcore: %d\n", rte_lcore_id)
  end

  def main(argc, argv)
    rte_eal_init(argc, argv)
    rte_eal_mp_remote_launch(hello_thread)
    rte_eal_mp_wait_lcore
  end
end

Hello.run

## Run the program
## sudo build/hello

# EAL: Detected 4 lcore(s)
# EAL: Probing VFIO support...
# EAL: PCI device 0000:00:03.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# EAL: PCI device 0000:00:08.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100f net_e1000_em
# EAL: PCI device 0000:00:09.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100f net_e1000_em
# EAL: PCI device 0000:00:0a.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# EAL: PCI device 0000:00:10.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# EAL: PCI device 0000:00:11.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# EAL: PCI device 0000:00:12.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# EAL: PCI device 0000:00:13.0 on NUMA socket -1
# EAL:   Invalid NUMA socket, default to 0
# EAL:   probe driver: 8086:100e net_e1000_em
# Hello from lcore: 1
# Hello from lcore: 2
# Hello from lcore: 3
# Hello from lcore: 0
