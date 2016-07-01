/****************************************************************************
 * mor1kx_fw.c
 ****************************************************************************/
#include <stdint.h>

int main(int argc, char **argv) {
	volatile uint32_t *ptr = (uint32_t *)0x80002000;
	volatile uint32_t v_t = 0;
	uint8_t val = 0;

	while (1) {
		uint32_t i;

		for (i=0; i<100000; i++) {
			v_t++;
		}

		*ptr = val;
		val = ((val+1) & 0xF);
	}

}

