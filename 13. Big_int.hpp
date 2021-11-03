//origin of assembly rootin
extern "C"{
	int add_big_ints(Big_int &res, const Big_int &op1, const Big_int &op2);
	int sub_big_ints(Big_int &res, const Big_int &op1, const Big_int &op2);
}
//어셈블리의 사용 이유는 다중 정밀도 연산을 사용하기 위해 캐리가 하나의 더블워드로 부터 다음 더블워드로 전달되어야 하기 때문인데, C++&C는 CPU의 캐리 플래그 접근을 막고있기 때문이다.
//이를 C++리 독립적으로 하려면 캐르플래그를 다시 계산하고 다음에 더하는 건데, 어셈블리에서는 캐리 플래그의 접근이 쉬운걸 넘어서 ADC명령을 이용해 자동적으로 캐리 플래그를 더할 수 있어 효과적이기 때문이다.

inline Big_int operator+(const Big_int &op1, const Big_int &op2){
	Big_int result(op1.size());
	int res=add_big_ints(result, op1, op2);
	if(res==1)
		throw Big_int::Overflow();
	if (res==2)
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