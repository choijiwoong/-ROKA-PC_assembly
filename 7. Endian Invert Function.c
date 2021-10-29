#include <stdio.h>

unsigned invert_endian(unsigned x){
	unsigned invert;
	const unsigned char *xp=(const unsigned char*)&x;//const pointer to x
	unsigned char *ip=(unsigned char*)&invert;//pointer to invert
	
	ip[0]=xp[3];
	ip[1]=xp[2];
	ip[2]=xp[1];
	ip[3]=xp[0];
	
	return invert;
}
