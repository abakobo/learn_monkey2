#Import "<std>"
#Import "callback.h"

Extern 
 
	Function gime_callback:Void()
	Function my_callback()
	Function callcallback()
	Function register_callback(fptr:Void())

Public

Function printstuff()
	Print "mx2 stuff"
End

Function Main()

	Print "monkey2 extern function pointer test"
	Print ""
	Local fp:Void() 'the function pointer
	
	fp=printstuff 'assign an mx2 func
	fp() ' call the func
	Print "--------------------------"
	my_callback() 'directly call the extern func
	Print "--------------------------"
	fp=my_callback 'assign a the C func
	fp() 'call the C func with the mx2 func variable
	Print "----------------------------"
	callcallback() 'run a callback procedure on the C side
	Print "---------- now calling it on the mx2 side"
	register_callback(fp)
	Print "----------- now sending an mx2 func to C"
	fp=printstuff
	register_callback(fp)
	Print " "
	Print "All OK"
	
End