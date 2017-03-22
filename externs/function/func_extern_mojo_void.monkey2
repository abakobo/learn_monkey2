#Import "<std>"
#Import "<mojo>"

#Import "voidtest.h"
#Import "voidtest.cpp"

Using std..
Using mojo..

Extern 
 
	Function Factorial:Int(M:Int)

Public

Class MyWindow Extends Window

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
	
		canvas.DrawText( "Hello World!",Width/2,Height/2,.5,.5 )
	End
	
End

Function Main()

	Print "monkey2 extern test"
	
	Print Factorial(4)	

End