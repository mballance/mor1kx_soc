/****************************************************************************
 * or1k_uex_support.cpp
 ****************************************************************************/
#include <stdio.h>
#include "or1k_uex_support.h"
#include "uex_sys.h"
#include "uex_irq_services.h"
#include "or1k-sprs.h"
#include "or1k-support.h"

static const uint32_t TIMER_TICK_IRQ = 0;

static void irq_handler(void *ud, uint32_t id) {
	fprintf(stdout, "irq_handler %d\n", id);
	if (id == 0) {
		// timer-tick interrupt
		// Reset the timer
//		or1k_mtspr();
		uint32_t tmr = or1k_mfspr(OR1K_SPR_TICK_TTMR_ADDR);
		tmr = OR1K_SPR_TICK_TTMR_IP_SET(tmr, 0);
		or1k_mtspr(OR1K_SPR_TICK_TTMR_ADDR, tmr);
	} else {
		// PIC
	}
}

void or1k_uex_entry(main_f f) {
	// Configure interrupts
	uex_sv_set_interrupt_handler(&irq_handler, 0);

	// Setup devices

	// Setup the tick timer
	fprintf(stdout, "--> Setup Timer\n");
	or1k_mtspr(OR1K_SPR_TICK_TTCR_ADDR, 0);
	uint32_t tmr = or1k_mfspr(OR1K_SPR_TICK_TTMR_ADDR);
	tmr = OR1K_SPR_TICK_TTMR_IE_SET(tmr, 1);
	tmr = OR1K_SPR_TICK_TTMR_MODE_SET(tmr, 1); // restart
	tmr = OR1K_SPR_TICK_TTMR_TP_SET(tmr, 0x80);
	or1k_mtspr(OR1K_SPR_TICK_TTMR_ADDR, tmr);
	fprintf(stdout, "<-- Setup Timer\n");

	// Finally, call main
	fprintf(stdout, "--> Calling main_f\n");
	f();
	fprintf(stdout, "<-- Calling main_f\n");
}

