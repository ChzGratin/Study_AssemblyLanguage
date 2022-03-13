[org 0]		;start at 0
[bits 16]	;16 bit

section .text
	jmp 0x07C0:START	;cs = 0x07C0, jmp START

START:
	mov ax, 0x07C0
	mov ds, ax
	mov ax, 0xB800	;VGA text buffer
	mov es, ax
	
	;======== screen clear ========
	mov si, 0
	
SCRCLEAR:
	mov byte[es:si], 0
	mov byte[es:si+1], 0x0007	;{background-color: black; color: white}
	
	add si, 2
	
	cmp si, 80*25*2
	jl SCRCLEAR
	
	;======== put string   ========
	mov si, 0
	mov di, 0
	
PUTSTR:
	mov cl, byte[MSG_HELLO+si]
	cmp cl, 0
	je ENDPUTSTR
	
	mov byte[es:di], cl
	
	add si, 1
	add di, 2
	
	jmp PUTSTR
ENDPUTSTR:
	
	jmp $	;while(1){}
	
MSG_HELLO: db "Hello, ChzOS!", 0
	
	times 510 - ($-$$) db 0

	;MBR signature (= dw 0xAA55)
	db 0x55
	db 0xAA