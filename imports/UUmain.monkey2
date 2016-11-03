Namespace myapp
 
#Import "<std>"
#Import "<mojo>"

 
Using std..
Using mojo..

Global Ultim:= New UltimClass

Class UltimClass
	Method Init:Int( )
		Return 0 
	end
End
 

 
Class MyWindow Extends Window

	
	Method New()
		Ultim.Init()
	end
 
	Method OnRender( canvas:Canvas ) Override
	
		canvas.DrawText( "Hello World",Width/2,Height/2,.5,.5 )
	
	End
	
End
 
Function Main()
 
	New AppInstance
	
	New MyWindow
	Print Ultim.Init()
	App.Run()
End