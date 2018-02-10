#ifndef _NETLINK_H_
#define _NETLINK_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <string.h>
#include <sys/queue.h>
#include <stdarg.h>
#include <errno.h>
#include <getopt.h>

#include <netinet/in.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <arpa/inet.h>
#include <linux/if_tun.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <signal.h>

#include <asm/types.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#define MASK 0xfcffffffU
#define NLMSG_TAIL(nlh) (void *)((char *)(nlh) + NLMSG_ALIGN((nlh)->nlmsg_len))
#define perror_exit(msg) {perror(msg); exit(1);}

void add_ipv4(uint32_t ifc_idx, uint32_t ipv4, uint32_t mask);
void add_ipv6(uint32_t ifc_idx, struct in6_addr* ipv6, uint32_t mask);
void add_route(uint32_t ifc_idx, uint32_t gw, uint32_t dst, uint32_t mask);

void inet_pton6(char* ipv6, uint64_t* buf);
void set_mac_mtu(int s, struct ifreq* ifr, uint64_t mac, uint32_t mtu);
void setup_ip(int s, struct ifreq* ifr, uint32_t ipv4, uint32_t loopback, struct in6_addr* ipv6);
void setup_routes(int ifindex, uint32_t* routes, uint32_t nb_routes, uint32_t gw);

#ifdef __cplusplus
}
#endif
#endif
