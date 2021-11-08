#include <iostream>
using namespace std;

class Big_int{
	public:
		class Size_mismatch{
			public:
				what(){
					cout<<"Size mismatch!"<<endl;
				}
		};
		class Overflow{
			public:
				what(){
					cout<<"Size mismatch!"<<endl;
				}
		};
		
		explicit Big_int(size_t size, unsigned initial_value=0);
		
		Big_int(size_t size, const char *initial_value);
		Big_int(const Big_int & big_int_to_copy);
		~Big_int();
		
		size_t size() const;
		const Big_int &operator=(const Big_int & big_int_to_copy);
		friend Big_int operator+(const Big_int&op1, const Big_int&op2);
		friend Big_int operator-(const Big_int&op1, const Big_int&op2);
		friend Big_int operator==(const Big_int&op1, const Big_int&op2);
		friend Big_int operator>(const Big_int&op1, const Big_int&op2);
		friend ostream& operator<<(ostream &os, const Big_int &op);
	private:
		size_t size_;
		unsigned *number_;
};

extern "C"{
	int add_big_ints(Big_int &res, const Big_int &op1, const Big_int &op2);
	int sub_big_ints(Big_int &res, const Big_int &op1, const Big_int &op2);
}
inline Big_int operator+(const Big_int &op1, const Big_int &op2){
	Big_int result(op1.size());
	int res=add_big_ints(result, op1, op2);
	if(res==1)
		throw Big_int::Overflow();
	if(res==2)
		throw Big_int::Size_mismatch();
	return result;
}

inline Big_int operator-(const Big_int &op1, const Big_int &op2){
	Big_int result(op1.size());
	int res=sub_big_ints(result, op1, op2);
	if(res==1)
		throw Big_int::Overflow();
	if(res==2)
		throw Big_int::Size_mismatch();
	return result;
}

int main(){
	try{
		Big_int b(5,"8000000000000a00b");
		Big_int a(5,"80000000000010230");
		Big_int c=a+b;
		cout<<a<<" + "<<b<<"="<<c<<endl;
		
		for(int i=0; i<2; i++){
			c=c+a;
			cout<<"c = "<<c<<endl;
		}
		
		cout<<"c-1="<<c-Big_int(5,1)<<endl;
		Big_int d(5,"12345678");
		cout<<"d="<<d<<endl;
		cout<<"c==d"<<(c==d)<<endl;
		cout<<"c>d"<<(c>d)<<endl;
	} catch(const char *str){
		cerr<<"Caught: "<<str<<endl;
	} catch(Big_int::Overflow){
		cerr<<"Overflow"<<endl;
	} catch(Big_int::Size_mismatch){
		cerr<<"Size mismatch"<<endl;
	}
	
	return 0;
}
