/****************************************************************************
 * mor1kx_fw.c
 ****************************************************************************/
#include <stdint.h>
#include "mor1kx_soc_memmap.h"

static void (*main_f)(void) = (void (*)(void))0x10001000;

#define write8(addr, data) \
	*((volatile uint8_t *)(addr)) = (data)

#define read8(addr) \
	*((volatile uint8_t *)(addr))

#define write32(addr, data) \
	*((volatile uint32_t *)(addr)) = (data)

#define read32(addr) \
	*((volatile uint32_t *)(addr))

static void uart_init(void) {
	uint8_t val;
	val = read8((MOR1KX_UART0_BASE+3)); // read LCR
	val |= 0x80;
	write8((MOR1KX_UART0_BASE+3), val);
//	write8(MOR1KX_UART0_BASE, 130); // 9600 baud
	write8(MOR1KX_UART0_BASE, 11); // 115200 baud
//	write8(MOR1KX_UART0_BASE, 5); // 230400 baud
//	write8(MOR1KX_UART0_BASE, 1); // 921600 baud
	val &= (~0x80);
	write8((MOR1KX_UART0_BASE+3), val);
}

static void uart_putc(char c) {
	uint8_t val;
	do {
		val = read8((MOR1KX_UART0_BASE+5)); // read LSR
	} while ((val & 0x40) == 0);

	write8(MOR1KX_UART0_BASE, c);
}

static uint8_t uart_getc() {
	uint8_t val;
	do {
		val = read8((MOR1KX_UART0_BASE+5)); // read LSR
	} while ((val & 0x01) == 0);

	return read8(MOR1KX_UART0_BASE);
}


int boot_main(void) {
	volatile uint32_t v_t = 0;
	uint8_t val = 1;
	int x;

	uart_init();

	uart_putc(0xEA); // Header
	uart_putc(0x01); // Hello

	while (1) {
		val = uart_getc();
		uart_putc(val+1);
	}

	main_f();
}

