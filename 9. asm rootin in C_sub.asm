;_calc_sum
;sum 1 to n
;arguments:
;	n	[ebp+8]에 위치하며 어디까지 합할지
;	sump	[ebp+12]에 위치하며 sum을 저장할 공간의 int포인터

;pseudo C
;void calc_sum(int n, int *sump){
;	int i, sum=0;
;	for(i=1; i<=n; i++)
;		sum+=i;
;	*sump=sum;
;	}

segment .text
	global _calc_sum
_calc_sum:
	enter 4,0;make stack space for sum
	push ebx;important! because C's calling convetions don't allow EBX's change
	
	mov dword [ebp-4],0;sum=0
	dump_stack 1,2,4;print stack ebp-8 to ebp+16. (정수라벨, EBP의 범위)
	mov ecx, 1;i
for_loop:
	cmp ecx, [ebp+8];cmp i&n
	jnle end_for;if i<=n이 아니면 종료
	
	add [ebp-4], ecx;
	inc ecx
	jmp short for_loop

end_for:
	mov ebx, [ebp+12]
	mov eax, [ebp-4]
	mov [ebx], eax
	
	pop ebx;restore ebx
	leave
	ret
;we can modify this code by return sum value by not using pointer