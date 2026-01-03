ENTRY(_start)

SECTIONS
{
  . = 0;

  .text :
  {
    *(.text)
  }

  .data :
  {
    *(.rodata)
    *(.data)
  }

  .bss :
  {
    *(.bss)
    *(COMMON)
  }
}