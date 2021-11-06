%include "asm_io.inc"

segment .data
sum dd 0

segment .bss
input resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov edx,1
while_loop:
	push edx
	push dword input
	call get_int
	add esp,8;remove argument
	
	mov eax, [input]
	cmp eax,0
	je end_while
	
	add [sum], eax
	
	inc edx
	jmp short while_loop

end_while:
	push dword [sum]
	call print_sum
	pop ecx;remove argument
	
	popa
	leave
	ret
	
;get_int(subprogram)
segment .data
prompt db ") Enter an integer number (0 to quit): ",0

segment .text
get_int:
	push ebp;backup ebp, for use another pointer; EBP
	mov ebp, esp;we have to use ebp for accessing to argument because esp is shifted by num of arguments, local variable.
				;so we backup initial status of esp when we call subprogram. 
	mov eax,[ebp+12]
	call print_int; print i
	
	mov eax, prompt
	call print_string
	
	call read_int
	mov ebx, [ebp+8]
	mov [ebx], eax
	
	pop ebp
	ret
	
;print_sum(subprogram)
segment .data
result db "The sum is ",0

segment .text
print_sum:
	push ebp
	mov ebp, esp
	
	mov eax, result
	call print_string
	
	mov eax,[ebp+8]
	call print_int
	call print_nl
	
	pop ebp
	ret