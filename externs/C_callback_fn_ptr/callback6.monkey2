#Import "<std>"
#Import "callback6.h"
#Import "callback6.cpp"

Extern 
 
	Function gime_c_callback:void(popourVoidr:void ptr)()
	Function my_callback(popourVoidr:void ptr)
'	Function callcallback(Pitr:void ptr)
	Function register_callback(ptr_reg_callback:Void(poter:void ptr),ponter:void ptr)

Public

Struct pourVoid
 Field i:int=15
 Field s:String="custostructo"
 Field d:double=12.21
End

Global pourVoideg:pourVoid

Function Printstuff(p:void ptr)
	Print "mx2 callback"
	Local ipopourVoid:pourVoid Ptr
	ipopourVoid=Cast<pourVoid Ptr>(p)
	ipopourVoid[0].i=7
End

Function gime_mx2_callback:Void(p:void ptr)()
	Return Printstuff

End

Function Main()
	
	Print pourVoideg.i

	Print "monkey2 extern function ponter test"
	Print ""
	Local struct_ptr:pourVoid Ptr
	struct_ptr=Varptr pourVoideg
	Print struct_ptr[0].i
	
	Local fp:Void(void ptr) 'the function ponter/variable
	Local vptr:void Ptr
	vptr=Cast<Void ptr>(Varptr pourVoideg)
	
	
	Print "------Simple mx2 func variable assignation"
	fp=Printstuff 
	fp(vptr)
	struct_ptr=Cast<pourVoid Ptr>(vptr)
	Print struct_ptr[0].i
	
	Print "------Calling the C callback without func ponter/variable"
	my_callback(vptr) 
	Print struct_ptr[0].i
	Print "------now assigning a C func to the mx2 func variable"
	fp=my_callback 
	fp(vptr)
	Print struct_ptr[0].i

	Print "---------- now sending C func to C register_callback on the mx2 side"
	register_callback(fp,vptr)
	Print struct_ptr[0].i
	Print "----------- now sending an mx2 func to C register_callback"
	fp=Printstuff
	register_callback(fp,vptr)
	Print struct_ptr[0].i
	Print "------------now getting a func variable with gime() mx2 side"
	fp=gime_mx2_callback()
	fp(vptr)
	Print struct_ptr[0].i
	Print "------------now getting a func variable with gime_c_callback() C side"
	fp=gime_c_callback()
	fp(vptr)
	Print struct_ptr[0].i
	Print " "
	Print "---"
	
End