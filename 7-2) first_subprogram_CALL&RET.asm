%include "asm_io.inc"

segment .data
prompt1 db "Enter a number: ",0
prompt2 db "Enter another number: ",0
outmsg1 db "You entered ",0
outmsg2 db " and ",0
outmsg3 db ", the sum of these is ",0

segment .bss
input1 resd 1
input2 resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt1
	call print_string
	
	mov ebx, input1
	call get_int
;ret1:
	mov eax, prompt2
	call print_string
	
	mov ebx, input2
	call get_int
	
	mov eax, [input1]
	add eax, [input2]
	mov ebx, eax
	
	mov eax, outmsg1
	call print_string
	mov eax, [input1]
	call print_int
	mov eax, outmsg2
	call print_string
	mov eax, [input2]
	call print_int
	mov eax, outmsg3
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	
	popa
	mov eax, 0
	leave
	ret
	
	
	
	
get_int:;subprogram
	call read_int
	mov [ebx], eax;save int to input1, save int to input2
	;push eax no!! get_int pop EAX value not return address. we have to pop data in stack. stack is LIFO list.
	ret