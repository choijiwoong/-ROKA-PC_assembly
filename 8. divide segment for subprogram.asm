%include "asm_io.inc"

segment .data
sum dd 0

segment .bss
input resd 1

;pseudo code algorithm
;i=1
;sum=0
;while(get_int(i, &input), input!=0){
;	sum+=input;
;	i++;
;}
;print_sum(sum)

segment .text
	global _asm_main
_asm_main:
	enter 0,0;setup rootin
	pusha
	
	mov edx, 1;i->edx
while_loop:
	push edx;push arguments for get_int(i, &input) in pseudo code!
	push dword input;We must check if pushed data is double word
	call get_int
	add esp, 8;remove argument in stack
	
	mov eax, [input]
	cmp eax, 0
	je end_while
	
	add [sum], eax; sum+=input
	
	int edx
	jmp short while_loop

end_while:
	push dword [sum];push sum to stack
	call print_sum
	pop ecx; remove argument(sum) in stack
	
	popa
	leave
	ret
	


;subprogram get_int
;arguments(by pushed order)
;	num of input values
;	address of word that will be saved input value
;p.s
;	values of eax&ebx will be removed
segment .data
prompt db "Enter an integer number (0 to quit): ",0

segment .text
get_int:
	push ebp;backup for using stack in subprogram
	mov ebp, esp;use ebp like esp
	
	mov eax, [ebp+12];ebp, return address, &input, edx
	call print_int;print i
	
	mov eax, prompt
	call print_string
	
	call read_int
	mov ebx, [ebp+8];ebx=&input
	mov [ebx], eax;save inputted value to memory(input)
	
	pop ebp;back to initial stat of stack with argument
	ret
	
	
	
;subprogram print_sum
;print sum
;arguments:
;	sum that is located [ebp+8]
;p.s:
;	eax's value will be removed
segment .data
result db "The sum is ", 0

segment .text
print_sum:
	push ebp; ebp, return address, sum
	mov ebp, esp
	
	mov eax, result
	call print_string
	
	mov eax, [ebp+8]
	call print_int
	call print_ln
	
	pop ebp
	ret