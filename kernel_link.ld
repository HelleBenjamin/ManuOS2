OUTPUT_FORMAT(elf32-i386)

ENTRY(_start)

SECTIONS
{
	. = 1M;

	_kstart = .;

	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.boot)
		*(.text)
	}

	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* Read-write data (initialized) */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}

	_kend = .;

}