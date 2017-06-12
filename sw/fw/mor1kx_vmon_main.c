/****************************************************************************
 *
 ****************************************************************************/
#include "mor1kx_vmon_main.h"
#include "vmon_monitor.h"
#include "mor1kx_soc_uex_devtree.h"
#include <stdio.h>

static vmon_monitor_t prv_vmon;

static int32_t vmon_h2m_uart(void *ud, uint8_t *data, uint32_t len) {
	fprintf(stdout, "--> UART get\n");
	data[0] = wb_uart_uex_drv_getc(&mor1kx_soc_devtree.uart0);
	fprintf(stdout, "<-- UART get %d\n", data[0]);
	return 1;
}
static int32_t vmon_m2h_uart(void *ud, uint8_t *data, uint32_t len) {
	fprintf(stdout, "--> UART put %d\n", data[0]);
	wb_uart_uex_drv_putc(&mor1kx_soc_devtree.uart0, data[0]);
	fprintf(stdout, "<-- UART put %d\n", data[0]);
	return 1;
}

// TODO: specify capabilities?
void mor1kx_vmon_main(void) {

	mor1kx_soc_devtree_init();

	vmon_monitor_init(&prv_vmon);
	vmon_monitor_add_h2m_path(&prv_vmon, &vmon_h2m_uart, 0);
	vmon_monitor_add_m2h_path(&prv_vmon, &vmon_m2h_uart, 0);

	vmon_monitor_run(&prv_vmon);

}
