%define y_offset 4
_zero_y:
	enter 0,0
	mov eax, [enp+8]; get s_p(struct pointer) to stack
	mov dword [eax+y_offset], 0
	leave
	ret