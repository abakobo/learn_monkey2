Namespace std

#Import "<std>"
#Import "console_input_mx2.h"
#Import "console_input_mx2.cpp"

'Using std..

Extern
Function Console_Input_mx2:Void Ptr(Void Ptr)

Public

Function Input:String(s:String="")
	Local chars:= New Int[256]
	Local svptr:=Cast<Void Ptr>(chars.Data)
	s.ToCString(svptr,255)
	Local ivptr:=Console_Input_mx2(svptr)
	Return String.FromCString(ivptr)	
End
