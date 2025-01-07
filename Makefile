nanoc-bl.bin: nanoc-bl.asm
	nasm -f bin -o nanoc-bl.bin nanoc-bl.asm

run-qemu:
	qemu-system-i386 nanoc-bl.bin

clear:
	rm *.bin
