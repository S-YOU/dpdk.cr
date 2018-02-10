#ifdef __cplusplus
extern "C" {
#endif

#include "tap.h"
#include "ext_netlink.h"

#define TUN_DEVICE "/dev/net/tun"

extern inline int tap_read(int tap_fd, char *buf, int buf_size) {
	int ret;
	fd_set rd_set;
	struct timeval tv = {0, 10000};

	FD_ZERO(&rd_set);
	FD_SET(tap_fd, &rd_set);

	ret = select(tap_fd + 1, &rd_set, NULL, NULL, &tv);
	if (ret < 0) {
		if (errno == EINTR) return 0;
		else perror_exit("select()")
	}

	if(FD_ISSET(tap_fd, &rd_set)) {
		ret = read(tap_fd, buf, buf_size);
		if (ret < 0) perror_exit("tap_read")

		return ret;
	}
	return 0;
}

extern int tap_create(char *name, uint64_t mac, uint32_t mtu, int rw) {
	struct ifreq ifr;
	int fd, ret;

	fd = open(TUN_DEVICE, rw ? O_RDWR | O_NONBLOCK : O_WRONLY | O_NONBLOCK);
	if (fd < 0) perror_exit(TUN_DEVICE)

	memset(&ifr, 0, sizeof(ifr));
	strcpy(ifr.ifr_name, name);

	ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
	ret = ioctl(fd, TUNSETIFF, &ifr);
	if (ret < 0) {
		close(fd);
		perror_exit("TUNSETIFF")
	}

	int s = socket(AF_INET, SOCK_DGRAM, 0);
	if (ioctl(s, SIOCGIFFLAGS, &ifr)) perror_exit("SIOCGIFFLAGS")

	set_mac_mtu(s, &ifr, mac, mtu);

	if (ioctl(s, SIOGIFINDEX, &ifr)) perror_exit("SIOGIFINDEX")
	ifr.ifr_flags = rw ? IFF_UP : IFF_UP | IFF_NOARP | IFF_PROMISC;
	if (ioctl(s, SIOCSIFFLAGS, &ifr)) perror_exit("SIOCSIFFLAGS")

	close(s);

	return fd;
}

extern inline void
tap_setup_ip(char *name, uint32_t ipv4, uint32_t loopback, struct in6_addr* ipv6,
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
