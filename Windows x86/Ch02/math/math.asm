%include "asm_io.inc"

segment .data
prompt 		db "Enter a number: ", 0
square_msg 	db "Square of input is ", 0
cube_msg 	db "Cube of input is ", 0
cube25_msg 	db "Cube of input times 25 is ", 0
quot_msg 	db "Quotient of cube/100 is ", 0
rem_msg 	db "Remainder of cube/100 is ", 0
neg_msg		db "The negation of the remainder is ", 0

segment .bss
input resd 1 ;REServe 1 DWord

segment .text
	global _main
_main:
	enter 0, 0
	pusha
	
	mov eax, prompt	;store first address of "Enter a number: " in EAX
	call print_string ;printf("%s", EAX)
	
	call read_int	;store user input in EAX
	mov [input], eax
	;state: eax = [input]
	
	;square
	mov ebx, [input]
	imul ebx, [input]
	mov eax, square_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	;state: ebx = [input]^2
	
	;cube
	imul ebx, [input]
	mov eax, cube_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	;state: ebx = [input]^3
	
	;cube * 25
	imul edx, ebx, 25
	mov eax, cube25_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	;Q of cube / 100
	mov ecx, 100
	mov eax, ebx
	cdq					;Initialize DX/EDX before using DIV/IDIV!
	idiv ecx
	mov ecx, eax		;state: ecx = Quotient, edx = Remainder
	mov eax, quot_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	
	;R of cube / 100
	mov eax, rem_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	;-cube
	neg edx
	mov eax, neg_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	popa
	mov eax, 0 ;return 0
	leave
	ret