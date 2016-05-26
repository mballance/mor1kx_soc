
#include "asm/spr-defs.h"

	.section .vectors, "ax"
	.global __reset

	.org	0x100
__reset:
	l.andi		r0, r0, 0
	l.andi		r1, r0, 0
	l.andi		r2, r0, 0

	// Set superviser mode
	l.ori		r3, r0, SPR_SR_SM
//	l.mtspr		r0, r3, SPR_SR

//	l.jal		_ent
	l.nop

_ent:

	// 10000000
	l.movhi		r4, 0x1000
	l.ori		r4, r0, 4
	l.ori		r5, r0, 0
L1:
	l.sw		0(r4), r5
	l.addi		r5, r5, 1
	l.j			L1
	l.andi		r0, r0, 0
	l.andi		r0, r0, 0
	l.andi		r0, r0, 0
	l.andi		r0, r0, 0

