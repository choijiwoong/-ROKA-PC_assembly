#include <stdio.h>

//first way. calculate cnt++ by and
int count_bits_1(unsigned int data){
	int cnt=0;
	//data 1001 0110
	//-1   1001 0101
	//and  1001 0100
	//cnt=1
	
	//-1   1001 0010
	//and  1001 0000
	//cnt=2
	
	//-1   1000 1000
	//and  1000 0000
	//cnt=3
	
	//-1   0100 0000
	//and  0000 0000
	//cnt=4
	
	while(data!=0){
		data=data&(data-1);
		cnt++;
	}
	
	return cnt;
}


//second way. lookup table
static unsigned char byte_bit_count[256];//loopup table. already calculated!

void initialize_count_bits(){
	int cnt, i, data;
	
	for(i=0; i<256; i++){
		cnt=0
		data=i;
		while(data!=0){
			data=data&(data-1);
			cnt++;
		}
		byte_bit_count[i]=cnt;//save count of bit per data to byte_bit_count
	}
}

int count_bits_2(unsigned int data){//4byte int data
	const unsigned char *byte=(unsigned char*)&data;//pointer to 1 byte char
	
	return byte_bit_count[byte[0]]+byte_bit_count[byte[1]]+byte_bit_count[byte[2]]+byte_bit_count[byte[3]];//loop unrolling
}


//third way. partial sum by bit calculation
int count_bits_3(unsigned int x){
	//data			1011 0011
	//shift1		0101 1001
	//data&mask[0]	0001 0001 even part
	//shift2&mask[0]0101 0001 odd part
	//+				0110 0010
	
	//data			0110 0010
	//shift2		0001 1000
	//data*mask[1]	0010 0010
	//shift2*mask[1]0001 0000
	//+				0011 0010
	
	//data			0011 0010
	//shift4		0000 0011
	//data*mask[2]	0000 0010
	//shift4*mask[2]0000 0011
	//+				0000 0101
	
	//data=5(10)
	static unsigned int mask[]={0x55555555, 0x33333333, 0x0F0F0F0F, 0x00FF00FF, 0x0000FFFF};//01010101, 00110011, 00001111, ...
	int i, shift;
	for(i=0, shift=1; i<5; i++; shift*=2)
		x=(x&mask[i])+((x>>shift)&mask[i]);
	return x;
}