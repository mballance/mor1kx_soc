/****************************************************************************
 * or1k_uex_support.cpp
 ****************************************************************************/
#include <stdio.h>
#include "or1k_uex_support.h"
#include "uex_sys.h"
#include "uex_irq_services.h"
#include "or1k-sprs.h"
#include "or1k-support.h"
#include "mor1kx_soc_memmap.h"
#include "mor1kx_soc_uex_devtree.h"

static const uint32_t TIMER_TICK_IRQ = 0;

static void irq_handler(void *ud, uint32_t id) {
	fprintf(stdout, "irq_handler %d\n", id);
	if (id == 0) {
		// timer-tick interrupt
		// Clear the interrupt bit and continue
		uint32_t tmr = or1k_mfspr(OR1K_SPR_TICK_TTMR_ADDR);
		tmr = OR1K_SPR_TICK_TTMR_IP_SET(tmr, 0);
		or1k_mtspr(OR1K_SPR_TICK_TTMR_ADDR, tmr);
	} else {
		uint32_t pending;

		// PIC
		fprintf(stdout, "INT\n");

		simple_pic_drv_get_pending(&mor1kx_soc_devtree.pic, &pending);

		for (uint32_t i=0; i<32; i++) {
			if (pending & (1 << i)) {
				simple_pic_drv_ack(&mor1kx_soc_devtree.pic, i);
				uex_trigger_irq(i);
			}
		}
	}
}

void or1k_uex_init(void) {
	// Configure interrupts
	uex_sv_set_interrupt_handler(&irq_handler, 0);

	// Setup devices
	mor1kx_soc_devtree_init();

	// Setup the tick timer
	fprintf(stdout, "--> Setup Timer\n");
	or1k_mtspr(OR1K_SPR_TICK_TTCR_ADDR, 0);
	uint32_t tmr = or1k_mfspr(OR1K_SPR_TICK_TTMR_ADDR);
	tmr = OR1K_SPR_TICK_TTMR_IE_SET(tmr, 1);
	tmr = OR1K_SPR_TICK_TTMR_MODE_SET(tmr, 1); // restart
	tmr = OR1K_SPR_TICK_TTMR_TP_SET(tmr, 0x80);
	or1k_mtspr(OR1K_SPR_TICK_TTMR_ADDR, tmr);
	fprintf(stdout, "<-- Setup Timer\n");
}

void or1k_uex_exit(void) {
	or1k_mtspr(OR1K_SPR_TICK_TTCR_ADDR, 0);
	uint32_t tmr = or1k_mfspr(OR1K_SPR_TICK_TTMR_ADDR);
	tmr = OR1K_SPR_TICK_TTMR_IE_SET(tmr, 0); // disable
	tmr = OR1K_SPR_TICK_TTMR_MODE_SET(tmr, 0); // disable
	or1k_mtspr(OR1K_SPR_TICK_TTMR_ADDR, tmr);
}

void or1k_uex_entry(main_f f) {
	or1k_uex_init();

	// Finally, call main
	f();
}

