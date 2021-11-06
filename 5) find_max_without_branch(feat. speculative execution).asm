%include "asm_io.inc"

segment .data
message1 db "Enter a number: ",0
message2 db "Enter another number: ",0
message3 db "The larger number is: ",0

segment .bss
input1 resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, message1
	call print_string
	call read_int
	mov [input1], eax
	
	mov eax, message2
	call print_string
	call read_int
	
	xor ebx, ebx
	cmp eax, [input1]; input2-input1
	setg bl; input2>input1? 1:0
	neg ebx; 0xFFFFFFFF:0 (2's complement). it's called bit mask that is used for making bit we want to make. like ingredient of bit calculation
	mov ecx, ebx; ecx<-ebx
	and ecx, eax; ecx->input2:0
	not ebx; ebx->0:0xFFFFFFFF
	and ebx, [input1]; ebx->0:input1
	or ecx, ebx; ecx-> input2>input1? input2:input1
	
	mov eax, message3
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	
	popa
	mov eax, 0
	leave
	ret