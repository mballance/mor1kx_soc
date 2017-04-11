/****************************************************************************
 * or1k-support.c
 *
 * Subsystem-level stub for the API exposed by or1k-support.h
 ****************************************************************************/
#include <stdio.h>
#include "or1k-support.h"
#include "sv_bfms_rw_api_if.h"


void or1k_mtspr (uint32_t spr, uint32_t value) {
	fprintf(stdout, "--> or1k_mtspr %08x %08x\n", (0xF0000000+spr), value);
	sv_bfms_write32(0, 0xF0000000+spr, value);
	fprintf(stdout, "<-- or1k_mtspr %08x\n", (0xF0000000+spr));
}

uint32_t or1k_mfspr (uint32_t spr) {
	fprintf(stdout, "--> or1k_mfspr %08x\n", (0xF0000000+spr));
	return sv_bfms_read32(0, 0xF0000000+spr);
	fprintf(stdout, "<-- or1k_mfspr %08x\n", (0xF0000000+spr));
}
