segment .text
	global _calc_sum
	
_calc_sum:
	enter 4,0
	
	mov dword [ebp-4],0
	mov ecx, 1
for_loop:
	cmp ecx, [ebp+8]
	jnle end_for
	
	add [ebp-4], ecx
	inc ecx
	jmp short for_loop
	
end_for:
	mov eax, [ebp-4]
	
	leave
	ret