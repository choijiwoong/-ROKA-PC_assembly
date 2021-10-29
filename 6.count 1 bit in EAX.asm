%include "asm_io.inc"

segment .data

segment .bss

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	push a
	
	mov bl, 0
	mov ecx, 32;loop counter
count_loop:
	shl eax, 1;shifted bit to carry flag
	jnc skip_inc;CF==0, skip_inc
	inc bl
skip_inc:
	loop count_loop
	
	popa
	mov eax, 0
	leave
	ret