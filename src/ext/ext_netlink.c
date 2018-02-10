#ifdef __cplusplus
extern "C" {
#endif

#include "ext_netlink.h"

static inline void nlattr_add(struct nlmsghdr *nh, unsigned short type, const void *data, uint32_t data_len) {
	struct rtattr *rta;

	rta = (struct rtattr *)NLMSG_TAIL(nh);
	rta->rta_len = RTA_LENGTH(data_len);
	rta->rta_type = type;
	memcpy(RTA_DATA(rta), data, data_len);
	nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(rta->rta_len);
}

static inline void nlattr_add32(struct nlmsghdr *nh, unsigned short type, uint32_t data) {
	nlattr_add(nh, type, &data, sizeof(uint32_t));
}

static inline int prepare_socket() {
	struct sockaddr_nl la;

	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) {
		perror("socket failed!\n");
		return -1;
	}

	bzero(&la, sizeof(la));
	la.nl_family = AF_NETLINK;
	la.nl_pid = getpid();
	bind(fd, (struct sockaddr *) &la, sizeof(la));
	return fd;
}

static inline int send_to_socket(int fd, struct nlmsghdr* reqn) {
	struct sockaddr_nl pa;
	struct msghdr msg;
	struct iovec iov;

	bzero(&pa, sizeof(pa));
	pa.nl_family = AF_NETLINK;

	bzero(&msg, sizeof(msg));
	msg.msg_name = (void *) &pa;
	msg.msg_namelen = sizeof(pa);

	iov.iov_base = reqn;
	iov.iov_len = reqn->nlmsg_len;
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	sendmsg(fd, &msg, 0);
	close(fd);
}

void add_ipv4(uint32_t ifc_idx, uint32_t ipv4, uint32_t mask) {
	int ifal;
	struct rtattr *rta;
	struct {
		struct nlmsghdr n;
		struct ifaddrmsg r;
		char buf[16384];
	} req;

	int fd = prepare_socket();

	bzero(&req, sizeof(req));

	ifal = sizeof(struct ifaddrmsg);

	rta = (struct rtattr *) req.buf;
	rta->rta_type = IFA_ADDRESS;
	rta->rta_len = sizeof(struct rtattr) + 4;
	memcpy(((char *)rta) + sizeof(struct rtattr), &ipv4, sizeof(ipv4));
	ifal += rta->rta_len;

	rta = (struct rtattr *)(((char *)rta) + rta->rta_len);
	rta->rta_type = IFA_LOCAL;
	rta->rta_len = sizeof(struct rtattr) + 4;
	memcpy(((char *)rta) + sizeof(struct rtattr), &ipv4, sizeof(ipv4));
	ifal += rta->rta_len;

	req.n.nlmsg_len = NLMSG_LENGTH(ifal);
	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_APPEND;
	req.n.nlmsg_type = RTM_NEWADDR;

	req.r.ifa_family = AF_INET;
	req.r.ifa_prefixlen = mask;
	req.r.ifa_flags = IFA_F_PERMANENT | IFA_F_SECONDARY;
	req.r.ifa_index = ifc_idx;
	req.r.ifa_scope = 0;

	send_to_socket(fd, &req.n);
}

void add_ipv6(uint32_t ifc_idx, struct in6_addr* ipv6, uint32_t mask) {
	int ifal;
	struct rtattr *rta;
	struct {
		struct nlmsghdr n;
		struct ifaddrmsg r;
		char buf[16384];
	} req;

	int fd = prepare_socket();

	bzero(&req, sizeof(req));

	ifal = sizeof(struct ifaddrmsg);

	rta = (struct rtattr *) req.buf;
	rta->rta_type = IFA_ADDRESS;
	rta->rta_len = sizeof(struct rtattr) + 16;
	memcpy(((char *)rta) + sizeof(struct rtattr), ipv6, 16);
	ifal += rta->rta_len;

	rta = (struct rtattr *)(((char *)rta) + rta->rta_len);
	rta->rta_type = IFA_LOCAL;
	rta->rta_len = sizeof(struct rtattr) + 16;
	memcpy(((char *)rta) + sizeof(struct rtattr), ipv6, 16);
	ifal += rta->rta_len;

	req.n.nlmsg_len = NLMSG_LENGTH(ifal);
	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_APPEND;
	req.n.nlmsg_type = RTM_NEWADDR;

	req.r.ifa_family = AF_INET6;
	req.r.ifa_prefixlen = mask;
	req.r.ifa_flags = IFA_F_PERMANENT | IFA_F_SECONDARY;
	req.r.ifa_index = ifc_idx;
	req.r.ifa_scope = 0;

	send_to_socket(fd, &req.n);
}

