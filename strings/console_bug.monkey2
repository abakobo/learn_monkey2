#Import "<std>"
Using std..
Function Main()
	Local s:String
	For Local j:=0 To 1
		s=""
		For Local i:=1+(j*127) To  127+(j*127)
			s=s+String.FromChar(i)
		Next
		Print s
	Next
	Print "éléphant"
End