#Import "<std>"
#Import "callback4.h"

Extern 
 
	Function gime_c_callback:void(pointr:void ptr)()
	Function my_callback(pointr:void ptr)
'	Function callcallback(Pitr:void ptr)
	Function register_callback(ptr_reg_callback:Void(pointer:void ptr),pointer:void ptr)

Public



Global integ:Int=2

Function printstuff(p:void ptr)
	Print "mx2 callback"
	Local ipoint:Int Ptr
	ipoint=Cast<Int Ptr>(p)
	ipoint[0]=7
End

Function gime_mx2_callback:Void(p:void ptr)()
	Return printstuff

End

Function Main()

	Print "monkey2 extern function pointer test"
	Print ""
	Local iptr:Int Ptr
	iptr=Varptr integ
	Print iptr[0]
	
	Local fp:Void(void ptr) 'the function pointer/variable
	Local vptr:void Ptr
	vptr=Cast<Void ptr>(Varptr integ)
	
	
	Print "------Simple mx2 func variable assignation"
	fp=printstuff 
	fp(vptr)
	iptr=Cast<Int Ptr>(vptr)
	Print iptr[0]
	
	'Print vptr[0]
'	Print "------run a callback procedure all on the C side (from the C tutorial http://opensourceforu.com/2012/02/function-pointers-and-callbacks-in-c-an-odyssey/)"
'	callcallback() 
	Print "------Calling the C callback without func pointer/variable"
	my_callback(vptr) 
	Print iptr[0]
	Print "------now assigning a C func to the mx2 func variable"
	fp=my_callback 
	fp(vptr)
	Print iptr[0]

	Print "---------- now sending C func to C register_callback on the mx2 side"
	register_callback(fp,vptr)
	Print iptr[0]
	Print "----------- now sending an mx2 func to C register_callback"
	fp=printstuff
	register_callback(fp,vptr)
	Print iptr[0]
	Print "------------now getting a func variable with gime() mx2 side"
	fp=gime_mx2_callback()
	fp(vptr)
	Print iptr[0]
	Print "------------now getting a func variable with gime_c_callback() C side"
	fp=gime_c_callback()
	fp(vptr)
	Print iptr[0]
	Print " "
	Print "---"
	
End