#include <stdio.h>
#include "gtest/gtest.h"
#include "sv_bfms_rw_api_if.h"
#include "uex.h"
#include "or1k_uex_support.h"
#include "mor1kx_soc_uex_devtree.h"

TEST(dma,smoketest) {
	or1k_uex_init();

	for (int i=0; i<16; i++) {
		fprintf(stdout, "--> xfer %d\n", i);
		wb_dma_uex_drv_single_xfer(
				&mor1kx_soc_devtree.dma0,
				0,
				0x0000,
				1,
				0x1000,
				1,
				16);
		fprintf(stdout, "<-- xfer %d\n", i);
	}

	or1k_uex_exit();
}
