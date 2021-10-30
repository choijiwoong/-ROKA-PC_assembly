#include <stdio.h>

void f(int x){
	int i;
	for(i=0; i<x; i++){
		printf("%d\n",i);
		f(i);
	}
}

int main(){
	f(1);//0
	printf("\n");
	f(2);//010
	printf("\n");
	f(3);//0102010
	
	return 0;
}
