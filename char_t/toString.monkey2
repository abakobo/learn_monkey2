
Namespace myapp

#Import "<std>"

Using std..

Function Main()
	Local st:="USERNAME"
	Local USERNAME:= libc.getenv(st)
	Local s:=String.FromCString(USERNAME)
	Print s
	
End