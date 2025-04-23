.section .text
.global _start
_start:
movl $stack_top, %esp
call kernel
cli
.hang:
hlt
jmp .hang
.section .bss
.align
stack_bottom:
.skip 4096
stack_top:

