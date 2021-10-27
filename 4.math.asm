%include "asm_io.inc"

segment .data;string that will be printed
prompt	db	"Enter a number: ", 0
square_msg	db	"Square of input is  ", 0
cube_msg	db	"Cube of input is ", 0
cube25_msg	db	"Cube of input times 25 is ", 0
quot_msg	db	"Quotient of cube/100 is ", 0
rem_msg		db	"Remainder of cube/100 is ", 0
neg_msg		db	"The negation of the remainder is ", 0

segment .bss
input resd 1;initialization input as name

segment .text
	global _asm_main
_asm_main:
	enter 0,0;setup rootin
	pusha
	
	mov eax, prompt
	call print_string;"Enter a number"
	
	call read_int
	mov [input], eax
	
	imul eax;edx:eax=eax*eax??
	mov ebx, eax;save result to ebx
	mov eax, square_msg
	call print_string;"Square of input is "
	mov eax, ebx;get result of square to ebx
	call print_int;value print
	call print_nl
	
	mov ebx, eax;ebx=squared value
	imul ebx, [input]; ebx*=[input]. cubed value(x^3)
	mov eax, cube_msg
	call print_string;"Cube of input is "
	mov eax, ebx
	call print_int;value print
	call print_nl
	
	imul ecx, ebx, 25;ecx=ebx*25(input^3*25)
	mov eax, cube25_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	
	mov eax, ebx;ebx=cube now.
	cdq;initialization of edx for expandtion of operation
	mov ecx, 100;we can't divide by now value. so move value to ecx
	idiv ecx;edx:eax/ecx
	mov ecx, eax;save quotient to ecx
	mov eax, quot_msg
	call print_string;"Quotient of cube/100 is "
	mov eax, ecx
	call print_int;"quotient value print
	call print_nl
	mov eax, rem_msg
	call print_string;"Remainder of cube/100 is "
	mov eax, edx;get ramainder
	call print_int;remainder print
	call print_nl
	
	neg edx;-
	mov eax, neg_msg
	call print_string;"The negation of the remainder is "
	mov eax, edx
	call print_int;negative value print
	call print_nl
	
	popa
	mov eax, 0
	leave
	ret