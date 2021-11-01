;for more speed, we use prime list, and we only find number under sqrt(num)
;so we have to use fall than round. we can this work by change 10bit & 11bit of control word
;coprocessor fall if both bits are 1. in addition, we habe to restore original control bit.

segment .text
	global _find_primes
	
;find_primes function-> find prime as much as assigned number
;Origin C: extern void find_primes(int *array unsigned n_find)
;Argument:
;	array- list for primes that we found
;	n_find- num of primes we want to find

%define array ebp+8
%define n_find ebp+12; num that we want to get primes
%define n ebp-4; num of found primes now
%define isqrt ebp-8; falled value of sqrt(guess)
%define orig_cntl_wd ebp-10; origin control word value
%define new_cntl_wd ebp-12; new control word value

_find_primes:
	;initial setting
	enter 12,0; for local variable
	
	push ebx
	push esi
	
	;change control bit 
	fstcw word [orig_cntl_wd];save control bit now
	mov ax, [orig_cntl_wd]; for edit control bit
	or ax, 0C00h; round bit to 11(fall)
	mov [new_cntl_wd], ax
	fldcw word [new_cntl_wd];set changed value to control bit
	
	;ready for find
	mov esi, [array]; esi points array
	mov dword [esi], 2; array[0]=2
	mov dword [esi+4], 3; array[1]=3
	mov ebx, 5; ebx=guess=5
	mov dword [n], 2; n=2. num of found primes now
	
;this outside loop find one prime by each loof. we only divide guess by primes that we already found it prime (in array)
while_limit:
	;check escape condition
	mov eax, [n]
	cmp eax, [n_find]; while(n<n_find)
	jnb short quit_limit
	
	;get isqrt
	mov ecx, 1;point location of element
	push ebx; guess to stack
	fild dword [esp]; guess to coprecessor's stack for calculation of sqrt
	pop ebx
	fsqrt; get sqrt(guess)
	fistp dword [isqrt]; isqrt=floor(sqrt(guess))

;this inner loop divide guess by array's primes until array's element is bigger than floor(sqrt(guess))
while_factor:
	;check escape condition
	mov eax, dword [esi+4*ecx];eax=array[ecx]
	cmp eax, [isqrt]; 	while(isqrt<array[ecx]
	jnbe short quit_factor_prime
	
	;check escape condition 2
	mov eax, ebx; eax=guess
	xor edx, edx; is it for change flag bit? maybe initialization to ZERO of flag register. EDX is used with eax ??????
	div dword [esi+4*ecx]; div guess by array[ecx]
	or edx, edx; 		&&guess guess%array[ecx]!=0) 뭐가 어찌됬던 만약 나눠진다! 라면 quit factor not prime으로 점프하라 라는 의미
	jz short quit_factor_not_prime; jz is jump if flag ZERO
	
	;check isqrt by next element
	inc ecx; try by next prime
	jmp short while_factor
	
;if find new prime
quit_factor_prime:
	mov eax, [n]
	mov dword [esi+4*eax], ebx; add guess to array
	inc eax
	mov [n], eax; inc n

;if it's not prime
quit_factor_not_prime:
	add ebx, 2; try next odd number
	jmp short while_limit

;if all works is end
quit_limit:
	fldw word [orig_cntl_wd]; restore control word
	pop esi
	pop ebx; restore register variables
	
	leave 
	ret