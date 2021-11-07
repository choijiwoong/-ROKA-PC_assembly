segment .data
format db "%lf",0;fscanf()

segment .text
	global _read_doubles
	extern _fscanf

%define SIZEOF_DOUBLE 8
%define FP dword [ebp+8];FILE*
%define ARRAYP dword [ebp+12];double*
%define ARRAY_SIZE dword [ebp+16];int
%define TEMP_DOUBLE [ebp-8]

_read_doubles:
	push ebp
	mov ebp, esp
	sub esp, SIZEOF_DOUBLE
	
	push esi
	mov esi, ARRAYP
	xor edx, edx

while_loop:
	cmp edx, ARRAY_SIZE
	jnl short quit;if edx>=ARRAY_SIZE, quit
	
	push edx;restore
	lea eax, TEMP_DOUBLE
	push eax
	push dword format
	push FP
	call _fscanf
	add esp,12
	pop edx;
	cmp eax,1
	jne short quit;if uncommon return, quit
	
	mov eax, [ebp-8];double is 8byte
	mov [esi+8*dex], eax;LSB
	mov eax, [ebp-4]
	mov [esi+8*dex+4], eax;MSB
	
	inc edx
	jmp while_loop
	
quit:
	pop esi
	
	mov eax, edx
	mov esp, ebp
	pop ebp
	ret