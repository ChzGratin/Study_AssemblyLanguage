%define ARR_SIZE 5

segment .data
	input_prompt db "Input %d-th Element: ", 0
	input_format db "%d", 0
	output_format db `%d-th element: %d\n`, 0

segment .bss
	arr resd ARR_SIZE

segment .text
	extern _printf, _scanf
	global _main
	
_main:
	enter 0, 0
	push ebp
	mov ebp, esp
	push ebx
	sub esp, 4		;int i //counter, dword[ebp-8]
	
	mov dword[ebp-8], 0			;i = 0
lp_Input:
	push dword[ebp-8]
	push dword input_prompt
	call _printf
	add esp, 8
	
	mov eax, dword[ebp-8]		;EAX = i
	shl eax, 2					;EAX = i * sizeof(int)
	add eax, arr				;EAX = i * sizeof(int) + arr
	push eax
	push dword input_format
	call _scanf
	add esp, 8
	
	inc dword[ebp-8]
	cmp dword[ebp-8], ARR_SIZE
	jl lp_Input
	
	mov dword[ebp-8], 0			;i = 0
lp_Output:
	mov eax, dword[ebp-8]		;EAX = i
	shl eax, 2					;EAX = i * sizeof(int)
	add eax, arr				;EAX = i * sizeof(int) + arr
	mov eax, dword[eax]			;EAX = *(int*)(i * sizeof(int) + arr)
	push eax
	push dword[ebp-8]
	push output_format
	call _printf
	add esp, 8
	
	inc dword[ebp-8]
	cmp dword[ebp-8], ARR_SIZE
	jl lp_Output
	
	mov eax, 0
	pop ebx
	leave
	ret