#include <stdio.h>

/*
32��Ʈ read_doubles() ����� ���ν����� �׽�Ʈ�ϸ�, stdin���� double�� �о���δ�
(������ �б����� �����̷���(redirection)�� ����Ѵ�)
*/
extern int read_doubles(FILE*, double*, int);
#define MAX 100

int main(){
	int i, n;
	double a[MAX];
	
	n=read_doubles(stdin, a, MAX);//file pointer, storage, size
	
	for(i=0; i<n; i++)
		printf("%3d %g\n", i, a[i]);//%g�� ���� �ʰ��� ������������ ���� 
		
	return 0;
}
