[org 0xFC00]
[bits 32]

mov al, 'B'
mov ah, 0b00001111
mov esi, 0
mov ebx, 0xb8000
loop_start:
        mov [ebx + esi*2], ax
        inc si
        cmp si, 2000
        jnz loop_start
hlt
