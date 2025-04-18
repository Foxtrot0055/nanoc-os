image:
	dd if=nanoc-bl.bin of=nanoc.img
	dd if=nanoc-ker.bin of=nanoc.img seek=1 bs=512

nanoc-ker: nanoc-ker.c
	i686-elf-gcc -I include -ffreestanding -c -m32 -o nanoc-ker.o nanoc-ker.c
nanoc-bl: nanoc-bl.asm
	nasm -f bin -o nanoc-bl.bin nanoc-bl.asm

run-qemu:
	qemu-system-i386 -drive file=nanoc.img,format=raw -boot c -monitor stdio

clear:
	rm *.bin
