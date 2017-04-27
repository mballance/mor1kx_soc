
OUTPUT_FORMAT("elf32-or1k", "elf32-or1k", "elf32-or1k")
__DYNAMIC = 0;

// 16 - 64k
// 17 - 128k
// 18 - 256k
// 19 - 512k
// 20 - 1M
#define ROM_ORIGIN	0x00000000
#define ROM_LENGTH	0x00010000 // 64k
#define RAM_ORIGIN  0x10000000
// #define RAM_LENGTH	0x00100000 // 1M
#define RAM_LENGTH	0x00001000 // 4k

MEMORY
{
	rom(rx)  : ORIGIN = ROM_ORIGIN, LENGTH = ROM_LENGTH
	ram(rwx) : ORIGIN = RAM_ORIGIN, LENGTH = RAM_LENGTH
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

	.ramvec : {
		*(.ramvec)
	} >ram

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

	. = ALIGN(4);

	_heap = .; PROVIDE(heap = .);

 	. += (RAM_LENGTH - 4);
	_ram_end = .; PROVIDE(ram_end = .);

//	  . = DATA_SEGMENT_END (.);
	  /* Stabs debugging sections.  */
	  .stab          0 : { *(.stab) }
	  .stabstr       0 : { *(.stabstr) }
	  .stab.excl     0 : { *(.stab.excl) }
	  .stab.exclstr  0 : { *(.stab.exclstr) }
	  .stab.index    0 : { *(.stab.index) }
	  .stab.indexstr 0 : { *(.stab.indexstr) }
	  .comment       0 : { *(.comment) }
	  /* DWARF debug sections.
	     Symbols in the DWARF debugging sections are relative to the beginning
	     of the section so we begin them at 0.  */
	  /* DWARF 1 */
	  .debug          0 : { *(.debug) }
	  .line           0 : { *(.line) }
	  /* GNU DWARF 1 extensions */
	  .debug_srcinfo  0 : { *(.debug_srcinfo) }
	  .debug_sfnames  0 : { *(.debug_sfnames) }
	  /* DWARF 1.1 and DWARF 2 */
	  .debug_aranges  0 : { *(.debug_aranges) }
	  .debug_pubnames 0 : { *(.debug_pubnames) }
	  /* DWARF 2 */
	  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	  .debug_abbrev   0 : { *(.debug_abbrev) }
	  .debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }
	  .debug_frame    0 : { *(.debug_frame) }
	  .debug_str      0 : { *(.debug_str) }
	  .debug_loc      0 : { *(.debug_loc) }
	  .debug_macinfo  0 : { *(.debug_macinfo) }
	  /* SGI/MIPS DWARF 2 extensions */
	  .debug_weaknames 0 : { *(.debug_weaknames) }
	  .debug_funcnames 0 : { *(.debug_funcnames) }
	  .debug_typenames 0 : { *(.debug_typenames) }
	  .debug_varnames  0 : { *(.debug_varnames) }
	  /* DWARF 3 */
	  .debug_pubtypes 0 : { *(.debug_pubtypes) }
	  .debug_ranges   0 : { *(.debug_ranges) }
	  /* DWARF Extension.  */
	  .debug_macro    0 : { *(.debug_macro) }
	  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
	  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }

/*
	.stab 0 (NOLOAD) : {
		*(.stab)
	}

	.stabstr 0 (NOLOAD) : {
		*(.stabstr)
	}

	.debug			0 : { *(.debug) }
	.line			0 : { *(.line) }
	 */
	
}
