' Import assets:
#Import "../assets/playniax.png"
#Import "../assets/background.png"

#Import "<std>"
#Import "<mojo>"
#Import "<pyro-scenegraph>"																				' Import pyro scene.

Using std..
Using mojo..
Using pyro.framework..
Using pyro.scenegraph..

Global virtualResolution:=New Vec2i( 640,480 )															' Backing global for virtual resolution.

Class PyroExample Extends Window

	' Backing fields:
	Field camera:Camera
	Field logo:LayerSprite
	Field scene:Scene

	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )

		Super.New( title,width,height,flags )

		Layout="letterbox"

		' To use sprites you need to setup the scene with a camera and atleast 1 layer:
		scene=New Scene( Self )																			' Create a scene.

		camera=New Camera( scene )
		'Local viewPoint:=virtualResolution/2'New Vec2f(
		'Local viewPoint:=New Vec2f(	0 , 0 )															' Setup camera.
		'camera.RotationPoint=virtualResolution/2'viewPoint'New Vec2f(0,0)'virtualResolution/2																' Rotation point is the center of the screen ( 0,0 by default ).
		'camera.ZoomPoint=virtualResolution/2'viewPoint'New Vec2f(0,0)'virtualResolution/2
		
		'camera.Location=viewPoint-(virtualResolution/2)		
		
		camera.SetByCenterViewpoint(New Vec2f(0,0),1.0,0.0,virtualResolution)															' Zoom point is the center of the screen ( 0,0 by default ).

		Local layer:=New Layer( scene )																	' Add layer.

		' Create the background sprite:
		' (  Note that the content manager is used to load the images but Image.Load can also be used instead )
		Local background:=New LayerSprite( layer,Content.GetImage( "asset::background.png" ) )
		background.Location=virtualResolution/2																' Center of the screen.
		
		' Create the logo sprite:
		logo=New LayerSprite( layer,Content.GetImage( "asset::playniax.png" ) )
		logo.Location=virtualResolution/2																		' Center of the screen.

	End

	Method OnMeasure:Vec2i() Override
		Return virtualResolution
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()

		'logo.Rotation+=.01
		
		scene.Update()																					' Update must be called before Draw!

		' Zoom and rotate keys:
		If Keyboard.KeyDown( Key.LeftControl )
			If Keyboard.KeyDown( Key.R ) camera.Rotation-=.05
			If Keyboard.KeyDown( Key.Z ) camera.Zoom-=.01
		Else
			If Keyboard.KeyDown( Key.R ) camera.Rotation+=.05
			If Keyboard.KeyDown( Key.Z ) camera.Zoom+=.01
		Endif
		
		If Keyboard.KeyDown( Key.Left ) camera.X-=1
		If Keyboard.KeyDown( Key.Right ) camera.X+=1
		If Keyboard.KeyDown( Key.Up ) camera.Y-=1
		If Keyboard.KeyDown( Key.Down ) camera.Y+=1
		
		scene.Draw( canvas )																			' Draw all scene objects to canvas.

		canvas.DrawText( "Use R or Left Control+R to rotate.",8,8 )
		canvas.DrawText( "Use Z or Left Control+Z to zoom in/out.",8,8+canvas.Font.Height )

	End

End

Class Camera Extension
	Method SetByCenterViewpoint(viewpoint:Vec2f,zoom:Float,rotation:Float,vResolution:Vec2f)
		
		RotationPoint=vResolution/2
		ZoomPoint=vResolution/2
		Location=viewpoint-(vResolution/2)
		
		Rotation=rotation
		Zoom=zoom		
	End
End

Function Main()

	New AppInstance
	
	New PyroExample( "Pyro example",640,480 )
	
	App.Run()

End
