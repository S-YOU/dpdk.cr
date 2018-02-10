## [dpdk.cr](https://github.com/s-you/dpdk.cr)
Crystal bindings to [DPDK](http://dpdk.org), development in progress.

### Hello World (examples/hello.cr)
```crystal
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
```

### Requirements
- Crystal (0.24.1)
- Recent Clang (5.0) or GCC, make and coreutils
- Working DPDK (18.02, 17.11(branch), 17.08(branch)), with RTE_SDK environment variable is set
  (Works with or without shared library enabled)

### Documentation
[https://s-you.github.io/dpdk.cr/docs/index.html](https://s-you.github.io/dpdk.cr/docs/index.html)

### Building
```
% make help

targets:
  all             Build all files (currently dpdk only) [default]
  clean           Clean up built directories and files
  clean_examples  Clean up examples
  docs            Generate standard library documentation
  dpdk            Build the library
  help            Show this help
  spec            Run all specs

optional variables:
  debug           Add symbolic debug info (not full)
  progress        Enable progress output [default]
  release         Compile in release mode [default]
  stats           Enable statistics output
  threads         Maximum number of threads to use
  verbose         Run specs in verbose mode

recipes:
  Build an example from examples/ directory and output in build/ directory
    % make hello
  Enable stats output of example
    % make l2fwd stats=1
  Build an example in non release mode
    % make hello release=
  Clean up built files then the library
    % make clean

```

### Compiling an example
```
% make hello
```

### Running an example
- Output depends on number of CPU and NICs available on your machine.

```
 % sudo build/hello
EAL: Detected 10 lcore(s)
EAL: Probing VFIO support...
EAL: PCI device 0000:00:03.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:08.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:09.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:0a.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:10.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:11.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:12.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
EAL: PCI device 0000:00:13.0 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:100e net_e1000_em
Hello from lcore: 1
Hello from lcore: 3
Hello from lcore: 2
Hello from lcore: 4
Hello from lcore: 5
Hello from lcore: 6
Hello from lcore: 7
Hello from lcore: 8
Hello from lcore: 9
Hello from lcore: 0
```

### Examples (Tested only on VirtualBox)
- [hello](https://github.com/s-you/dpdk.cr/blob/master/examples/hello.cr)
- [basicfwd](https://github.com/s-you/dpdk.cr/blob/master/examples/basicfwd.cr) (skeleton)
- [l2fwd](https://github.com/s-you/dpdk.cr/blob/master/examples/l2fwd.cr)
- [rxtx_callbacks](https://github.com/s-you/dpdk.cr/blob/master/examples/rxtx_callbacks.cr)
- [timer](https://github.com/s-you/dpdk.cr/blob/master/examples/timer.cr)
- [packet_ordering](https://github.com/s-you/dpdk.cr/blob/master/examples/packet_ordering.cr) (rx - worker - tx)
- [load_balancer](https://github.com/s-you/dpdk.cr/blob/master/examples/load_balancer.cr) (Load balance IO RX/TX & Worker + LPM)
- [distributor](https://github.com/s-you/dpdk.cr/blob/master/examples/distributor.cr) (Distributor, RX, TX, Worker)

### Performance
- rxtx_callbacks sample on one end, as fast as C

![rxtx_callbacks](https://user-images.githubusercontent.com/1001175/36676493-2f3a5e0c-1b4f-11e8-82d3-c313f94181c2.png)

- pktgen on the other end, 14Mpps with 64 byte packets (Wirerate at 10G)

![2018-02-26 20 07 57](https://user-images.githubusercontent.com/1001175/36676500-34160ea8-1b4f-11e8-99da-8bb1ef3480d1.png) |

### TODO
- Supports all possible examples provided by DPDK

### Limitations
- All static inlines in the dpdk headers either need to write it in Crystal or extern from C.
- Following funtions are compiled as C library currently -
  - rte_pktmbuf_free
  - rte_pktmbuf_alloc
  - rte_pktmbuf_append
  - rte_eth_rx_burst
  - rte_eth_tx_burst
  - rte_ring_dequeue_burst
  - rte_ring_enqueue_burst
  - rte_ring_sp_enqueue_bulk
  - rte_ring_sc_dequeue_bulk
  - rte_lpm_lookup
  - rte_lcore_to_socket_id
