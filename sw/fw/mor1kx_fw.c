/****************************************************************************
 * mor1kx_fw.c
 ****************************************************************************/
#include <stdint.h>
#include "mor1kx_soc_memmap.h"
#include "vmon_monitor.h"

static void (*main_f)(void) = (void (*)(void))0x10001000;

#define write8(addr, data) \
	*((volatile uint8_t *)(addr)) = (data)

#define read8(addr) \
	*((volatile uint8_t *)(addr))

#define write32(addr, data) \
	*((volatile uint32_t *)(addr)) = (data)

#define read32(addr) \
	*((volatile uint32_t *)(addr))

static void io_out8(uint8_t data) {
	*((volatile uint32_t *)0x80002000) = ((0x8) | (data & 0x7));
	*((volatile uint32_t *)0x80002000) = ((0x0) | (data & 0x7));
	*((volatile uint32_t *)0x80002000) = ((0x8) | ((data >> 3) & 0x7));
	*((volatile uint32_t *)0x80002000) = ((0x0) | ((data >> 3) & 0x7));
	*((volatile uint32_t *)0x80002000) = ((0x8) | ((data >> 6) & 0x3));
	*((volatile uint32_t *)0x80002000) = ((0x0) | ((data >> 6) & 0x3));
}

static void io_outstr(const char *s) {
	while (*s) {
		io_out8(*s);
		s++;
	}
	io_out8(0);
}

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

	val = read8(MOR1KX_UART0_BASE);

	return val;
}

// Receive data from harness
static int32_t vmon_h2m(void *ud, uint8_t *data, uint32_t len) {
	data[0] = uart_getc();
	return 1;
}

// Send data to harness
static int32_t vmon_m2h(void *ud, uint8_t *data, uint32_t len) {
	uart_putc(data[0]);
	return 1;
}

static vmon_monitor_t		prv_vmon;

int boot_main(void) {
	volatile uint32_t v_t = 0;
	uint8_t val = 1;
	int x;

	uart_init();

	vmon_monitor_init(&prv_vmon);
	vmon_monitor_add_h2m_path(&prv_vmon, &vmon_h2m, 0);
	vmon_monitor_add_m2h_path(&prv_vmon, &vmon_m2h, 0);

	vmon_monitor_run(&prv_vmon);

//	io_outstr("Hello World!\n");
////	io_out8('H');
////	io_out8('e');
////	io_out8('l');
////	io_out8('l');
////	io_out8('o');
//
//	// Spin forward looking for a header byte
//	while (1) {
//		while (1) {
//			val = uart_getc();
//
//			if (val == 0xEA) { // header byte
//				break;
//			}
//		}
//		uart_putc(0xE5); // ACK
//
//		while (1) {
//			// Connected
//			val = uart_getc();
//
//			if (val == 0xEA) { // header byte
//				val = uart_getc();
//
//				switch (val) {
//				case 0: {
//					uart_putc(0xE5); // ACK
////					main_f();
//				} break;
//
//				case 1: {
//					uart_putc(0xE6); // ACK
//				} break;
//				}
//			} else {
//				break;
//			}
//		}
//	}


}

