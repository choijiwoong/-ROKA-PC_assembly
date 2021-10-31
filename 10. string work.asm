global _asm_copy, _asm_find, _asm_strlen, _asm_strcpy

segment .text

;_asm_copy fuction-> copy memory block
;origin C: void asm_sopy(void *dest, const void *src, unsigned sz);
;arguments:
;	dest-buffer pointer that will be saved
;	src-pointer point buffer will be copied
;	sz-bites num copy

;simbols
%define dest [ebp+8]
%define src [ebp+12]
%define sz [ebp+16]

_asm_copy:
	enter 0,0
	push esi;we will use it by pointer. backup
	push edi
	
	mov esi, src;buffer's address
	mov edi, dest;storage's address
	mov ecx, sz;bytes num
	
	cld;initialization direction flag
	rep movsb; repeat movsb ECX
	
	pop edi
	pop esi
	leave 
	ret
	
;_asm_finc function->search special byte in memory
;origin C: void* asm_find(const void *src, char target, unsigned sz);
;aeguments:
;	src-pointer of buffer that will be searched
;	target-bytes for search
;	sz-size of buffer's byte
;return:
;	if find target, pointer point first target
;	else null
;p.s:
;	target is byte, but it push format of double word to stack. so byte value is saved in low 8 bits
%define src [ebp+8]
%define target [ebp+12]
%define sz [ebp+16]

_asm_find:
	enter 0,0
	push edi; we will use edi. so backup
	
	mov eax, target;al save byte value
	mov edi, src
	mov ecx, sz
	cld
	
	repne scasb; search ECX==0 or [ES:EDI]==AL
	
	je found_it;if zero set, success
	mov eax, 0;if not found, null
	jmp short quit
found_it:
	mov eax, edi
	dec eax;return (DI-1)
quit:
	pop edi
	leave
	ret
	
;_asm_strlen function->return size of string
;origin C: unsigned asm_strlen(const char*);
;arguments:
;	src-pointer points string
;return:
;	num of char in string without 0. (return by EAX)
%define src [ebp+8]

_asm_strlen:
	enter 0,0
	push edi;
	
	mov edi, src
	mov ecx, 0FFFFFFFFh;most big value of ECX
	xor al, al;al=0 ???
	cld
	
	repnz scasb; find 0
	
	;repnx execute one step more, so it's lenght is FFFFFFFF-ECX not FFFFFFFFE-ECX.
	mov eax, 0FFFFFFFFh
	sub eax, ecx;length
	
	pop edi
	leave ret
	
;_asm_strcpy function->copy string
;origin C: void asm_strcpy(char *dest, condt char *src);
;arguments:
;	dest-pointer point result string
;	src-pointer point string will be copied
%define dest [ebp+8]
%define src [ebp+12]

_asm_strcpy:
	enter 0,0
	push esi
	push edi
	
	mov edi, dest
	mov esi, src
	cld
cpy_loop:
	lodsb;get AL, &si++
	stosb;save AL, &di++
	or al, al;set condition flag for under jnz. refresh stat of condition flag
	jnz cpy_loop;if not zero
	
	pop edi
	pop esi
	leave
	ret