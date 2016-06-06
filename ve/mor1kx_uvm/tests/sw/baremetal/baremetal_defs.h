
#ifndef INCLUDED_BAREMETAL_DEFS_H
#define INCLUDED_BAREMETAL_DEFS_H

#define MOR1KX_PAD_O_ADDR 0x80002000

#define BAREMETAL_TEST_PASS \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0xA; \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0x5; \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0xF;

#define BAREMETAL_TEST_FAIL \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0xA; \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0x5; \
	*((unsigned int *)MOR1KX_PAD_O_ADDR) = 0x0;

#endif /* INCLUDED_BAREMETAL_DEFS_H */
