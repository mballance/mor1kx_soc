
OUTPUT_FORMAT("elf32-or1k", "elf32-or1k", "elf32-or1k")
__DYNAMIC = 0;

MEMORY
{
	rom(rx)  : ORIGIN = 0x00000000, LENGTH = 0x10000
	ram(rwx) : ORIGIN = 0x10000000, LENGTH = 0x1000
}

SECTIONS
{
	.vectors :
	{
		*(.vectors)
		. = ALIGN(0x4);
	} > rom

	.text : {
		CREATE_OBJECT_SYMBOLS
		*(.text .text.* .gnu.linkonce.t.*)
		*(.plt)
		*(.gnu.warning)
		*(.glue_7t) *(.glue_7)
		
		. = ALIGN(0x4);
		
		/* Static constructor / destructors */
		KEEP (*crtbegin.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
		KEEP (*(SORT(.ctors.*)))
		KEEP (*crtend.o(.ctors))
		KEEP (*crtbegin.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
		KEEP (*(SORT(.dtors.*)))
		KEEP (*crtend.o(.dtors))
	
		*(.rodata .rodata.* .gnu.linkonce.r.*)
		
		*(.init)
		*(.fini)
	} >rom

	.init_array : {
		__init_array_start = .;	
		_init = .;
		*(.init_array)
	} >rom
	__init_array_end = .;
	
	_etext = .;
	
	.data : {
		__data_load = LOADADDR(.data);
		__data_start = .;
		KEEP(*(.jcr))
		*(.got.plt) *(.got)
		*(.shdata)
		*(.data .data.* .gnu.linkonce.d.*)
		. = ALIGN(4);
		_edata = .;
	} >ram AT>rom
	
	.bss : {
		_bss_start = .;
		*(.shbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
		. = ALIGN(4);
		_bss_end = .;
	} >ram	
	
	_end = .; PROVIDE(end = .);

	.stab 0 (NOLOAD) : {
		*(.stab)
	}
	
	.stabstr 0 (NOLOAD) : {
		*(.stabstr)
	}
	
	.debug			0 : { *(.debug) }
	.line			0 : { *(.line) }	
	
}
