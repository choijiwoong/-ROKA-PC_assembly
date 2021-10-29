#include <stdio.h>

//***********first***************
int first_count_bits(unsigned int data){
	int cnt=0;
	
	while(data!=0){//each case, must 1bit off. 
		data=data&(data-1);
		cnt++;
	}
	return cnt;
	
	/*
	no bit off is impossible by under mechanism
	data	=xxxxx10000
	data-1	=xxxxx01111
	*/
}

//*****************second****************
static unsigned char byte_bit_count[256];//lookup table

void intialize_count_bits(){//it must be called before count_bits function because it initializes byte_bit_count(lookup table) 
	int cnt, i, data;
	
	for(i=0; i<256; i++){
		cnt=0;//set to Zero each for loop!
		data=1;
		while(data!=0){//same to first count way
			data=data&(data-1);
			cnt++;
		}
		byte_bit_count[i]=cnt;
		//we can also find MSB by (data>>24)&0x000000FF but, this way is slow than using array
	}
}

int second_count_bits(unsigned int data){
	const unsigned char *byte=(unsigned char*)&data;
	
	return byte_bit_count[byte[0]]+byte_bit_count[byte[1]]+byte_bit_count[byte[2]]+byte_bit_count[byte[3]];//we can thread this process by for
	//for loop is unefficient, but compiler will change for like upper way a+b+,,, by loop unrolling that's compiler optimize technique
}

//****************third******************
int third_count_bits(unsigned int x){
	static unsigned int mask[]={ 0x55555555,
								 0x33333333,
								 0x0F0F0F0F,
								 0x00FF00FF,
								 0x0000FFFF};
	int i;
	int shift;
	
	for(i=0, shift=1; i<5; i++, shift*=2)
		x=(x&mask[i])+( (x>>shift)&mask[i] );//even part+ odd part. this process, sum of 2bit part is maximum 2, it doesn't make overflow
	//like partial sum effect by calculation per 1bit, 2bit, 4bit(shift).
	//if we don't use for, it's speed will be high, but by using for loop, we can see that process in each shift
	return x;
}
