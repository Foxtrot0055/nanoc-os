bits 16
org 0x7c00

buffer:
				dw 0x8000
mov si, [buffer]

buffer_zero:
				mov [si], 0
				inc si
				cmp si, buffer + 256
				jne buffer_zero

load_kernel:
        mov ah, 0x42 ;bios function for reading drive in lba(modern) mode
        mov dl, 0x80 ;set drive 0x80 which should be the c drive
        int 0x13 ;bios int for function above
        mov si, disk_adress_packet
                
disk_adress_packet:
        db 0x10 ;size of dapack (16 bytes)
        db 0 ;always zero
        dw 16 ;read 16 packets for 8192 bytes 
        dw [buffer] ;transfer buffer
        dw 0x0003 ;transfer buffer offset (16byte steps)
        dd hello ;low 32bits of starting lba 
        dd 0 ;high 16bits of starting lba apperently it needs to be dd
        
;transition_to_protected_mode:
;        mov eax, cr0
;        mov eax, 1
;        mov cr0, eax

mov si, 0
print:
        mov ah, 0x0e
        mov al, [$$ + si]
        int 0x10
        inc si
        ;cmp byte [hello + si], 0
        ;jne print
        cmp si, 256
        jne print
        jmp print - 1

				
hlt
end_label:
times 510 - ($ - $$) db 0
dw 0xAA55

hello:
       times 0x0100 db "go"
