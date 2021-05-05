%include "asm_io.inc"

segment .data
	msg_main_call 	db `main() is called.\n`, 0
	msg_main_retrun db `main() return 0.\n`, 0
	msg_sub_call 	db `sub() is called.\n`, 0
	msg_sub_return 	db `sub() return None.\n`, 0
	
segment .text
	global _main:
_main:
	enter 0, 0
	pusha
	
	mov eax, msg_main_call
	call print_string
	
	;====Method 1====
	mov ecx, $+7		;$ == (Current Address)
	jmp short _sub
	
	;mov ecx, $+10
	;jmp near _sub
	
	;====Method 2====
	mov ecx, ret_sub	;ECX = (Return Address)
	jmp short _sub		;call sub()
ret_sub:				;Return Address of sub()
	
	mov eax, msg_main_retrun
	call print_string
	
	popa
	mov eax, 0
	leave
	ret
	
_sub:
	;IMPORTANT!!
	;ECX should NOT be changed!
	
	mov eax, msg_sub_call
	call print_string
	
	;do something
	
	mov eax, msg_sub_return
	call print_string
	jmp ecx