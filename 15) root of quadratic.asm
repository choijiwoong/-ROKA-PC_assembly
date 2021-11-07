%define a qword [ebp+8]
%define b qword [ebp+16]
%define c qword [ebp+24]
%define root1 dword [ebp+32]
%define root2 dword [ebp+36]
%define disc qword [ebp-8]
%define one_over_2a qword [ebp-16]

segment .data
MinusFour dw -4

segment .text
	global _quadratic
_quadratic:
	push ebp
	mov ebp, esp
	sub esp, 16; allocate two double
	push ebx; it will be used
	
	fild word [MinusFour];-4
	fld a;a,-4
	fld c;c,a,-4
	fmulp st1;a*c,-4
	fmulp st1;-4*a*c
	
	fld b;b,-4*a*c
	fld b;b,b,-4*a*c
	fmulp st1;b*b,-4*a*c
	faddp st1;b*b-4*a*c
	
	ftst;cmp st0, 0
	fstsw ax; stat->ax
	sahf;ax->flag
	jb no_real_solutions;disc<0
	
	fsqrt;sqrt(b*b-4*a*c)
	fstp disc;pop to disc
	
	fld1;1.0
	fld a;a, 1.0
	fscale;2*a,1.0
	fdivp st1;1/(2*a)
	fst one_over_2a
	
	fld b;b,1/(2*a)
	fld disc;disc,b,1/(2*a)
	fsubrp st1;disc-b,1/(2*a)
	fmulp st1;(-b+disc)/(2*a)
	
	mov ebx, root1
	fstp qword [ebx];save to *root1
	fld b;b
	dlf disc;disc, b
	fchs;-disc, b
	fsubrp st1;-disc-b
	fmul one_over_2a;(-b-disc)/(2*a)
	mov ebx, root2
	fstp qword [ebx]
	mov eax, 1
	jmp short quit

no_real_solutions:
	mov eax, 0;return value
	
quit:
	pop ebx
	mov esp, ebp
	pop ebp
	ret