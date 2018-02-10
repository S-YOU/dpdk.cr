#ifdef __cplusplus
extern "C" {
#endif

#include "kni.h"
#include "ext_netlink.h"

#define MAX_PACKET_SZ 1600
#define MASK 0xfcffffffU
#define perror_exit(msg) {perror(msg); exit(1);}

/* Macros for printing using RTE_LOG */
#define RTE_LOGTYPE_APP RTE_LOGTYPE_USER1

/* Callback for request of configuring network interface up/down */
static int
kni_config_network_interface(uint16_t port_id, uint8_t if_up)
{
	int ret = 0;

	if (port_id >= rte_eth_dev_count() || port_id >= RTE_MAX_ETHPORTS) {
		RTE_LOG(ERR, APP, "Invalid port id %d\n", port_id);
		return -EINVAL;
	}

	if (if_up != 0) { /* Configure network interface up */
		rte_eth_dev_stop(port_id);
		ret = rte_eth_dev_start(port_id);
	} else /* Configure network interface down */
		rte_eth_dev_stop(port_id);

	if (ret < 0)
		RTE_LOG(ERR, APP, "Failed to start port %d\n", port_id);

	return ret;
}

extern inline struct rte_kni*
kni_create(char* name, struct rte_mempool* pool, uint16_t port_id, uint32_t lcore_id, int rw) {
	struct rte_kni *kni;
	struct rte_kni_conf conf;

	if (port_id >= RTE_MAX_ETHPORTS)
		return NULL;

	/* Clear conf at first */
	memset(&conf, 0, sizeof(conf));
	strcpy(conf.name, name);

	conf.core_id = lcore_id;
	conf.force_bind = 1;
	conf.group_id = port_id;
	conf.mbuf_size = MAX_PACKET_SZ;

	struct rte_kni_ops ops;
	struct rte_eth_dev_info dev_info;

	memset(&dev_info, 0, sizeof(dev_info));
	rte_eth_dev_info_get(port_id, &dev_info);

	if (dev_info.pci_dev) {
		conf.addr = dev_info.pci_dev->addr;
		conf.id = dev_info.pci_dev->id;
	}
	/* Get the interface default mac address */
	if (rw)
		rte_eth_macaddr_get(port_id, (struct ether_addr *)&conf.mac_addr);

	rte_eth_dev_get_mtu(port_id, &conf.mtu);

	memset(&ops, 0, sizeof(ops));
	ops.port_id = port_id;
	ops.config_network_if = kni_config_network_interface;

	kni = rte_kni_alloc(pool, &conf, &ops);

	if (!kni)
		rte_exit(EXIT_FAILURE, "Fail to create kni for port: %d\n", port_id);

	//
	struct ifreq ifr;
	int s = socket(AF_INET, SOCK_DGRAM, 0);

	memset(&ifr, 0, sizeof(ifr));
	strcpy(ifr.ifr_name, name);

	for (;;) {
		rte_kni_handle_request(kni);
		ioctl(s, SIOCGIFFLAGS, &ifr);
		if (ifr.ifr_flags & IFF_UP) break;
		else {
			ifr.ifr_flags = rw ? IFF_UP : IFF_UP | IFF_NOARP | IFF_PROMISC;
			ioctl(s, SIOCSIFFLAGS, &ifr);
		}
	}

	printf("%s up\n", name);

	return kni;
}

extern inline void
kni_setup_ip(char* name, uint32_t ipv4, uint32_t loopback, struct in6_addr* ipv6,
	uint32_t* routes, uint32_t nb_routes, uint32_t gw) {

	struct ifreq ifr;
	int s = socket(AF_INET, SOCK_DGRAM, 0);

	memset(&ifr, 0, sizeof(ifr));
	strcpy(ifr.ifr_name, name);

	setup_ip(s, &ifr, ipv4, loopback, ipv6);

	if (ioctl(s, SIOGIFINDEX, &ifr)) perror_exit("SIOGIFINDEX")
	setup_routes(ifr.ifr_ifindex, routes, nb_routes, gw);

	close(s);
}

#ifdef __cplusplus
}
#endif
