;file: 2.first.asm

nasm -f coff 2.first.asm
gcc -o first first.o driver.c asm_io.o

%include "asm_to.inc"

segment .data ;initialized data to .data segment

prompt1 db "Enter a number: ", 0
prompt2 db "Enter another number: ", 0
outmsg1 db "You entered ", 0
outmsg2 db " and ", 0
outmsg3 db ", the sum of these is ", 0

segment .bss ;uninitialized data to .bss segment

input1 resd 1
input2 resd 1

segment .text ;for code
	global _asm_main

_asm_main:
	enter 0, 0;setup roatin
	pusha
	
	mov eax, prompt1;print prompt
	call print_string
	
	call read_int;read integeral
	mov [input1], eax;save to input1
	
	mov eax, prompt2;print prompt2
	call print_string
	
	call read_int;get int
	mov [input2], eax;save to input2
	
	mov eax, [input1];eax=input1's dword
	add eax, [input2];eax+=input2's dword
	mov ebx, eax
	
	dump_regs 1;print register value
	dump_mem 2, outmsg1, 1;print memory
	
	;print message sequencely
	
	mov eax, outmsg1
	call print_string;print first message
	mov eax, [input1]
	call print_int;print input1
	mov eax, outmsg2
	call print_string;print second message
	mov eax, [input2]
	call print_int;print input2
	mov eax, outmsg3
	call print_string;print third message
	mov eax, ebx
	call print_int;print sum(ebx)
	call print_nl;print '\n'
	
	popa
	mov eax, 0;return as C
	leave
	ret