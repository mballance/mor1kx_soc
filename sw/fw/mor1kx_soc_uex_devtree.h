#ifndef INCLUDED_MOR1KX_SOC_UEX_DEVTREE_H
#define INCLUDED_MOR1KX_SOC_UEX_DEVTREE_H
#include "wb_dma_uex_drv.h"
#include "simple_pic_drv.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct mor1kx_soc_devtree_s {
	simple_pic_drv_t			pic;
	wb_dma_uex_drv_t			dma0;

} mor1kx_soc_devtree_t;

extern mor1kx_soc_devtree_t		mor1kx_soc_devtree;

void mor1kx_soc_devtree_init(void);


#ifdef __cplusplus
}
#endif

#endif /* INCLUDED_MOR1KX_UEX_DEVTREE_H */
