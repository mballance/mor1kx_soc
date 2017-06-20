#ifndef INCLUDED_MOR1KX_SOC_MEMMAP_H
#define INCLUDED_MOR1KX_SOC_MEMMAP_H

#define MOR1KX_PERIPH_BASE 	0x80000000

#define MOR1KX_UART0_BASE 	(MOR1KX_PERIPH_BASE+0x00000000)
#define MOR1KX_UART0_IRQ	1

#define MOR1KX_DMA0_BASE 	(MOR1KX_PERIPH_BASE+0x00001000)
#define MOR1KX_DMA0_IRQ		0

#define MOR1KX_PIC_BASE 	(MOR1KX_PERIPH_BASE+0x00003000)

#define MOR1KX_FPIO0_BASE	(MOR1KX_PERIPH_BASE+0x00004000)
#define MOR1KX_FPIO0_IRQ	2

#define MOR1KX_SCRATCHPAD_BASE 0x90000000
#define MOR1KX_SCRATCHPAD_SIZE 0x00001000


#endif /* INCLUDED_MOR1KX_SOC_MEMMAP_H */