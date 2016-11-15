#Import "<std>"
#Import "facto_c.h"
Extern 

	Struct c_int="const int"
	End
	
	Function Factorial:c_int Ptr (M:int)
	
Public

Function Main()
	Local ci:c_int ptr
	Local ip:Int Ptr
	
	ci=Factorial(4) 'should be 24..
	ip = Cast<int Ptr>(ci)
	Print ip[0]
End