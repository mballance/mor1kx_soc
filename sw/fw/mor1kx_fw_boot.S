/****************************************************************************
 * mor1kx_fw_boot.S
 ****************************************************************************/
#include "asm/spr-defs.h"

#define MOR1KX_PAD_O_ADDR 0x80002000

#define ASM_TEST_PT(p) \
	l.movhi			r4, hi(MOR1KX_PAD_O_ADDR); \
	l.ori			r4, r4, lo(MOR1KX_PAD_O_ADDR); \
	l.ori			r5, r0, 0xA; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, 0x5; \
	l.sw			0(r4), r5; \
	l.ori			r5, r0, p; \
	l.sw			0(r4), r5

	.section .vectors, "ax"
	.global __reset

	.org	0x100
__reset:
	l.andi		r0, r0, 0

	// Clear stack/frame pointers
	l.andi		r1, r0, 0
	l.andi		r2, r0, 0

	// Checkpoint 1
	ASM_TEST_PT(1);


	// Set superviser mode
	l.ori		r3, r0, SPR_SR_SM
	l.mtspr		r0, r3, SPR_SR

	l.jal		_ent
	l.nop

_ent:

	// Checkpoint 2
	ASM_TEST_PT(2);

	// Setup the stack
	l.movhi		r1, hi(_ram_end)
	l.ori		r1, r1, lo(_ram_end)
//	l.addi		r1, r1, 0x100
	l.or		r2, r0, r1

	// Relocate the .data section from ROM to RAM
	l.movhi		r4, hi(__data_load)  // data_load is the source addr for data: 0x0000e5d0
	l.ori		r4, r4, lo(__data_load)
	l.movhi		r5, hi(__data_start) // data_start is the dest addr for data: 0x10000000
	l.ori		r5, r5, lo(__data_start)
	l.movhi		r6, hi(_edata)       // _edata is the end dest addr for data: 0x100008b4
	l.ori		r6, r6, lo(_edata)
.L_rom2ram:
	l.lwz		r7, 0(r4)
	l.sw		0(r5), r7
	l.sfltu		r5, r6
	l.addi		r4, r4, 4
	l.bf		.L_rom2ram
	l.addi		r5, r5, 4
	l.nop

	// Checkpoint 3
	ASM_TEST_PT(3);

	// Clear BSS segments
	l.movhi	r4, hi(_bss_start)
	l.ori	r4, r4, lo(_bss_start)
	l.movhi	r5, hi(_bss_end)
	l.ori	r5, r5, lo(_bss_end)
.L_clear_bss:
	l.sw	0(r4), r0
	l.sfltu	r4,r5
	l.bf	.L_clear_bss
	l.addi	r4,r4,4

	// Checkpoint 4
	ASM_TEST_PT(4);

	// TODO: Call C++ init methods
/*
	l.movhi		r4, hi(__init_array_start)
	l.ori		r4, r4, lo(__init_array_start)
	l.movhi		r5, hi(__init_array_end)
	l.ori		r5, r5, lo(__init_array_end)
	l.sfeq		r4, r5 // skip init if the pointers are equal
	l.bf		.L_no_init
.L_call_init:
	l.jalr		r4		// Call init function
	l.sfltu		r4, r5
	l.bf		.L_call_init
	l.addi		r4, r4, 4
.L_no_init:
 */
	// cmp r4, r5
	// eq => skip
	//

	// Reset registers
	l.andi	r3, r0, 0
	l.andi	r4, r0, 0
	l.andi	r5, r0, 0
	l.andi	r6, r0, 0
	l.andi	r7, r0, 0
	l.andi	r8, r0, 0
	l.andi	r9, r0, 0
	l.andi	r10, r0, 0
	l.andi	r11, r0, 0
	l.andi	r12, r0, 0
	l.andi	r13, r0, 0
	l.andi	r14, r0, 0
	l.andi	r15, r0, 0
	l.andi	r17, r0, 0
	l.andi	r18, r0, 0
	l.andi	r19, r0, 0
	l.andi	r20, r0, 0
	l.andi	r21, r0, 0
	l.andi	r22, r0, 0
	l.andi	r23, r0, 0
	l.andi	r24, r0, 0
	l.andi	r25, r0, 0
	l.andi	r26, r0, 0
	l.andi	r27, r0, 0
	l.andi	r28, r0, 0
	l.andi	r29, r0, 0
	l.andi	r30, r0, 0
	l.andi	r31, r0, 0

	// Do 'c' setup
//	l.jal	pre_main
//	l.nop

	// Checkpoint F
//	ASM_TEST_PT(0xF);
//	l.nop

	l.jal	main
	l.nop
	l.nop
	l.nop
	l.nop

