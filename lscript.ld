ENTRY(kernel)

SECTIONS
{
  . = 0xFC00;
  .text : { *(.text) }
  .data : { * (.data) }
  .bss : { *(.bss) }
}
