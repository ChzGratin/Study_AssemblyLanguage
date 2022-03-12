[org 0]		;start at 0
[bits 16]	;16 bit

section .text

jmp $		;while(1){}

times 510 - ($-$$) db 0

;MBR signature (= dw 0xAA55)
db 0x55
db 0xAA