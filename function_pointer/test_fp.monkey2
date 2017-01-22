
Namespace myapp

#Import "<std>"

Using std..

Global fp:Void(i:int)

Function funk(i:Int)
	Print "test"+i
End
Function Main()

	funk(12)
	'fp=Varptr funk()
	fp=funk
	fp(15)
	
End