%include "asm_io.inc"

segment .data
	str_HW db `Hello, world!\n`, 0
	
segment .text
	global print_HelloWorld
	
print_HelloWorld:
	push ebp
	mov ebp, esp
	
	mov eax, str_HW
	call print_string
	
	mov esp, ebp
	pop ebp;
	ret