bits 16
org 0x7c00

buffer:
	dw 0x8000


load_kernel:
        xor di, di
        mov ah, 0x42 ;bios function for reading drive in lba(modern) mode
        mov dl, 0x80 ;set drive 0x80 which should be the c drive
        lea si, [disk_adress_packet]
        int 0x13 ;bios int for function above         
       
;transition_to_protected_mode:
;        mov eax, cr0
;        mov eax, 1
;        mov cr0, eax

mov si, 0
print:
        mov ah, 0x0e
        mov al, [0x8000 + si]
        int 0x10
        inc si
        cmp si, 512
        jne print

hlt

disk_adress_packet:
        db 0x10     ;size of dapack (16 bytes)
        db 0        ;always zero
        dw 0x1      ;read 1 packets for 512 bytes 
        dw 0x8000   ;transfer buffer start adress
        dw 0x0000   ;transfer buffer offset (16byte steps)
        dd 0X1      ;low 32bits of starting lba in 512byte units 
        dd 0        ;high 16bits of starting lba apperently it needs to be dd

times 510 - ($ - $$) db 0
dw 0xAA55
