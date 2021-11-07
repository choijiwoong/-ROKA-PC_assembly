COMMENT! C version of sum program
void calc_sum(int n, int *sum){
	int i, sum=0'
	
	for(i=1; i<=n; i++)
		sum+=i;
	*sump=sum;
}
!


;asm version
cal_sum:
	push ebp
	mov ebp, esp
	sub esp, 4;allocate size of local variable
	
	mov dword [ebp-4],0;sum=0
	mov ebx,1
for_loop:
	cmp ebx, [ebp+8]; n
	jnle end_for; not less equal, if not i<=n, jump to end_for
	
	add [ebp-4], ebx
	inc ebx
	jmp short for_loop
	
end_for:
	mov ebx, [ebp+12];sump
	mov eax, [ebp-4]
	mov [ebx], eax;*sump=sum
	
	mov esp, ebp;restore esp that's used for local variable
	pop ebp
	ret