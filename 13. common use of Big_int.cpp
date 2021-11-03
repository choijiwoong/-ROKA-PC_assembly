#include "13. Big_int.hpp"
#include <iostream>
using namespace std;

int main(){
	try{
		Big_int b(5, "8000000000000a00b");//it must be defined explicitly 1. 일반 정수를 big int로 변환하는 변환 생성자가 없고, 오직 같은 크기의 Big_int만이 더하기가 가능하기 떄문이다.
		Big_int a(5, "80000000000010230");
		Big_int c=a+b;
		cout<<a<<" + "<<b<<" = "<<c<<endl;
		
		for(int i=0; i<2; i++){
			c=c+a;
			cout<<"c = "<<c<<endl;
		}
		
		cout <<"c-1 = "<<c-Big_int(5,1)<<endl;
		
		Big_int d(5,"12345678");
		cout<<"d = "<<d<<endl;
		cout<<"c == d"<<(c==d)<<endl;
		cout<<"c > d"<<(c>d)<<endl;
	} catch(const char *str){
		cerr<<"Caught: "<<str<<endl;
	} catch(Big_int::Overflow){
		cerr<<"Overflow"<<endl;
	} catch(Big_int::Size_mismatch){
		cerr<<"Size mismatch"<<endl;
	}
	
	return 0;
	//완벽한 구현은 숙제..
}