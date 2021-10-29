%include "asm_io.inc"

segment .data
sum dd 0

segment .bss
input resd 1

segment .text
	global _asm_main
	extern get_int, print_sum
_asm_main:
	enter 0,0
	pusha
	
	mov edx, 1;i
while_loop:
	push edx;i
	push dword input;address of input
	call get_int
	add esp, 8;remove in stack
	
	mov eax, [input]
	cmp eax, 0
	je end_while
	
	add [sum], eax
	
	inc edx
	jmp short while_loop

end_while:
	push dword[sum];sum
	call print_sum
	pop ecx;remove in stack
	
	popa
	leave
	ret