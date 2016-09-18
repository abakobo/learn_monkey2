#Import "<std>"
#Import "factopass.h"
'#Import "facto.cpp"

Extern 
 
	Function Factorial_send_var:Int(M:Int)
	Function Factorial_send_ptr:Int(M:Int ptr)
	Function Factorial_send_ref:Int(M:Int)

Public


Function Main()

	Print "monkey2 extern test"
	Local i:=4
	Print Factorial_send_var(i) 'in c++: int Factorial_send_var(int M){..}
	i=5
	
	Local pitr:Int Ptr
	pitr=Varptr i
	Print Factorial_send_ptr(Varptr i) 'in c++: int Factorial_send_var(int*  M){..}
	
	i=6
	Print Factorial_send_ref(i) 'in c++: int Factorial_send_var(int& M){..}
	
	Print Factorial_send_ptr(pitr) 'pitr keeps pointing to i wich is now 6
	Print pitr[0]
	
End