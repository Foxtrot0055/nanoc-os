[bits 16]
[org 0x7c00]

buffer:
	dw 0x8000


load_kernel:
        xor di, di
        mov ah, 0x42 ;bios function for reading drive in lba(modern) mode
        mov dl, 0x80 ;set drive 0x80 which should be the c drive
        lea si, [disk_adress_packet]
        int 0x13 ;bios int for function above         

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start


transition_to_protected_mode:
        cli
        lgdt [GDT_Descriptor]
        mov eax, cr0
        or al, 1
        mov cr0, eax
        jmp CODE_SEG:start_protected_mode

hlt
        
disk_adress_packet:
        db 0x10     ;size of dapack (16 bytes)
        db 0        ;always zero
        dw 0x1      ;read 1 packets for 512b 
        dw 0x8000   ;transfer buffer start adress
        dw 0x0000   ;transfer buffer offset (16byte steps)
        dd 0X1      ;low 32bits of starting lba in 512byte units 
        dd 0        ;high 16bits of starting lba apperently it needs to be dd


GDT_Start:
        null_descriptor:
                dd 0x0
                dd 0x0
                
        code_descriptor:
                dw 0xFFFF; first 16bits of limit
                dw 0x0; first 24bits
                db 0x0
                db 0b10011010; access byte
                db 0b11001111; xxxx=flags | xxxx=4bits of limit
                db 0x0
        data_descriptor:
                dw 0xFFFF; first 16bits of limit
                dw 0x0000; first 24bits
                db 0x00
                db 0b10010010; access byte
                db 0b11001111; xxxx=flags | xxxx=4bits of limit
                db 0x0
GDT_End:
        
GDT_Descriptor:
        dw GDT_End - GDT_Start - 1        ;size
        dd GDT_Start

[bits 32]
start_protected_mode:
        jmp 0x8000

times 510 - ($ - $$) db 0
dw 0xAA55
