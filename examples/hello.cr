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

# # Run the program
# # sudo build/hello
