#include <stdio.h>
#include "gtest/gtest.h"
#include "sv_bfms_rw_api_if.h"
#include "uex.h"
#include "or1k_uex_support.h"
#include "mor1kx_soc_uex_devtree.h"

struct wb_dma_test_data;
struct wb_dma_xfer {
	uex_thread_t		thread;
	wb_dma_test_data	*td;
	uint32_t			channel;
	uint32_t			src;
	uint32_t			inc_src;
	uint32_t			dst;
	uint32_t			inc_dst;
	uint32_t			tot_sz;
};

struct wb_dma_test_data {
	wb_dma_uex_drv_t		*drv;

	uint32_t				xfer_idx;
	wb_dma_xfer				xfers[16];

};

int wb_dma_test_run_single_xfer(void *ud) {
	wb_dma_xfer *x = (wb_dma_xfer *)ud;
	wb_dma_test_data *td = x->td;

	fprintf(stdout, "--> run_single_xfer %p\n", x);
	fprintf(stdout, "  channel=%d\n", x->channel);
	wb_dma_uex_drv_single_xfer(
			&mor1kx_soc_devtree.dma0,
			x->channel,
			x->src,
			x->inc_src,
			x->dst,
			x->inc_dst,
			x->tot_sz);
	fprintf(stdout, "<-- run_single_xfer %p\n", x);
    return 0;
}

void wb_dma_test_queue_single_xfer(
		wb_dma_test_data	*td,
		uint32_t			channel,
		uint32_t			src,
		uint32_t			inc_src,
		uint32_t			dst,
		uint32_t			inc_dst,
		uint32_t			tot_sz
		) {
	wb_dma_xfer *x = &td->xfers[td->xfer_idx++];
	fprintf(stdout, "  x=%p td=%p xfer_idx=%d\n", x, td, td->xfer_idx);
	x->td = td;
	x->channel = channel;
	x->src = src;
	x->inc_src = inc_src;
	x->dst = dst;
	x->inc_dst = inc_dst;
	x->tot_sz = tot_sz;
	fprintf(stdout, "--> queue_single_xfer %p %d\n", x, x->channel);
	x->thread = uex_thread_create(&wb_dma_test_run_single_xfer, x);
	fprintf(stdout, "<-- queue_single_xfer %p\n", x);
}

void wb_dma_test_wait_complete(wb_dma_test_data *td) {
	int i;

	// Just loop through the outstanding transfers and wait
	for (i=0; i<td->xfer_idx; i++) {
		uex_thread_join(td->xfers[i].thread);
	}

	// Nothing outstanding now
	td->xfer_idx = 0;
}

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

static int dma_two_par_t1(void *ud) {
	fprintf(stdout, "--> dma_two_par_t1\n");
	wb_dma_uex_drv_single_xfer(
			&mor1kx_soc_devtree.dma0,
			0,
			0x0000,
			1,
			0x1000,
			1,
			16);
	fprintf(stdout, "<-- dma_two_par_t1\n");
	return 0;
}

static int dma_two_par_t2(void *ud) {
	fprintf(stdout, "--> dma_two_par_t2\n");
	wb_dma_uex_drv_single_xfer(
			&mor1kx_soc_devtree.dma0,
			1,
			0x0100,
			1,
			0x1100,
			1,
			16);
	fprintf(stdout, "<-- dma_two_par_t2\n");
	return 0;
}

TEST(dma,two_par) {
	uex_thread_t t1, t2;
	or1k_uex_init();

	for (int i=0; i<16; i++) {
		fprintf(stdout, "--> xfer %d\n", i);
		t1 = uex_thread_create(&dma_two_par_t1, 0);
		t2 = uex_thread_create(&dma_two_par_t2, 0);

		fprintf(stdout, "  t1=%d t2=%d\n", t1, t2);

		uex_thread_join(t1);
		uex_thread_join(t2);

		fprintf(stdout, "<-- xfer %d\n", i);
	}

	or1k_uex_exit();
}

TEST(dma, multipar) {
	wb_dma_test_data *td = new wb_dma_test_data();
	or1k_uex_init();

	memset(td, 0, sizeof(wb_dma_test_data));
	td->drv = &mor1kx_soc_devtree.dma0;

	for (int i=0; i<2; i++) {
		wb_dma_test_queue_single_xfer(td,
				i,
				0x0000+0x100*i,
				1,
				0x1000+0x100*i,
				1,
				64);
	}

	wb_dma_test_wait_complete(td);

	or1k_uex_exit();

	delete td;
}
