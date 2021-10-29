#include <stdio.h>

int main(){
	unsigned short word=0x1234;	//sizeof(short)==2¶ó »ý°¢
	unsigned char *p=(unsigned char *)&word;
	if(p[0]==0x12)
		printf("Big Endian Machine!\n");
	else
		printf("Little Endian Machine!\n");
		
	return 0;
}
