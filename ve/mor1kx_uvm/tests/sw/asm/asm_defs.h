
#define MOR1KX_PAD_O_ADDR 0x80002000

#define ASM_TEST_PASS \
	l.movhi			r4, hi(MOR1KX_PAD_O_ADDR); \
	l.ori			r4, r4, lo(MOR1KX_PAD_O_ADDR); \
	l.ori			r5, r0, 0xA; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, 0x5; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, 0xF; \
	l.sw			0(r4), r5

#define ASM_TEST_PASS \
	l.movhi			r4, hi(MOR1KX_PAD_O_ADDR); \
	l.ori			r4, r4, lo(MOR1KX_PAD_O_ADDR); \
	l.ori			r5, r0, 0xA; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, 0x5; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, 0x0; \
	l.sw			0(r4), r5
