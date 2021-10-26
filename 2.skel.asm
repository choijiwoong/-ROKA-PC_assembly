%include "asm_io.inc"

segment .data
;initialized data

;

segment .bss
;not initialized data

;

segment .text
	global _asm_main
_asm_main:
	enter 0,0;setup rootin
	pusha
	
;code to text segment

	popa
	mov eax, 0;return as C
	leave 
	ret