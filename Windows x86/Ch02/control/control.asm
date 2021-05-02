%include "asm_io.inc"

segment .text
	global _main
_main:
	enter 0, 0
	pusha
	
	;
	
	popa
	mov eax, 0
	leave
	ret