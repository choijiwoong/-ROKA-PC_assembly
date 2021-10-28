%include "asm_io.inc"

segment .data;const
Message	db	"Find primes up to: ",0

segment .bss;variable
Limit resd 1;find prime until this number
Guess resd 1;guess thing as prime

segment .text
	global _asm_main
_asm_main:
	enter 0,0;setup rootin
	pusha
	
	mov eax, Message
	call print_string
	call read_int;scanf("%u", &limit);
	mov [Limit], eax;Limit is defined by double word
	
	mov eax, 2;printf("2\n");
	call print_int
	call print_ln
	mov eax, 3;printf("3\n");
	call print_int
	call print_ln
	
	mov dword [Guess], 5;Guess=5; we defined Guess as double word! so we use dword for saving value
while_limit:			;while(Guess<=Limit)
	mov eax, [Guess]
	cmp eax, [Limit]
	jnbe end_while_limit; (unsigned)jnbe: jnbe_vleft>vright->branch __while loop block.1
	
	mov ebx, 3;factor(ebx)=3
while_factor:
	mov eax, ebx
	mul eax;edx:eax=eax*eax
	jo end_while_factor;jump if overflow
	cmp eax, [Guess];checking factor*factor<guess
	jnb end_while_factor;if !(factor*factor<guess) (unsigned) jnb: vleft>=vright->branch __first condition of while loop block.2
	mov eax, [Guess]
	mov edx, 0
	div ebx;edx=edx:eax%ebx ??
	cmp edx, 0; checking guess%factor!=0
	je end_while_factor;if !(guess%factor!=0)  (unsigned)jnbe: jnbe_vleft>vright->branch __second condition of while loop block.2
	
	add ebx, 2;factor+=2;
	jmp while_factor
end_while_factor:;__if condition
	je end_if;if !(guess%factor!=0)	(unsigned)jnbe: jnbe_vleft>vright->branch
	mov eax, [Guess]
	call print_int
	call print_nl
end_if:
	add dword [Guess], 2;guess+=2
	jmp while_limit
end_while_limit:

	popa
	mov eax, 0;return back to C
	leave
	ret