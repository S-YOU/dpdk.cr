#ifndef _RTE_RING_EXTRA_H_
#define _RTE_RING_EXTRA_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <rte_ring.h>

static __rte_always_inline unsigned int
__rte_ring_move_sc_cons_head_burst(struct rte_ring *r, unsigned int n,
		uint32_t *old_head, uint32_t *new_head, uint32_t *entries) {

    *old_head = r->cons.head;

    /* add rmb barrier to avoid load/load reorder in weak
        * memory model. It is noop on x86
        */
    // rte_smp_rmb();

    const uint32_t prod_tail = r->prod.tail;
    /* The subtraction is done between two unsigned 32bits value
        * (the result is always modulo 32 bits even if we have
        * cons_head > prod_tail). So 'entries' is always between 0
        * and size(ring)-1.
        */
    *entries = (prod_tail - *old_head);

    /* Set the actual entries for dequeue */
    if (n > *entries)
        n = *entries;

    if (unlikely(n == 0))
        return 0;

    *new_head = *old_head + n;

    r->cons.head = *new_head;

	return n;
}

extern __rte_always_inline unsigned int
rte_ring_sc_dequeue_burst_peek(struct rte_ring *r, void **obj_table, unsigned int n, uint32_t *cons_next)
{
	uint32_t cons_head;
	uint32_t entries;

	n = __rte_ring_move_sc_cons_head_burst(r, n, &cons_head, cons_next, &entries);
	if (n == 0)
		goto end;

	DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);

    //	update_tail(&r->cons, cons_head, cons_next, is_sc, 0);
    // r->cons->tail = cons_next;
end:
	return n;
}

extern __rte_always_inline void
update_sc_tail(struct rte_ring *r, uint32_t new_val) {
	RTE_SET_USED(0);

	__atomic_store_n(&(&r->cons)->tail, new_val, __ATOMIC_RELEASE);
}



#ifdef __cplusplus
}
#endif
#endif
