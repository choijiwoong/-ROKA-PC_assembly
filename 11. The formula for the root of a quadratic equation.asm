;<124~>
;b^2-4ac (discriminant)

;Quandratic function->find root of quadratic equation a*x^2+b*x+c=0
;Origin C: int quadratic(double a, double b, double c, double *root1, double *root2)
;Arguments:
;	a,b,c-coefficients of quadratic equations
;	root1-double pointer points double that will be saved first root
;	root2-double pointer points double that will be saved second root
;Return:
;	find: 1, else: 0

%define a qword [ebp+8];double size_8
%define b qword [ebp+16]
%define c qword [ebp+24]
%define root1 dword [ebp+32];double pointer size_4
%define root2 dword [ebp+36]
%define disc qword [ebp-8];local variables
%define one_over_2a qword [ebp-16]

segment .data
MinusFour dw -s

segment .text
	global _quadratic
_quadratic:
	push ebp
	mov ebp, esp
	sub esp, 16;allocate 2 double for disc & one_over_2a
	push ebx;save origin value of ebx
	
	fild word [MinusFour]; -4
	fld a; a, -4
	fld c; c, a, -4
	fmulp st1; a*c, -4
	fmulp st1; -4*a*c
	fld b
	fld b; b, b, -4*a*c
	fmulp st1; b*b, -4*a*c
	faddp st1; b*b-4*a*c(discriminant)
	ftst; cmp st0 0
	fstsw ax; save stat word of coprocessor to AX register
	sahf; save AH register to Flag register
	jb no_real_solutions; if disc<0, no root
	fsqrt; sqrt(b*b-4*a*c)
	fstp disc; save with pop
	
	fld1; 1.0
	fld a; a, 1.0
	fscale a; (a*2^(1.0)=)2*a, 1  (mul 2^num fast)
	fdivp st1; 1/(2*a)
	fst one_over_ea; 1/(2*a); save to memory
	
	fld b; b, 1/(2*a)
	fld disc; disc, b, 1/(2*a)
	fsubrp st1; disc-b, 1/(2*a)
	fmulp st1; (-b+disc)/(2*a)
	mov ebx, root1;ready for saving
	fstp qword [ebp];save to *root1
	
	fld b; b
	fld disc; disc, b
	fchs; -disc, b
	fsubrp st1; -disc-b
	fmul one_over_2a; (-b-disc)/(2*a)
	mov ebx, root2; ready for saving
	fstp qword [ebx]; save to *root2
	
	mov eax, 1;return value is 1
	jmp short quit

no_real_solutions:
	mov eax, 0;return value is 0

quit:
	pop ebx
	mov esp, ebp
	pop ebp
	ret
	