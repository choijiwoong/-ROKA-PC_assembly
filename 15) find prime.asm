segment .text
	global _find_primes
	
;find_primes(int *a, unsigned n);
%define array ebp+8;int *array
%define n_find ebp+12;unsigned n_find
%define n ebp-4;num of found prime
%define isqrt ebp-8;low(sqrt(guess))
%define orig_cntl_wd ebp-10;original control word
%define new_sntl_wd ebp-12;new control word

_find_primes:
	enter 12,0
	
	push ebx
	push esi
	
	;control word setting to low
	fstcw word [orig_cntl_wd]
	mov ax, [orig_cntl_wd]
	or ax, 0C00h
	mov [new_cntl_wd], ax
	fldcw word [new_cntl_wd]
	
	mov esi, [array]
	mov dword [esi],2
	mov dword [esi+4],3
	mov dword [n],2
	mov ebx,5;guess
	
while_limit: ;find one prime per one loof
	mov eax, [n]
	cmp eax, [n_find]
	jnb short quit_limit
	
	;get floor(sqrt(guess))
	mov ecx, 1
	push ebx;guess to stack
	fild dword [esp];stack+0
	pop ebx;
	fsqrt;get sqrt(guess)
	fistp dword [isqrt];integerize. isqrt=floor(sqrt(guess))
	
while_factor:
	mov eax, dword [esi+4*ecx]; array[ecx]?????? isn't it dword[esi+4*(ecx-1)]??? [sol_maybe]그 소수배열에 인덱스 0부터 확인해야하는건 맞는데, guess가 5부터 시작하고 +=2씩하니 홀수이고, 소수배열의 첫번쨰는 2니까 그냥 패스한듯. 설명좀해주지..
	cmp eax, [isqrt]
	jnbe short quit_factor_prime;isqrt<array[ecx]
	
	mov eax, ebx;eax=guess
	xor edx, edx;edx=0
	div dword [esi+4*ecx];edx=remainer of eax/[esi+4*ecx]
	or edx, edx;remainer exist
	jz short quit_factor_not_prime;no remainer. perfectly divided
	inc ecx;
	jmp short while_factor
	
quit_factor_prime:
	mov eax, [n]
	mov dword [esi+4*eax], ebx;add to end
	inc eax
	mov [n], eax

quit_factor_not_prime:
	add ebx,2
	jmp short while_limit

quit_limit:
	fldcw word [orig_cntl_wd];restore control word
	pop esi
	pop ebx
	
	leave 
	ret