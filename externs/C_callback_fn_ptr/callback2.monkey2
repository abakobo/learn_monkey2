#Import "<std>"
#Import "callback2.h"

Extern 
 
	Function gime_c_callback:void()()
	Function my_callback()
	Function callcallback()
	Function register_callback(fptr:Void())

Public

Function printstuff()
	Print "mx2 callback"
End

Function gime_mx2_callback:Void()()
	Return printstuff
End

Function Main()

	Print "monkey2 extern function pointer test"
	Print ""
	Local fp:Void() 'the function pointer/variable
	
	Print "------Simple mx2 func variable assignation"
	fp=printstuff 
	fp() 
	Print "------Calling the C callback without func pointer/variable"
	my_callback() 
	Print "------now assigning a C func to the mx2 func variable"
	fp=my_callback 
	fp() 
	Print "------run a callback procedure all on the C side (from the C tutorial http://opensourceforu.com/2012/02/function-pointers-and-callbacks-in-c-an-odyssey/)"
	callcallback() 
	Print "---------- now sending C func to C register_callback on the mx2 side"
	register_callback(fp)
	Print "----------- now sending an mx2 func to C register_callback"
	fp=printstuff
	register_callback(fp)
	Print "------------now getting a func variable with gime() mx2 side"
	fp=gime_mx2_callback()
	fp()
	Print "------------now getting a func variable with gime_c_callback() C side"
	fp=gime_c_callback()
	fp()
	Print " "
	Print "---"
	
End