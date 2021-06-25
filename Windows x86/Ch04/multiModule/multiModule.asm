%include "asm_io.inc"

segment .text
	global _main
	extern print_HelloWorld
	
_main:
	enter 0, 0
	pusha
	
	call print_HelloWorld
	
	popa
	mov eax, 0
	leave
	ret