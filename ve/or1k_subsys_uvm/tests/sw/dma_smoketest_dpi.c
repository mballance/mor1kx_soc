#include "wb_dma_drv.h"
#include <stdio.h>
#include <stdint.h>

int dma_smoketest_test_main(int argc, char **argv) {
	int i;
	wb_dma_drv_t drv;
	uint32_t status;
	fprintf(stdout, "Hello from dma_smoketest_test_main\n");

	wb_dma_drv_init(&drv, 0x80001000, 1, 0);

	wb_dma_drv_init_single_xfer(
			&drv,
			0, // chan
			0x90000000,
			1,
			0x90000100,
			1,
			64);

	do {
		status = wb_dma_drv_check_status(&drv, 0);
	} while (status == 1);

//	for (i=0; i<argc; argc++) {
//		fprintf(stdout, "ARGV[%d] %s\n", i, argv[i]);
//	}
	return 0;
}
