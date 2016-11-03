
Namespace myapp

#Import "<std>"

Using std..

Class foo
	Method Init:Int()
		Return 15
	End
End

Function Main()
	Local fooc:=New foo
	Local i:=fooc.Init()
	Print i
End