#include <stdio.h>

void calc_sum(int, int*) __attribute__((cdecl));

int main(){
	int n, sum;
	
	printf("Sum integers up to: ");
	scanf("%d", &n);
	calc_sum(n, &sum);
	//sum=calc_sum(n); //get_sum(return version)
	
	printf("Sum: %d\n", sum);
	
	return 0;
}