[org 0x00]
[bits 16]

segment .text	;same with section .text
	jmp 0x1000:start
	
	iSectorCount: dw 0x0000
	TOTALSECTORCOUNT equ 1024	;same with #define TOTALSECTORCOUNT 1024
								;No memory is allocated for TOTALSECTORCOUNT.
	
start:
	;======== use VGA text buffer ========
	;data segment <- code segment
	mov ax, cs
	mov ds, ax
	;VGA text buffer
	mov ax, 0xB800
	mov es, ax
	
%assign i 0
%rep TOTALSECTORCOUNT
	%assign i i+1
	
	;======== print 012...9 ========
	mov ax, 2
	mul word[iSectorCount]	;ax <- ax * iSectorCount
	mov si, ax
	
	mov byte[es:si + (160*2)], '0' + (i % 10)	;print from the 3rd line
	add word[iSectorCount], 1
	
	%if i == TOTALSECTORCOUNT
		jmp $
	%else
		jmp (0x1000 + i * 0x20):0x0000	;goto next sector offset
	%endif
	
	jmp $
	
	times (512 - ($ - $$) % 512) db 0x00
	
%endrep