segment .text
	global _calc_sum
	
;local variable: sum at [ebp-4]
_calc_sum:
	enter 4,0
	
	mov dword[ebp-4], 0
	mov ecx, 1
for_loop:
	cmp ecx, [ebp+8]
	jnle end_for; i>n exit
	
	add [ebp-4], ecx
	inc ecx
	jmp short for_loop

end_for:
	mov eax, [ebp-4];return value in eax
	
	leave
	ret