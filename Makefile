image:
	dd if=bootloader.bin of=nanoc.img
	dd if=kernel.bin of=nanoc.img seek=1 bs=512

kernel: kernel.c boot.asm
	i686-elf-gcc -I include -ffreestanding -c -m32 -o kernel.o kernel.c
	i686-elf-as -o boot.o boot.asm
	i686-elf-ld -T lscript.ld -o kernel.bin -nostdlib -n --oformat binary boot.o kernel.o
bl: bootloader.asm
	nasm -f bin -o bootloader.bin bootloader.asm

run-qemu:
	qemu-system-i386 -drive file=nanoc.img,format=raw -boot c -monitor stdio

clear:
	rm *.bin
