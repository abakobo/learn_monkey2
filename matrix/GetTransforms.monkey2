
Namespace myapp

#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..

Struct AffineMat3<T> Extension

	Method GetScale:Vec2f()
	
		Local sxsq:=Pow(Self.i.x,2)+Pow(Self.i.y,2)
		Local sysq:=Pow(Self.j.x,2)+Pow(Self.j.y,2)
		
		If sxsq=sysq 'to gain calculation time because I generaly use 1:1 scales
			Local sc:=Sqrt(sxsq)
			Return New Vec2f (sc,sc)
		Else
			Return New Vec2f (Sqrt(sxsq),Sqrt(sysq))
		Endif
	
	End
	
	Method GetRotation:Float()
		Local f:Float=Self.j.y 'to prevent integer division giving integer
		If Self.j.y <>0
			Return ATan(-Self.i.y/f)	
		Else
			Print "Matrix is not a valid transform, could not get Rotation" 'should throw instead of print ..?
			Return 0.0
		Endif
	End
	
	Method GetTranslation:Vec2<T>()
		Return Self.t
	End

End

Class MyWindow Extends Window

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
	End

	Method OnRender( canvas:Canvas ) Override
	
		'App.RequestRender()

		canvas.Translate (1.0,7.0)
		canvas.Rotate(-0.55)
		canvas.Scale(8.6,8.0)
		'canvas.Rotate(0.2)
		
		Print canvas.Matrix.GetRotation()
		Print canvas.Matrix.GetScale()
		Print canvas.Matrix.GetScale().Length
		Print canvas.Matrix.GetTranslation()

		

		
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End
