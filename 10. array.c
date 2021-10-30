#include <stdio.h>

int asm_main(void);
void dump_line(void);

int main(){
	int ret_status;
	ret_status=asm_main();
	return ret_status;
}

/*
dump_line function
dump left char in input buffer
*/
void dump_line(){
	int ch;
	while((ch=getchar()) != EOF && ch!='\n')
			/*null body*/;
}