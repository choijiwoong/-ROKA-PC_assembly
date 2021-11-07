global _asm_copy, _asm_find, _asm_strlen, _asm_strcpy

segment .text

;_asm_copy
%define dest [ebp+8]
%define src [ebp+12]
%define sz [ebp+16];how many bytes

_asm_copy:
	enter 0,0
	push esi
	push edi
	
	mov esi, src
	mov edi, dest
	mov ecx, sz
	
	cld;DF
	rep movsb
	
	pop edi
	pop esi
	leave
	ret
	
	
;_asm_find
%define src [ebp+8]
%define target [ebp+12];byte for search
%define sz [ebp+16]

_asm_find:
	enter 0,0
	push edi
	
	mov eax, target
	mov edi, src
	mov ecx, sz
	cld;DF
	
	repne scasb
	
	je found_it
	mov eax,0;fail_return NULLPTR
	jmp short quit
found_it:
	mov eax, edi
	dec eax;for return. scasb는 찾아도 inc하기에 한번 --
quit:
	pop edi
	leave
	ret
	
	
;_asm_strlen
%define src [ebp+8]

_asm_strlen:
	enter 0,0
	push edi
	
	mov edi, src
	mov ecx, 0FFFFFFFFh;jonna mani
	xor al, al
	cld;DF
	
	repnz scasb;execute as much as string length. it can check how many ecx is dec per loop(문자열이 끝이 아니고, ecx!=0일때인데, scasb가 의미하는 같고다르고는 중요하지 않고 얼마나 실행되었는지만 필요함)
	mov eax, 0FFFFFFFFh
	sub eax, ecx;0FFFFFFFFh-count of execution of repnz
	
	pop edi
	leave
	ret
	

;_asm_strcpy
%define dest [ebp+8]
%define src [ebp+12]

_asm_strcpy:
	enter 0,0
	push esi
	push edi
	
	mov edi, dest
	mov esi, src
	cld;DF
cpy_loop:
	lodsb
	stosb
	;movsb
	or al, al;set flag. check 0,0
	jnz cpy_loop
	
	pop edi
	pop esi
	leave
	ret