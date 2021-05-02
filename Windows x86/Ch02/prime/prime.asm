%include "asm_io.inc"

segment .data
	msg_input db "Enter a number: ", 0
	msg_ans1 db "Prime Number(s) up to ", 0
	msg_ans2 db ":", 0

segment .bss
	n resd 1
	curNum resd 1
	curFactor resd 1
	
segment .text
global _main
_main:
	enter 0, 0
	pusha
	
	;====get user input====
	mov eax, msg_input
	call print_string
	call read_int
	mov [n], eax
	
	mov eax, msg_ans1
	call print_string
	mov eax, [n]
	call print_int
	mov eax, msg_ans2
	call print_string
	call print_nl
	
	;====algorithm====
	mov eax, 2
	call print_int
	call print_nl
	
	mov dword[curNum], 3	;init
while_1:
	mov eax, [curNum]		;cmp [curNum], [n] is unavailable
	cmp eax, [n]
	jnl end_while_1
	
	mov eax, [curNum]
	mov ebx, 2				;div 2 is unavailable
	cdq
	div ebx
	
	cmp edx, 0				;curNum % 2 == 0 => curNum isn't a prime number
	je end_while_2
	
	mov dword[curFactor], 3
while_2:
	mov eax, [curFactor]
	cmp eax, [curNum]
	jl keep_going
	
	call print_int			;curFactor == curNum => curNum is a prime number
	call print_nl
	jmp end_while_2
	
keep_going:
	mov eax, [curNum]
	mov ebx, [curFactor]
	cdq
	div ebx
	
	cmp edx, 0				;curNum % curFactor == 0 => curNum isn't a prime number
	jz end_while_2
	add dword[curFactor], 2
	jmp while_2

end_while_2:
	add dword[curNum], 2
	jmp while_1

end_while_1:
	
	popa
	mov eax, 0
	leave
	ret