void add_route(uint32_t ifc_idx, uint32_t gw, uint32_t dst, uint32_t mask) {
	struct netlink_req {
		struct nlmsghdr n;
		struct rtmsg r;
		char buf[4096];
	} req;

	int fd = prepare_socket();

	bzero(&req, sizeof(req));

	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg));
	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
	req.n.nlmsg_type = RTM_NEWROUTE;

	req.r.rtm_family = AF_INET;
	req.r.rtm_dst_len = mask;
	req.r.rtm_table = RT_TABLE_MAIN;

	req.r.rtm_protocol = RTPROT_BOOT;
	req.r.rtm_scope = RT_SCOPE_UNIVERSE;
	req.r.rtm_type = RTN_UNICAST;

	nlattr_add(&req.n, RTA_GATEWAY, &gw, 4);
	nlattr_add(&req.n, RTA_DST, &dst, 4);
	nlattr_add32 (&req.n, RTA_OIF, ifc_idx);

	send_to_socket(fd, &req.n);
}

inline void inet_pton6(char* ipv6, uint64_t* buf) {
   inet_pton(AF_INET6, ipv6, (struct in6_addr*)buf);
}

inline void set_mac_mtu(int s, struct ifreq* ifr, uint64_t mac, uint32_t mtu) {
	if (ioctl(s, SIOGIFINDEX, ifr)) perror_exit("SIOGIFINDEX")

	if (mac) {
		*(uint64_t*)&(ifr->ifr_hwaddr.sa_data) = mac;
		ifr->ifr_hwaddr.sa_family = ARPHRD_ETHER;
		if (ioctl(s, SIOCSIFHWADDR, ifr)) perror_exit("SIOCSIFHWADDR")
	}

	if (mtu) {
		ifr->ifr_mtu = mtu;
		if (ioctl(s, SIOCSIFMTU, ifr)) perror_exit("SIOCSIFMTU")
	}
}

inline void setup_ip(int s, struct ifreq* ifr, uint32_t ipv4, uint32_t loopback, struct in6_addr* ipv6) {
	if (ipv4) {
		if (ioctl(s, SIOGIFINDEX, ifr)) perror_exit("SIOGIFINDEX")

		ifr->ifr_addr.sa_family = AF_INET;
		struct sockaddr_in* addr = (struct sockaddr_in*)&(ifr->ifr_addr);
		addr->sin_addr.s_addr = ipv4;
		if (ioctl(s, SIOCSIFADDR, ifr)) perror_exit("SIOCSIFADDR")

		addr->sin_addr.s_addr = ipv4 ^ ~MASK;
		if (ioctl(s, SIOCSIFDSTADDR, ifr)) perror_exit("SIOCSIFDSTADDR")

		addr->sin_addr.s_addr = ipv4 | ~MASK;
		if (ioctl(s, SIOCSIFBRDADDR, ifr)) perror_exit("SIOCSIFBRDADDR")

		addr->sin_addr.s_addr = MASK;
		if (ioctl(s, SIOCSIFNETMASK, ifr)) perror_exit("SIOCSIFNETMASK")
	}

	if (ioctl(s, SIOGIFINDEX, ifr)) perror_exit("SIOGIFINDEX")

	if (loopback) {
		add_ipv4(ifr->ifr_ifindex, loopback, 32);
	}

	if (ipv6) {
		add_ipv6(ifr->ifr_ifindex, ipv6, 64);
	}
}

inline void setup_routes(int ifindex, uint32_t* routes, uint32_t nb_routes, uint32_t gw) {
	if (nb_routes && routes) {
		for (int i = 0; i < nb_routes - 1; i+= 2) {
			add_route(ifindex, gw, routes[i], routes[i + 1]);
		}
	}
}

#ifdef __cplusplus
}
#endif
