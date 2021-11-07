#include <stdio.h>
#include <stdlib.h>

//제곱근을 정수로 저장할 땐 내림을 해야하는데, 제어워드를 변경하여 바꾸자. Rounding Control비트는 10번과 11번이다. 모두 0이면 반올림, 모두 1이면 내림이다. 복원은 필수다!
extern void find_primes(int *a, unsigned n);

int main(){
	int status;
	unsigned i, max;
	int *a;
	
	printf("How many primes do you wish to find? ");
	scanf("%u", &max);
	
	a=calloc(sizeof(int),max);
	
	if(a){
		find_primes(a,max);
		for(i=(max>20)?max-20:0; i<max; i++)
			printf("%3d %d\n",i+1, a[i]);
		free(a);
		status=0;
	} else{
		fprintf(stderr, "Can not create array of %u ints\n", max);
		status=1;
	}
	
	return status;
}