segment .data
format db "%lf",0;format for fscanf()

segment .text
	global _read_doubles
	extern _fscanf
	
%define SIZEOF_DOUBLE 8
%define FP dword [ebp+8]
%define ARRAYP dword [ebp+12]
%define ARRAY_SIZE dword [ebp+16]
%define TEMP_DOUBLE [ebp-8]

;_read_doubles function->save double data in txt file to array until EOF or full of array
;Origin C: int read_doubles(FILE *fp, double *arrayp, int array_size);
;Arguments:
;	fp- FILE pointer that can read
;	arrayp- array pointer that will be saved read value
;	array_size- count of elements in array
;Return:
;	num of double in array(EAX)

_read_doubles:
	push ebp;backup ebp
	mov ebp, esp;backup esp to ebp
	sub esp, SIZEOF_DOUBLE; define one double in stack
	
	push esi; backup esi
	mov esi, ARRAYP; save esi array pointer
	xor edx, edx; edx=location of element in array (set ZERO initially)
	
while_loop:
	cmp edx, ARRAY_SIZE; edx<ARRAY_SIZE?
	jnl short quit

;call fscanf for read value by TEMP_DOUBLE
;fscanf can change edx

	push edx; backup
	lea eax, TEMP_DOUBLE
	push eax;&TEMP_DOUBLE for argument of fscanf. storage for saving read value
	push dword format;&format
	push FP; file pointer
	call _fscanf
	add esp, 12; remove arguments
	pop edx; restore
	cmp eax, 1; does fscanf return 1? success called fscanf
	jne short quit; if not

;assign TEMP_DOUBLE to ARRAY[edx] (double (8bytes) will be assigned to two 4bytes register)

	mov eax, [ebp-8];temp double(read value) to eax
	;save data to storage
	mov [esi+8*edx], eax; copy low 4 bytes
	mov eax, [ebp-4]
	mov [esi+8*edx+4], eax;copy high 4 bytes
	
	inc edx; i++
	jmp while_loop
	
quit:
	pop esi; restore
	
	mov eax, edx; save return value (index. size)
	
	mov esp, ebp; restore
	pop ebp; restore
	ret