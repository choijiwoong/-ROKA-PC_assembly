;<합 프로그램의 C언어 버전>
;	void calc_sum(int n, int *sump){
;		int i, sum=0;
;		
;		for(i=1; i<=n; i++)
;			sum+=i;
;		*sump=sum;
;	}
	
;<합 프로그램의 어셈블리 버전>
cal_sum:
	push ebp;ebp for access local vairable
	mov ebp, esp;esp backup
	sub esp, 4;make space for local variable sum
	
	mov dword [ebp-4], 0;sum=0
	mov ebx, 1; i=1
for_loop:
	cmp ebx, [ebp+8]; j<=n?
	jnle end_for
	
	add [ebp-4], ebx;sum+=i
	inc ebx;i++ until jnle end_for
	jmp short for_loop
end_for:
	mov ebx, [ebx+12];ebx=sump
	mov eax, [ebp-4];eax=sum
	mov [ebx], eax;save sum to sump. ebx is pointer. so use [], eax is value. so use just eax
	
	mov esp, ebp;back to initial status of esp
	pop ebp;back to initial status of ebp
	ret

;stack frame of this program
;ESP+16	EBP+12	sump
;ESP+12	EBP+8	n
;ESP+8	EBP+4	return address
;ESP+4	EBP		saved EBP
;ESP	EBP-4	sum