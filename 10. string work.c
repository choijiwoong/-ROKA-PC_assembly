#include <stdio.h>

#define STR_SIZE 30//prototypes

void asm_copy(void*, const void*, unsigned) __attribute__((cdecl));
void* asm_find(const void*, char target, unsigned) __attribute__((cdecl));
unsigned asm_strlen(const char*) __attribute__((cdecl));
void asm_strcpy(char*, const char*) __attribute__((cdecl));

int main(){
	char st1[STR_SIZE]="test string";
	char st2[STR_SIZE];
	char *st;
	char ch;
	
	asm_copy(st2, st1, STR_SIZE);//copy
	printf("%d\n",st2);
	
	printf("Enter a char: ");//find byte
	scanf("%c%*[\n]", &ch);//???
	st=asm_find(st2, ch, STR_SIZE);
	if(st)
		printf("Found it: %s\n", st);
	else
		printf("Not found\n");
		
	st1[0]=0;
	printf("Enter string: ");
	scanf("%s",st1);
	printf("len=%u\n", asm_strlen(st1));
	
	asm_strcpy(st2, st1);//copy meaningful data
	printf("%s\n", st2);

	return 0;
}
