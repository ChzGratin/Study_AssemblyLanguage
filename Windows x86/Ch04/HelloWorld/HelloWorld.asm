segment .data
	format db `Hello, world!\n`, 0
	
segment .text
	extern _printf
	global _main
	
_main:
	enter 0, 0
	push ebp
	mov ebp, esp
	push ebx
	
	push format
	call _printf
	add esp, 4
	
	pop ebx
	mov eax, 0
	leave
	ret