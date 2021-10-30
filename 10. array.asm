%define ARRAY_SIZE 100
%define NEW_LINE 10

segment .data
FirstMsg db "First 10 elements of array",0
Prompt db "Enter index of element to display: ",0
SecondMsg db "Element %d is %d", NEW_LINE, 0
ThirdMsg db "Element 20 through 29 of array", 0
InputFormat db "%d",0

segment .bss
array resd ARRAY_SIZE

segment .text
	extern _puts, _printf, _scanf, _dump_line
	global _asm_main
_asm_main:
	enter 4,0;EBP-4 local double word variable. array
	push ebx
	push esi;??Extended Source Index_데이터 조작이나 복사 시 소스 데이터의 주소 저장. backup for InputOK
	
	mov ecx, ARRAY_SIZE;100
	mov ebx, array
_init_loop:
	mov [ebx], ecx
	add ebx, 4
	loop init_loop;save data in array
	
	push dword FirstMsg;print "First 10 elements of array"
	call _puts
	pop ecx;get return
	
	push dword 10
	push dword array
	call _print_array; print first 10 element. normal function
	add esp, 8;remove argument
	
;prompt user for element index
Prompt_loop:
	push dword Prompt
	call _printf
	pop ecx;print "Enter index of element to display: "
	
	lea eax, [ebp-4];eax=local dword address. array
	push eax
	push dword InputFormat
	call _scanf;get int data to array
	add esp, 8;remove argument
	cmp eax, 1;if scaned value is 1
	je InputOK
	
	;if not, rescan
	call _dump_line; ramain column dump, and restart
	jmp Prompt_loop;if input value is not correct
	
InputOK:
	mov esi, [ebp-4];array address to esi??? no. it's value
	push dword [array+4*esi]
	push esi
	push dword SecondMsg
	call _printf
	add esp, 12;print "Element %d is %d" address in that index with value in asi.
	
	push dword ThirdMsg
	call _puts
	pop ecx;print "Element 20 through 29 of array"
	
	push dword 10
	push dword array+20*4
	call _print_array;print array 10 elements at array+20*4
	add esp, 8;remove element
	
	pop esi
	pop ebx;restore
	mov eax, 0; return to C
	leave 
	ret
	
	
	
;_print_array rootin
;call in C is possible. dword array->signed int print
;void print_array(const int *a, int n); in C
;argument:
;	a-pointer of array[ebp+8]
;	n-num of print[ebp+12]

segment .data
OutputFormat db "%-5d %5d", NEW_LINE, 0 ;??

segment .text
	global _print_array
_print_array:
	enter 0,0
	push esi
	push ebx;backup
	
	xor esi, esi;esi=0. index
	mov ecx, [ebp+12];n
	mov ebx, [ebp+8];address of array
print_loop:
	push ecx;printf change value of ecx
	
	push dword [ebx+4*esi];address+4*index
	push esi;index
	push dword OutputFormat
	call _printf; print
	add esp, 12;remove argument without ecx
	
	inc esi;index++
	pop ecx;restore before OutputFormat
	loop print_loop
	
	pop ebx
	pop esi;restore
	leave
	ret