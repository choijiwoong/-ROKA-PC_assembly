;덧셈만 다룬다.
segment .text
	global add_big_ints, sub_big_ints
%define size_offset 0
%define number_offset 4

%define EXIT_OK 0
%define EXIT_OVERFLOW 1
%define EXIT_SIZE_MISMATCH 2

;arguments for subrootin of add, subtract
%define res ebp+8
%define op1 ebp+12
%define op2 ebp+16

add_big_ints:
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	
	;point setting
	mov esi, [op1]; points op1
	mov edi, [op2]; points op2
	mov ebx, [res]; points res
	
	;check size of arguments that's Big_int by size_t member variable by adding offset.
	mov eax, [esi+size_offset]
	cmp eax, [edi+size_offset]
	jne sizes_not_equal; if op1.size_ != op2.size_
	cmp eax, [ebx+size_offset]
	jne sizes_not_equal; if op1.size_ != res.size_
	
	mov ecx, eax; ecx=size of Big_int
	
	;point setting to each rray
	mov ebx, [ebx+number_offset]
	mov esi, [esi+number_offset]
	mov edi, [edi+number_offset]
	
	clc; initialization of carry flag
	xor edx, edx; edx=0
	
add_loop:;최하위 순으로 더하는 이유는 확장 정밀도 산술 연산. 즉 캐리를 같이 더하는 ADC를 이용하기 위해서이다.
	mov eax, [edi+4*edx]
	adc eax, [esi+4*edx]; add with carry
	mov [ebx+4*edx], eax
	inc edx; do not change carry flag
	loop add_loop;??
	
	jc overflow; if carry is exist after adding. 배열에 저장된 더블워드들이 리틀 엔디안 형식이기에 루프는 배열의 처음부터 배열의 끝에서 끝난다.
ok_done:
	xor eax, eax; result value is EXIT_OK
	jmp done
overflow:
	mov eax, EXIT_OVERFLOW
	jmp fone
sizes_not_equal:
	mov eax, EXIT_SIZE_MISMATCH
done:
	pop edi
	pop esi
	pop ebx
	leave
	ret