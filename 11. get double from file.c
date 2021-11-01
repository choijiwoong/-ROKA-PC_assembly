#include <stdio.h>

/*
32비트 read_doubles() 어셈블리 프로시저를 테스트하며, stdin으로 double을 읽어들인다
(파일을 읽기위해 리다이렉션(redirection)을 사용한다)
*/
extern int read_doubles(FILE*, double*, int);
#define MAX 100

int main(){
	int i, n;
	double a[MAX];
	
	n=read_doubles(stdin, a, MAX);//file pointer, storage, size
	
	for(i=0; i<n; i++)
		printf("%3d %g\n", i, a[i]);//%g는 범위 초과시 지수형식으로 나옴 
		
	return 0;
}
