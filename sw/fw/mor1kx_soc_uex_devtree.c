
#include "mor1kx_soc_uex_devtree.h"
#include "mor1kx_soc_memmap.h"


void mor1kx_soc_devtree_init(void) {

	simple_pic_drv_init(
			&mor1kx_soc_devtree.pic,
			MOR1KX_PIC_BASE);

	uex_set_irq_id((uint32_t *)MOR1KX_DMA0_BASE, MOR1KX_DMA0_IRQ);
	wb_dma_uex_drv_init(
			&mor1kx_soc_devtree.dma0,
			MOR1KX_DMA0_BASE,
			0);
	simple_pic_drv_set_en(
			&mor1kx_soc_devtree.pic,
			MOR1KX_DMA0_IRQ,
			1);

	uex_set_irq_id((uint32_t *)MOR1KX_UART0_BASE, MOR1KX_UART0_IRQ);

}


mor1kx_soc_devtree_t		mor1kx_soc_devtree;
