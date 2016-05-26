
OUTPUT_FORMAT("elf32-or1k", "elf32-or1k", "elf32-or1k")
__DYNAMIC = 0;

MEMORY
{
	rom : ORIGIN = 0x00000000, LENGTH = 0x1000
	ram : ORIGIN = 0x10000000, LENGTH = 0x1000
}

SECTIONS
{
	.vectors :
	{
		*(.vectors)
	} > rom
	
}
