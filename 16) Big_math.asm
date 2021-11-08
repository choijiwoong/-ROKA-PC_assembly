segment .text
	global add_big_ints, sub_big_ints

%define size_offset 0
%define number_offset 4

%define EXIT_OK 0
%define EXIT_OVERFLOW 1
%define EXIT_SIZE_MISMATCH 2

;arguments
%define res ebp+8
%define op1 ebp+12
%define op2 ebp+16

add_big_ints:
	push ebp
	mov ebp, esp
	push ebx;points res
	push esi;points op1
	push edi;points op2
	
	mov ebx,[res]
	mov esi,[op1]
	mov edi,[op2]
	
	;check size
	mov eax,[esi+size_offset]
	cmp eax,[edi+size_offset]
	jne sizes_not_equal; op1.size_!=op2.size_
	cmp eax,[ebx+size_offset]
	jne sized_not_equal; op1.size_!=res.size_
	
	mov ecx, eax; sizeof(Big_int)
	;for points each array
	mov ebx,[ebx+number_offset]
	mov esi,[esi+number_offset]
	mov edi,[edi+number_offset]
	
	clc;initialization of carry flag for adc
	xor edx, edx;i=0
add_loop:
	mov eax, [edi+4*edx];op2
	adc eax, [esi+4*edx];op1
	mov [ebx+4*edx], eax;mov res sum_of_elements
	inc edx
	loop add_loop; ecx has sizeof(Big_int). ecx--
	
	jc overflow
ok_done:
	xor eax, eax; return 0
	jmp done
overflow:
	mov eax, EXIT_OVERFLOW; return 1
	jmp done
sizes_not_equal:
	mov eax, EXIT_SIZE_MISMATCH; return 2
done:
	pop edi
	pop esi
	pop ebx
	leave
	ret