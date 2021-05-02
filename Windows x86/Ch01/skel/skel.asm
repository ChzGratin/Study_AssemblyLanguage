%include "asm_io.inc" ;cf) #include <stdio.h>

segment .data ;initialized memory

segment .bss ;un-initialized memory

segment .text ;codes
	global _main ;main()
_main:
	enter 0, 0
	pusha
	
	;body of main()
	
	popa
	mov eax, 0 ;return 0
	leave
	ret