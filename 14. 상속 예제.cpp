#include <cstddef>
#include <iostream>
using namespace std;

//explicit definition of C calling convention by__cdecl makes this code use standard C calling convention
//because MS use different C calling convention with standard C calling convention.
//it pass this(pointer) by ECX unlike by stack.
class A{
	public:
		void __cdecl m(){ cout<<"A::m()"<<endl; }
		//virtual void __cdecl m(){ cout<"A::m()"<<endl; }//Let's use polymorphic inheritance!
		int ad;
};

class B: public A{
	public:
		void __cdecl m(){ cout<<"B::m()"<<endl; }
		//virtual void __cdecl m(){ cout<<"B::m()"<<endl; }
		int bd;
};

void f(A *p){
	p->ad=5;
	p->m();
}

int main(){
	A a;
	B b;
	
	cout<<"Size of a: "<<sizeof(a)<<" Offset of ad: "<<offsetof(A, ad)<<endl;
	cout<<"Size of b: "<<sizeof(b)<<" Offset of ad: "<<offsetof(B, ad)<<" Offset of bd: "<<offsetof(B, bd)<<endl;
	//Size of a: 4 Offset of ad: 0
	//Size of b: 8 Offset of ad: 0 Offset of bd: 4
	//Get same offset!
	
	f(&a);//A::m()
	f(&b);//A::m()
	//All called A::m()! it's difficult to code by assembly beacuse method of perfect object oriented programming is depending on what object will be passed to function!
	//It's called polymorphism.
	
	
	/*if we put virtual keyword, result of print is like that
	Size of a: 8 Offset of ad: 4
	Size of b: 12 Offset of ad: 4 Offset of bd: 8
	A::m()
	B::m()
	
	offset 0 is changed by structure of polymorphism.
	virtual class has fidden section that is called virtual table(vtable).
	pointer that points vtable is saved to offset ZERO.
	*/
	
	return 0;
}

/*
;common asm code f()
__f__FP1A:	;manglied name
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]; points object
	mov dword [eax], 5
	mov eax, [ebp+8]
	push eax
	call _m__1A; method m call is label!
	add esp, 4
	leave
	ret
	
;virtual asm code f()
?f@@YAXPAVA@@@Z:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8]
	mov dword [eax+4], 5; p->ad=5;
	
	mov ecx, [ebp+8]; ecx=p
	mov edx, [ecx]; find pointer of vtable to first offset of ojbect pointer, p
	mov eax, [ebp+8]; eax=p
	push eax; push p
	call dword [edx]; method m call is not label! call virtual method by branch to first address of vtable
	;call like these form is called late binding. (it can't decide that method will be execute until execution of code.)
	;normal form call like "common asm code f()" is called early binding.(we can know that method will be executed in compile time)
	
	add esp, 4; remove arguments
	
	pop ebp
	ret
*/