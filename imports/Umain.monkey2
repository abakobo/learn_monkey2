Namespace myapp
 
#Import "<std>"
#Import "<mojo>"
#import "Ultim"
 
Using std..
Using mojo..
Using Ultim..
 
Class MyWindow Extends Window

	Field s:String
	
	Method New()
		s=UltimC.Init()
	end
 
	Method OnRender( canvas:Canvas ) Override
	
		canvas.DrawText( "Hello World "+s,Width/2,Height/2,.5,.5 )
	
	End
	
End
 
Function Main()
 
	New AppInstance
	
	New MyWindow
	App.Run()
End