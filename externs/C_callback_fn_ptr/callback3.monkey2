#Import "<std>"
#Import "callback3.h"

Extern 
 
	Function gime_c_callback:void(pointr:Int Ptr)()
	Function my_callback(pointr:int Ptr)
'	Function callcallback(Pitr:Int ptr)
	Function register_callback(ptr_reg_callback:Void(pointer:Int Ptr),pointer:Int ptr)

Public

Global integ:Int=0

Function printstuff(p:Int Ptr)
	Print "mx2 callback"
	p[0]=7
End

Function gime_mx2_callback:Void(p:Int ptr)()
	Return printstuff
End

Function Main()

	Print "monkey2 extern function pointer test"
	Print ""
	Local fp:Void(Int ptr) 'the function pointer/variable
	Local iptr:Int Ptr
	iptr=Varptr integ
	Print "------Simple mx2 func variable assignation"
	fp=printstuff 
	fp(iptr)
	Print iptr[0]
'	Print "------run a callback procedure all on the C side (from the C tutorial http://opensourceforu.com/2012/02/function-pointers-and-callbacks-in-c-an-odyssey/)"
'	callcallback() 
	Print "------Calling the C callback without func pointer/variable"
	my_callback(iptr) 
	Print iptr[0]
	Print "------now assigning a C func to the mx2 func variable"
	fp=my_callback 
	fp(iptr)
	Print iptr[0]

	Print "---------- now sending C func to C register_callback on the mx2 side"
	register_callback(fp,iptr)
	Print iptr[0]
	Print "----------- now sending an mx2 func to C register_callback"
	fp=printstuff
	register_callback(fp,iptr)
	Print iptr[0]
	Print "------------now getting a func variable with gime() mx2 side"
	fp=gime_mx2_callback()
	fp(iptr)
	Print iptr[0]
	Print "------------now getting a func variable with gime_c_callback() C side"
	fp=gime_c_callback()
	fp(iptr)
	Print iptr[0]
	Print " "
	Print "---"
	
End