%include "asm_io.inc"

segment .data
	str_prompt db `Input a Number: `, 0
	str_vec2D_1 db `( `, 0
	str_vec2D_2 db `, `, 0
	str_vec2D_3 db ` )\n`, 0
	
segment .text
	global _main:
_main:
	enter 0, 0
	pusha
	
	sub esp, 8		;int a, b //local var.
	
	
	;====Input a, b====
	mov eax, str_prompt
	call print_string
	call read_int
	mov dword[ebp-4], eax
	
	mov eax, str_prompt
	call print_string
	call read_int
	mov dword[ebp-8], eax
	
	;====Print (a, b)====
	mov eax, str_vec2D_1
	call print_string
	
	mov eax, [ebp-4]
	call print_int
	
	mov eax, str_vec2D_2
	call print_string
	
	mov eax, [ebp-8]
	call print_int
	
	mov eax, str_vec2D_3
	call print_string
	
	
	;====Call swap(&a, &b)====
	lea eax, [ebp-4]
	push eax			;PUSH a
	lea eax, [ebp-8]
	push eax			;PUSH b
	call swap
	add esp, 8
	
	;====Print (b, a)====
	mov eax, str_vec2D_1
	call print_string
	
	mov eax, [ebp-4]
	call print_int
	
	mov eax, str_vec2D_2
	call print_string
	
	mov eax, [ebp-8]
	call print_int
	
	mov eax, str_vec2D_3
	call print_string
	
	
	popa
	mov eax, 0
	leave
	ret
	
swap:
	;void swap(int* a, int* b)
	;{
	;	int tmp;
	;	tmp = &a;
	;	&a = &b;
	;	&b = tmp;
	;}

	push ebp
	mov ebp, esp
	;&a = dword[EBP+12], &b = dword[EBP+8]
	
	sub esp, 4	;int tmp
	
	mov eax, [ebp+12]		;EAX = &a
	mov ecx, [ebp+8]		;ECX = &b
	
	mov edx, [eax]
	mov dword[ebp-4], edx	;tmp = &a
	
	mov edx, [ecx]
	mov dword[eax], edx		;&a = &b
	
	mov edx, [ebp-4]
	mov dword[ecx], edx		;&b = tmp
	
	mov esp, ebp
	pop ebp
	ret