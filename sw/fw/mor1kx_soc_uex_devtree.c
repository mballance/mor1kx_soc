
#include "mor1kx_soc_uex_devtree.h"
#include "mor1kx_soc_memmap.h"
#include "uex_dev_services.h"

static uex_device_t devices[] = {
		{
				"PIC",
				(void *)MOR1KX_PIC_BASE,
				64,
				{},
				0
		},
		{
				"DMA0",
				(void *)MOR1KX_DMA0_BASE,
				256,
				{MOR1KX_DMA0_IRQ},
				1
		}
};

void mor1kx_soc_devtree_init(void) {

	uex_set_devtree(devices, sizeof(devices)/sizeof(uex_device_t));

	simple_pic_drv_init(
			&mor1kx_soc_devtree.pic,
			MOR1KX_PIC_BASE);

//	uex_set_irq_id((uint32_t *)MOR1KX_DMA0_BASE, MOR1KX_DMA0_IRQ);
	wb_dma_uex_drv_init(
			&mor1kx_soc_devtree.dma0,
			MOR1KX_DMA0_BASE,
			0);
	simple_pic_drv_set_en(
			&mor1kx_soc_devtree.pic,
			MOR1KX_DMA0_IRQ,
			1);

//	uex_set_irq_id((uint32_t *)MOR1KX_UART0_BASE, MOR1KX_UART0_IRQ);
	simple_pic_drv_set_en(
			&mor1kx_soc_devtree.pic,
			MOR1KX_UART0_IRQ,
			1);

}


mor1kx_soc_devtree_t		mor1kx_soc_devtree;
