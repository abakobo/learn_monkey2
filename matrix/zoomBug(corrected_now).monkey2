
Namespace myapp

#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..

Class MyWindow Extends Window
	Field zoom:=1.0
	Field radius:=4.2
	Field x:=9.3
	Field y:=9.2
	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
		canvas.DrawText("Press space to zoom, Enter to grow circle, R to reset",10,10)
		canvas.Scale(zoom,zoom)  
		canvas.DrawCircle( x,y,radius )
		canvas.Color=Color.Black
		canvas.DrawLine(x,y,x+Cos(0.7)*radius,y+Sin(0.7)*radius)
		If Keyboard.KeyDown(Key.Space) Then zoom=zoom*1.1  
		If Keyboard.KeyDown(Key.Enter) Then radius=radius*1.1
		If Keyboard.KeyDown(Key.R)
			zoom=1.0
			radius=1.2
		Endif		
		Print zoom
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End
