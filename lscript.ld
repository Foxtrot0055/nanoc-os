ENTRY(_start)

SECTIONS
{
  . = 0x8000;
  .text : { *(.text) }
  .data : { * (.data) }
  .bss : { *(.bss COMMON) }

  . = ALIGN(16);
  . += 0x1000;
  stack_top = .;
}
