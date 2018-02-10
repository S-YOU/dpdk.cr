#ifndef _NETLINK_H_
#define _NETLINK_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#include <asm/types.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#define NLMSG_TAIL(nlh) (void *)((char *)(nlh) + NLMSG_ALIGN((nlh)->nlmsg_len))

void add_ip(uint32_t ifc_idx, uint32_t ip_address, uint32_t mask);
void add_route(uint32_t ifc_idx, uint32_t src, uint32_t dst, uint32_t mask);

#ifdef __cplusplus
}
#endif
#endif
