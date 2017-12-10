
Namespace myapp

#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..

Struct TransformablePoly  'I'll assume here that center of polys are [0,0] so I'll wrap arround origin while creating them
	

	Field position:=New Vec2f()
	Field scale:=1.0
	Field angle:=0.0
	
	Private
	
	Field _nbVertices:int
	Field _vertices:Vec2f[]

	Public
	Method New(verts:Vec2f[])
		_vertices=verts
		_nbVertices=_vertices.GetSize(0) 'getting the number of vec2f in the array

			
	End
	
	Method GetTransformedVec2fPoly:Vec2f[]() 'Transforms all the vertices with AffineMat3
		
		
		' creating a transformation matrix
		Local transfo:=New AffineMat3f()
		transfo=transfo.Translate(position) 'third transform
		transfo=transfo.Scale(scale,scale) 'around (0,0) , second transform
		transfo=transfo.Rotate(angle) 'rotation arrond (0,0)! , first transform
		
		'transforming the vertices
		Local outputArray:=New Vec2f[_nbVertices]
		For Local i:=0 Until _nbVertices
			outputArray[i]=transfo.Transform(_vertices[i])
		Next
		Return outputArray	
	End
	
	Method GetTransformedXYPoly:Float[]()  'to be used with DrawPoly (it does not accepts vec2f!)

		Local outputArray:=New Float[_nbVertices*2]
		
		Local TranformedVec2:=GetTransformedVec2fPoly() 'getting the tranformed poly in a Vec2f array
		
		For Local i:=0 Until _nbVertices
			outputArray[2*i]=TranformedVec2[i].x
			outputArray[2*i+1]=TranformedVec2[i].y
		Next
		Return outputArray 'ouputing transformed poly in a x/y Float array (for drawpoly)
		
	End
	
End

Class MyWindow Extends Window
	
	Field poly1:TransformablePoly
	Field count:=0

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
		

		poly1=New TransformablePoly(New Vec2f[](New Vec2f(-10.0,-10.0),
												New Vec2f(10.0,-10.0),
												New Vec2f(10.0,10.0),
												New Vec2f(-10.0,10.0))) 'a square in polygon format (center at 0,0)


	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
		
		count+=1
		
		If count>400 Then count=10
		
		poly1.angle=count/100.0
		poly1.position=New Vec2f(count,count)
		poly1.scale=1.5-Sin(count/60.0)
	
		canvas.DrawPoly(poly1.GetTransformedXYPoly())
		
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End
