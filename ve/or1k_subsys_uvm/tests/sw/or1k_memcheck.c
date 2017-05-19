#include "or1k_memcheck.h"
#include "or1k-support.h"

void do_memcheck(
		uint32_t		addr,
		uint32_t		size,
		uint32_t		wr_data,
		uint32_t		wr_mask
		) {
	uint32_t rd_data;

	switch (size) {
	case 1: {
		write8(addr, (wr_data & wr_mask));
		rd_data = read8(addr);
	} break;
	case 2: {
		write16(addr, (wr_data & wr_mask));
		rd_data = read16(addr);
	} break;
	case 4: {
		write32(addr, (wr_data & wr_mask));
		rd_data = read32(addr);
	} break;
	}

	if ((rd_data & wr_mask) != (wr_data & wr_mask)) {
		error(addr, rd_data, (wr_data&wr_mask));
	}
}


