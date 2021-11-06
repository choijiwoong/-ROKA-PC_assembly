COMMENT!
unsigned guess;
unsigned factor;
unsigned limit;

printf("Find primes up to: ");
scanf("%u", &limit);
printf("2\n3\n");
guess=5;
while(guess<=limit){
	factor=3;
	while(factor*factor<guess&&guess%factor!=0)
		factor+=2;
	if(guess%factor!=0)
		printf("%d\n", guess);
	guess+=2;
}
!

%include "asm_io.inc"

segment .data
Message db "Find primes up to: ",0

segment .bss
Limit resd 1
Guess resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, Message
	call print_string
	call read_int
	mov [Limit],eax
	
	mov eax,2
	call print_int
	call print_nl
	mov eax,3
	call print_int
	call print_nl
	
	mov dword [Guess], 5
while_limit:
	mov eax, [Guess]
	cmp eax, [Limit]
	jnbe end_while_limit; guess>limit, end_while_limit(end of program)
	
	mov ebx, 3;factor
while_factor:
	mov eax, ebx
	mul eax;edx:eax=eax*eax
	jo end_while_factor; except overflow, end_while_factor(check real prime, reloop for new guess. if overflow, it will be threaded at jnbe)
	cmp eax, [Guess]
	jnb end_while_factor;factor*factor>=guess, end_while_factor(check real prime, reloop for new guess)
	mov eax, [Guess]
	mov edx, 0
	div ebx; edx= edx:eax % factor
	cmp edx,0;it's perfectly divided?(check remainer)
	je end_while_factor;it's not prime!
	
	add ebx,2;factor+=2
	jmp while_factor
end_while_factor:
	je end_if:
	mov eax, [guess]
	call print_int
	call print_nl
end_if:
	add dword [Guess], 2
	jmp while_limit
end_while_limit:
	
	popa
	mov eax,0
	leave
	ret