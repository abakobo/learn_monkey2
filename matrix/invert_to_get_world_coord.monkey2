#Import "<std>"
#Import "<mojo>"
Using std..
Using mojo..
 
Global gMyWindow:MyWindow


 
Class MyWindow Extends Window
	Field pan : Vec2f
	Field zoom:Float = 1.0
	
	Method New()
		Super.New("", 800, 600)
		Stuff.Create()
		pan=New Vec2f (Width/2,Height/2) 'now set as center to begin
	End
	
	Method OnRender(canvas:Canvas) Override
		App.RequestRender()
		
		If Keyboard.KeyDown(Key.Raw|Key.R)
			zoom = 1.0
			pan = New Vec2f (Width/2,Height/2)
		End
		
		If Keyboard.KeyDown(Key.Raw|Key.Q)
			zoom -= 0.01
		End
		
		If Keyboard.KeyDown(Key.Raw|Key.E)
			zoom += 0.01
		End
		
		If Keyboard.KeyDown(Key.Raw|Key.A) Then pan.X -= 1*zoom 'it's nice to use Key.Raw for non qwerty keyboards..
		If Keyboard.KeyDown(Key.Raw|Key.D) Then pan.X += 1*zoom 
		If Keyboard.KeyDown(Key.Raw|Key.W) Then pan.Y += 1*zoom
		If Keyboard.KeyDown(Key.Raw|Key.S) Then pan.Y -= 1*zoom
		
		
		canvas.SetCameraByCenter(pan,zoom) 'no need to push and pop matrix if it's the only tranform of the OnRender() Call
		Stuff.Draw(canvas)
		
		If Mouse.ButtonPressed(MouseButton.Left)

			Local mouseWorldCoord:=-canvas.Matrix*Mouse.Location '- inverts the matrix (to reverse the transformation)
																'* applies the transformation to the vector (multiplies the vector by the matrix)
			Stuff.Hit(mouseWorldCoord)
			
		End

	End
End
 
Class Stuff Abstract
	Global Items:Vec2f[]
	Global Hits:Bool[]
	Function Create()
		Items = New Vec2f[100]
		Hits = New Bool[100]
		For Local i := 0 Until Items.Length
			Items[i] = New Vec2f(i * 20, Rnd(-100, 100))
			Hits[i] = False
		Next
	End
	
	Function Hit(p:Vec2f)
		For Local i := 0 Until Items.Length
			Local x := Items[i].X
			Local y := Items[i].Y
			If Contains(x - 5, x + 5, y - 5, y + 5, p.x, p.y)
				Hits[i] = True
				Print("Hit Success: " + i)
				Exit
			End
		Next
	End
	
	Function Contains:Bool(minx:Float, maxx:Float, miny:Float, maxy:Float, x:Float, y:Float)
		Return x>=minx And x<maxx And y>=miny And y<maxy
	End
	
	Function Draw(canvas:Canvas)
		For Local i := 0 Until Items.Length
			If Not Hits[i]
				canvas.Color = Color.White
			Else
				canvas.Color = Color.Red
			End
			
			canvas.DrawRect(Items[i].X - 5, Items[i].Y - 5, 10, 10)
		Next
	End
End

Class Canvas Extension

	Method SetCameraByCenter(point_x:Float,point_y:Float,zoom:Float=1.0,rotation:Float=0.0)

		Translate(Viewport.Width/2,Viewport.Height/2) 'Modify this line to change to something else than center
		Scale(zoom,zoom)
		Rotate(rotation)
		Translate(-point_x,-point_y)

	End
	
	Method SetCameraByCenter(point:Vec2f,zoom:Float=1.0,rotation:Float=0)

		Translate(Viewport.Width/2,Viewport.Height/2) 'Modify this line to change to something else than center
		Scale(zoom,zoom)
		Rotate(rotation)
		Translate(-point)

	End
	
End
 
Function Main()
	New AppInstance
	gMyWindow = New MyWindow
	App.Run()
End