/****************************************************************************
 * or1k-support.c
 *
 * Subsystem-level stub for the API exposed by or1k-support.h
 ****************************************************************************/
#include <stdio.h>
#include "or1k-support.h"
#include "sv_bfms_rw_api_if.h"


void or1k_mtspr (uint32_t spr, uint32_t value) {
	sv_bfms_write32(0, 0xF0000000+spr, value);
}

uint32_t or1k_mfspr (uint32_t spr) {
	return sv_bfms_read32(0, 0xF0000000+spr);
}
