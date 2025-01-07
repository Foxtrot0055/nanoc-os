bits 16
org 0x7c00

load_kernel:
        mov ah, 0x42 ;bios function for reading drive in lba(modern) mode
        mov dl, 0x80 ;set drive 0x80 which should be the c drive
        int 0x13 ;bios int for function above
        mov si, disk_adress_packet
        mov ds, 0
                
disk_adress_packet:
        db 0x10 ;size of packet(16 bytes)
        db 0 ;always zero
        dw 0x0010 ;load 256 packets for 4KiB
        dd 0 ;transfer buffer
        dd end_label + 2 ;low 32bits of starting lba
        dw 0x7E00
        dw 0 ;high 16bits of starting lba apperently it needs to be dd
        
;transition_to_protected_mode:
;        mov eax, cr0
;        mov eax, 1
;        mov cr0, eax

mov si, 0
print:
        mov ah, 0x0e
        mov al, [hello + si]
        int 0x10
        inc si
        cmp byte [hello + si], 0
        jne print

hlt
end_label:
times 510 - ($ - $$) db 0
dw 0xAA55

hello:
        db "Hello, world", 0
