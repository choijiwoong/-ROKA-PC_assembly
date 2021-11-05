%include "asm_io.inc"

segment .data
prompt db "Enter a number: ",0
square_msg db "Square of input is ",0
sube_msg db "Cube of input is ",0
cube25_msg db "Cube of input times 25 is ",0
quot_msg db "Quotient of cube/100 is ",0
rem_msg db "Remainder of cube/100 is ",0
neg_msg db "The negation of the remainder is ",0

segment .bss
input resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt
	call print_string
	
	call read_int
	mov [input], eax
	
	imul eax; edx:eax=eax*eax
	mov ebx, eax; save input^2
	mov eax, square_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	
	mov ebx, eax; get retuen value 0
	imul ebx, [input]; ebx(input^2)=ebx*input
	mov eax, sube_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	
	imul ecx, ebx, 25; ecx=ebx*25
	mov eax, cube25_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	
	mov eax, ebx; input^3
	cdq; Convert Double word to Quard word. EAX->EDX:EAX(64bit) initialization of edx!
	mov ecx, 100; we can't idiv "ecx, 100(immediate)"
	idiv ecx; edx:eax /ecx. remainer is in edx, value is in eax
	mov ecx, eax; value to ecx
	mov eax, quot_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	mov eax, rem_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	neg edx; - to remainer
	mov eax, neg_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	popa
	mov eax,0
	leave
	ret