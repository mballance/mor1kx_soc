
#include <stdio.h>
#include "gtest/gtest.h"
#include "sv_bfms_rw_api_if.h"
#include "uex.h"
#include "or1k_uex_support.h"

static int thread_1(void *ud) {
	for (uint32_t i=0; i<16; i++) {
		fprintf(stdout, "--> write32(1)\n");
		sv_bfms_write32(0, 4*i, i);
		fprintf(stdout, "<-- write32(1)\n");

		fprintf(stdout, "--> read32(1)\n");
		uint32_t rd = sv_bfms_read32(0, 4*i);
		fprintf(stdout, "<-- read32(1)\n");

		fprintf(stdout, "READ(1): 0x%08x 0x%08x\n", 4*i, rd);
	}

	return 0;
}

static int thread_2(void *ud) {
	for (uint32_t i=0; i<16; i++) {
		fprintf(stdout, "--> write32(2)\n");
		sv_bfms_write32(0, 0x1000+4*i, i);
		fprintf(stdout, "<-- write32(2)\n");

		fprintf(stdout, "--> read32(2)\n");
		uint32_t rd = sv_bfms_read32(0, 0x1000+4*i);
		fprintf(stdout, "<-- read32(2)\n");

		fprintf(stdout, "READ(2): 0x%08x 0x%08x\n", 4*i, rd);
	}

	return 0;
}

static void sw_smoketest_main() {
	fprintf(stdout, "Hello World\n");
	fflush(stdout);

	uex_thread_t t1, t2;

//	uex_init();

	t1 = uex_thread_create(&thread_1, 0);
	t2 = uex_thread_create(&thread_2, 0);

	// Wait for threads to end
	fprintf(stdout, "--> join (t1)\n");
	uex_thread_join(t1);
	fprintf(stdout, "<-- join (t1)\n");
	fprintf(stdout, "--> join (t2)\n");
	uex_thread_join(t2);
	fprintf(stdout, "<-- join (t2)\n");
}

TEST(sw,smoketest) {
	or1k_uex_entry(&sw_smoketest_main);
}
