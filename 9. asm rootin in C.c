#include <stdio.h>

void cal_sum(int, int*) __attrib__((cdecl));

int main(){
	int n, sum;
	
	printf("Sum integers up to: ");
	scanf("%d", &n);
	calc_sum(n, &sum);
	printf("Sum is %d\n", sum);
	
	return 0;
}