segment .text
	global _calc_sum
	
_calc_sum:
	enter 4,0
	push ebx;
	
	mov dword [ebp-4],0;local variable sum
	dump_stack 1,2,4;print stack (구분용, EBP-DW*2 ~ EBP+DW*4)
	mov ecx, 1;i
for_loop:
	cmp ecx, [ebp+8]
	jnle end_for;if not i<=n, end_for
	
	add [ebp-4], ecx
	inc ecx
	jmp short for_loop

end_for:
	mov ebx, [ebp+12];sump
	mov eax, [ebp-4]
	mov [ebx], eax
	
	pop ebx;restore
	leave
	ret