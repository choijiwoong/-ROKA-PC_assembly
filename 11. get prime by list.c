#include <stdio.h>
#include <stdlib.h>
extern void ond_primes( int *a , unsigned n );

int main(){
int status ;
unsigned i;
unsigned max;
int * a ;

printf (”How many primes do you wish to önd? ” );
scanf(”%u”, &max);

a = calloc ( sizeof(int ), max);

if ( a ) {

ond_primes(a ,max);

/*찾은 마지막 20 개의 소수를 출력 */
for(i= ( max > 20 ) ? max − 20 : 0; i < max; i++ )
 printf (”%3d %d\n”, i+1, a[i ]);

 free (a );
 status = 0;
}
else {
 fprintf (stderr , ”Can not create array of %u ints \n” , max);
 status = 1;
}

return status ;
}
