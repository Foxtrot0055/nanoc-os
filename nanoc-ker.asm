[org 0xFC00]
[bits 32]

mov al, 'B'
mov ah, 0x01
mov [0xb8000], ax
