#Import "<std>"

Using std..

Function Main()
	Local s:String
	For Local i:=0 To 255
		s=s.FromChar(i)
		Print s[0]+" "+s
	Next
End 