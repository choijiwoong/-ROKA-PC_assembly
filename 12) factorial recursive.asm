COMMENT! factorial
segment .text
	global _fact
_fact:
	enter 0,0
	
	mov eax, [ebp+8];n
	cmp eax, 1
	jbe tern_cond;if n<=1, tern_cond
	
	dec eax
	push eax
	call _fact;fact(n-1)
	
	pop eax
	mul dword [ebp+8];edx:eax=eax(_fact(n-1)_)*n. recursive는 항상 넘모 어려웡
	jmp short end_fact
term_cond:
	mov eax, 1
end_fact:
	leave
	ret
!
	
;loop recursive print
%define i ebp-4
%define x ebp+8

segment .data
format db "%d",10,0;10='\n'

segment .text
	global _f
	extern _printf

_f:
	enter 4,0;independent variable per each recursive call.
	mov dword [i],0
lp:
	mov eax,[i]
	cmp eax,[x]
	jnl quit
	
	push eax; print(i)
	push format
	call _printf
	add esp, 8
	
	push dword [i]
	call _f
	pop eax
	
	inc dword [i]
	jmp short lp
quit:
	leave
	ret

;no deep thinking just convert this C to asm
;void f(int x){
;	int i;
;	for(i=0; i<x; i++){
;		printf("%d\n",i);
;		f(i);
;	}
;}