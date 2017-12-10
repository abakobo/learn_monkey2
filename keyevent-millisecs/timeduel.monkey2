
Namespace myapp

#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..

Class MyWindow Extends Window
	
	Field spaceTime:=0
	Field backspaceTime:=0

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
	End
	
	Method OnKeyEvent( event:KeyEvent ) Override
		If event.Type=EventType.KeyDown 
			If event.Key=Key.Space
				spaceTime=Millisecs()
			Elseif event.Key=Key.Backspace
				backspaceTime=Millisecs()
			Endif
		endif
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
	
		canvas.DrawText( "space time: "+spaceTime+"   -   backspace time: "+backspaceTime,100,Height/2 )
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End
