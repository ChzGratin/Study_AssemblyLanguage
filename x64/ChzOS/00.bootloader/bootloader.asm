%define pTargetAddress 0x1000	;void*

[org 0]		;start at 0
[bits 16]	;16 bit

section .text
	jmp 0x07C0:start	;cs = 0x07C0, jmp start
	
	;Do NOT use data section to store constants.
	;data: append constants after MBR signature
	cpHello: db "Hello, ChzOS!", 0	;char*, welcome message
	cpLoadingImage: db "Loading OS image...", 0
	cpDiskError: db "[Error] A disk error occurred.", 0
	cpLoadingComplete: db "Loading Complete!", 0
	
	iTotalSectorCount: dw 1024		;int
	iTrackNumber: db 0
	iHeadNumber: db 0
	iSectorNumber: db 2
	
	;pTargetAddress: dw 0x1000		;void*
	
start:
	;======== init stack ========
	mov ax, 0x0000
	mov ss, ax
	mov sp, 0xFFFE	;NOT 0xFFFF (compatibility with CP/M, data alignment)
	mov bp, 0xFFFE	;https://stackoverflow.com/questions/60805609/why-does-dos-set-the-sp-register-to-0xfffe-after-loading-a-com-file
					;https://stackoverflow.com/questions/4909563/why-should-code-be-aligned-to-even-address-boundaries-on-x86
	
	;======== use VGA text buffer ========
	mov ax, 0x07C0
	mov ds, ax
	mov ax, 0xB800	;VGA text buffer
	mov es, ax
	
	;======== screen clear ========
	mov si, 0
	
scrClear:
	mov byte[es:si], 0
	mov byte[es:si+1], 0x0007	;{background-color: black; color: white}
	
	add si, 2
	
	cmp si, 80*25*2
	jl scrClear
	
	;printMessage(1, 1, cpHello);
	push cpHello
	push 1
	push 1
	call printMessage
	add sp, 6	;__cdecl
	
	;printMessage(1, 2, cpHello);
	push cpLoadingImage
	push 2
	push 1
	call printMessage
	add sp, 6	;__cdecl
	
	;======== reset floppy ========
resetDisk:
	mov ax, 0
	mov dl, 0
	int 0x13
	jc error_disk
	
	;======== read floppy ========
	;mov es, pTargetAddress		;invalid combination of opcode and operands
	mov si, pTargetAddress
	mov es, si
	mov bx, 0x0000
	mov di, word[iTotalSectorCount]
	
readDisk:
	cmp di, 0
	je end_readDisk
	sub di, 0x1
	
	;call int 0x13
	mov ah, 0x02
	mov al, 1
	mov ch, byte[iTrackNumber]
	mov dh, byte[iHeadNumber]
	mov cl, byte[iSectorNumber]
	mov dl, 0
	int 0x13
	jc error_disk
	
	add si, 0x0200 / 16
	mov es, si
	
	;add byte[iSectorNumber], 1 ;Is it impossible?
	mov al, byte[iSectorNumber]
	add al, 1
	
	mov byte[iSectorNumber], al
	cmp al, 19
	jl readDisk
	
	mov byte[iSectorNumber], 0x01
	xor byte[iHeadNumber], 0x01
	
	cmp byte[iHeadNumber], 0x00
	jne readDisk
	
	add byte[iTrackNumber], 0x01
	jmp readDisk
end_readDisk:
	
	;printMessage(1, 3, cpLoadingComplete);
	push cpLoadingComplete
	push 3
	push 1
	call printMessage
	add sp, 6	;__cdecl
	
	;======== run OS Image ========
	jmp 0x1000:0x0000
	
;================================================================

;======== functions ========
error_disk:
	;printMessage(1, 3, cpDiskError);
	push cpDiskError
	push 3
	push 1
	call printMessage
	
	jmp $

printMessage:
	;void __cdecl printMessage(int x, int y, char* str)
	push bp
	mov bp, sp
	
	;func intro
	push es
	push si
	push di
	push ax
	push cx
	push dx
	
	;use VGA text buffer
	mov ax, 0xB800	;VGA text buffer
	mov es, ax
	
	;di <- 160*y + 2*x
	mov ax, word[bp+6]	;ax <- y
	mov si, 160			;length of a line [bytes]
	mul si				;ax <- ax * si
	mov di, ax
	
	mov ax, word[bp+4]	;ax <- x
	mov si, 2
	mul si
	add di, ax
	
	mov si, word[bp+8]	;si <- str
	
;print message
.loop:
	mov cl, byte[si]
	cmp cl, 0
	je .end_loop
	
	mov byte[es:di], cl	;putchar(cl)
	
	add si, 1
	add di, 2
	
	jmp .loop
	
.end_loop:
	pop dx
	pop cx
	pop ax
	pop di
	pop si
	pop es
	
	pop bp
	ret
	
	times 510 - ($-$$) db 0

	;MBR signature (= dw 0xAA55)
	db 0x55
	db 0xAA