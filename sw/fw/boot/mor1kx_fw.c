/****************************************************************************
 * mor1kx_fw.c
 ****************************************************************************/
#include <stdint.h>
#include "mor1kx_vmon_main.h"
#include "mor1kx_soc_memmap.h"
#include "vmon_monitor.h"

//static void uart_init(void) {
//	uint8_t val;
//	val = read8((MOR1KX_UART0_BASE+3)); // read LCR
//	val |= 0x80;
//	write8((MOR1KX_UART0_BASE+3), val);
////	write8(MOR1KX_UART0_BASE, 130); // 9600 baud
//	write8(MOR1KX_UART0_BASE, 11); // 115200 baud
////	write8(MOR1KX_UART0_BASE, 5); // 230400 baud
////	write8(MOR1KX_UART0_BASE, 1); // 921600 baud
//	val &= (~0x80);
//	write8((MOR1KX_UART0_BASE+3), val);
//}

int boot_main(void) {

	mor1kx_vmon_main();

	return 0;
}

