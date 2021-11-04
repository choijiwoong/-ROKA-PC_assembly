#include <iostream>
using namespace std;

class A{
	public:
		virtual void __cdecl m1(){ cout<<"A::m1()"<<endl; }
		virtual void __cdecl m2(){ cout<<"A::m2()"<<endl; }
		int ad;
};

class B: public A{
	public:
		virtual void __cdecl m1(){ cout<<"B::m1()"<<endl; }
		int bd;
};

void print_vtable(A *pa){
	unsigned *p=reinterpret_cast<unsigned *>(pa);//make pointer regardress of type
	void **vt=reinterpret_cast<void**>(p[0]);//get vtable pointer. (vtable pointer's pointer)
	
	cout<<hex<<"vtable address = "<<vt<<endl;
	for(int i=0; i<2; i++)
		cout<<"dword "<<i<<": "<<vt[i]<<endl;
	
	void (*m1func_pointer)(A*);
	m1func_pointer=reinterpret_cast<void(*)(A*)>(vt[0]);//check if virtual function can be called by read address of vtable of object
	m1func_pointer(pa);
	
	void (*m2func_pointer)(A*);
	m2func_pointer=reinterpret_cast<void(*)(A*)>(vt[1]);//but this way is not good. just only studing of virtual method how can use vtable.
	m2func_pointer(pa);
}

int main(){
	A a;	B b1;	B b2;
	cout<<"a: "<<endl; print_vtable(&a);
	cout<<"b1: "<<endl; print_vtable(&b1);
	cout<<"b2: "<<endl; print_vtable(&b2);
	
	/*
	a:
	vtable address = 0x4904f0
	dword 0: 0x4222b0
	dword 1: 0x4222f0
	A::m1()
	A::m2()
	b1:
	vtable address = 0x490510
	dword 0: 0x422370
	dword 1: 0x4222f0
	B::m1()
	A::m2()
	b2:
	vtable address = 0x490510
	dword 0: 0x422370
	dword 1: 0x4222f0
	B::m1()
	A::m2()
	*/
	
	return 0;
}

/*
virtual table's address of b1&b2 is same vtable. it's charactor of class like static data member not object.
we have to be careful when we read or write class variable to binary file because we can't read or write whole object because it use vtable pointer.
this problem can be occured in C structure too when we assign pointer to struct
 Compilers concrete virtual method by different way.
The code for virtual method is same to non-virtual method. if compiler know what virtual method will be called, it can call method directly without vtable.
(p.s)
COM(component Object Model) in window uses vatble for creating of COM interface.
Borland & microsoft can create COM class unlike gcc.
*/
