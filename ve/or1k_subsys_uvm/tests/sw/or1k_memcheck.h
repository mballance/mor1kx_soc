
#ifndef INCLUDED_OR1K_MEMCHECK_H
#define INCLUDED_OR1K_MEMCHECK_H
#include <stdint.h>

void do_memcheck(
		uint32_t		addr,
		uint32_t		size,
		uint32_t		wr_data,
		uint32_t		wr_mask
		);

#endif /* INCLUDED_OR1K_MEMCHECK_H */
