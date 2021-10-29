%include "asm_io_inc"

segment .data
prompt1 db "Enter a number: ",0;don't forget null!
prompt2 db "Enter another number: ",0
outmsg1 db "You entered ",0
outmsg2 db " and ",0
outmsg3 db ", the sum of these is ",0

segment .bss
input1 resd 1
input2 resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt1
	call print_string;"Enter a number: "
	
	;***version-1***
	;mov ebx, input1;save storage for input1 to ebx
	;mov ecx, ret1;save return address to ecx
	;jmp short get_int;read int
;ret1:
	;mov eax, prompt2
	;call print_string;"Enter another number: "
	
	;mov ebx, input2
	;mov ecx, $+7;ecx=current_address(column)+7; line.34 (더하는 기준이 뭔지 잘 모르겠지만, 이곳부터 jmp의 dubprogram포함 총 line이라고 생각해야겠다)
	;jmp short get_int
	;***version-1***
	
	;***version-2***
	mov ebx, input1
	call get_int;push
	
	mov ebx, input2
	call get_int
	;***version-2***
	
	mov eax, [input1]
	add eax, [input2]
	mov ebx, eax;save sum to ebx
	
	mov eax, outmsg1
	call print_string;"You entered "
	mov eax, [input1]
	call print_int
	mov eax, outmsg2
	call print_string;" and "
	mov eax, [input2]
	call print_int
	mov eax, outmsg3;", the sum of these is "
	call print_string
	mov eax, ebx
	call print_int
	call print_ln
	
	popa
	mov eax, 0
	leave
	ret
	
;subprogram get_int
;argument:
;	ebx-address of dword saving integer
;	ecx-address of command will return
;p.s:
;	value of eax will be removed

;***version-1***
;get_int:
	;call read_int
	;mov [ebx], eax;save value to ebx
	;jmp ecx;return to called location in ecx
;***version-1***

;***version-2***
get_int:
	call read_int
	mov [ebx], eax
	ret;pop
;***version-2***

;***wrong***
get_int:
	call read_int
	mov [ebx], eax
	push eax
	ret;pop eax not return address! because of stack structure
;***wrong***