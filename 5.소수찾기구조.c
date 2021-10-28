#include <stdio.h>

int main(){
	unsigned guess;
	unsigned factor;//factor of guess
	unsigned limit;//find prime until this number
	
	printf("Find primes up to: ");
	scanf("%u", &limit);
	printf("2\n");
	printf("3\n");//special case as first two primes
	
	guess=5;//we will find odd only!
	while(guess<=limit){
		factor=3;//least factor of odd number
		while(factor*factor<guess && guess%factor!=0)//possible factor of odd guess, check all factor by step 2
			factor+=2;
		//if escape while, factor^2 is out of guess(prime!) or guess%factor==0(no prime!)
		if(guess%factor!=0)//if not divied, 
			printf("%d\n", guess);//it's prime!
		guess+=2;//find only odd number
	}
	
	return 0;
}
