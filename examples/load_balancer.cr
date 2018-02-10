require "../src/dpdk_minimal"
require "../src/lib_dpdk_minimal/lib_rte_lpm"
require "./load_balancer/*"

class LoadBalancer < Dpdk
  include Constants
  @app = uninitialized LibLoadBalancer::AppParams

  def main(argc, argv)
    # Init EAL
    ret = rte_eal_init(argc, argv)
    argc -= ret + 1
    argv += ret + 1

    # Parse application arguments (after the EAL ones)
    app_parse_args argc, argv

    # Init
    app_init
    app_print_params

    # Launch per-lcore init on every lcore
    rte_eal_mp_remote_launch(app_lcore_main_loop)
    rte_lcore_foreach_slave do |lcore_id|
      return if rte_eal_wait_lcore(lcore_id) < 0
    end
  end
end

LoadBalancer.run

# # Run the program
# # sudo build/load_balancer -l 3-7 -n 4 -- --rx "(0,0,3),(1,0,3)" --tx "(0,3),(1,3)" --w "4,5,6,7" --lpm "1.0.0.0/24=>0; 1.0.1.0/24=>1;" --pos-lb 29
# # sudo build/load_balancer -l 3-7 -n 4 -- --rx "(0,0,3),(1,0,3)" --tx "(0,4),(1,5)" --w "6" --lpm "1.0.0.0/24=>0; 1.0.1.0/24=>1;" --pos-lb 29
# # sudo build/load_balancer -l 1,3,5,7,9,11 -n 4 -- --rx "(0,0,3),(1,0,5)" --tx "(0,7),(1,9)" --w "11" --lpm "1.0.0.0/24=>0; 1.0.1.0/24=>1;" --pos-lb 29
# # sudo build/load_balancer -l 1,3,5,7,9,11,13 -n 4 -- --rx "(0,0,3),(1,0,5)" --tx "(0,7),(1,9)" --w "11,13" --lpm "1.0.0.0/24=>0; 1.0.1.0/24=>1;" --pos-lb 29
