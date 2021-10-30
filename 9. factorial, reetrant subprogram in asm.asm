;***factorial***
segment .text
	global _fact
_fact:
	enter 0,0
	
	mov eax, [ebp+8]; eax=n. move to eax for calculation. real n is in [ebp+8]
	cmp eax, 1;stop condition
	jbe term_cond; n<=1, exit
	dec eax
	push eax;eax=fact(n-1)
	call _fact
	pop eax;save resut to eax
	mul dword [ebp+8];edx:eax=eax*[ebp+8] -> eax=eax(_fact(n-1))* [ebp+8](_fact(n))
	jmp short end_fact
term_cond:
	mov eax, 1;if n=1, result is 1
end_fact:
	leave
	ret
;***factorial***


;***version C***


;***version asm***
%define i ebp-4 ;local variable
%define x ebp+8 ;argument
;useful mecro

segment .data
format db "%d", 10, 0; 10='\n'

segment .text
	global _f
	extern _printf
_f:
	enter 4,0;new i space for each loop in stack. independant variable i of f.
	
	mov dword [i],0;i=0
lp:;big loop
	mov eax, [i]
	cmp eax, [x]
	jnl quit;i<x?
	;inner for loop
	
	;printf("%d\n",i);
	push eax
	push format
	call _printf
	add esp, 8
	
	;f(i);
	push dword [i]
	call _f
	pop eax
	
	inc dword [i]
	jmp short lp
quit:
	leave 
	ret
;just think sqeuencely in C!
;***example asm***