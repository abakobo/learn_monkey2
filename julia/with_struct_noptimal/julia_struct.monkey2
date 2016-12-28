'
'
' Julia Set example by abakobo  ------USING Cplx Structs and Vec2i Structs-------
'
'     a monkey 2 example-learning exercise
'     next steps/points of interest is to optimise: -the drawpoint speed
'                                                       (done?, optimised by marksibly, using pixmap and pointer
'                                                        will try to have the pixel pointer as a field later)
'                                                   -the choice for globals, fields, locals, struct:
'                                                                     (using struct for iterations is slower, see "Function NbIter" )
'
'
 
#Import "<std>"
#Import "<mojo>"
#Import "complex"

 
Using std..
Using mojo..
Using complexMath..
 
Global w_size:=New Vec2i(800,600) 'initial window size
 
Global MaxIt:=64 'Julia's calculation precision
Global Threshold:Double=1.1 'Julia's escape Threshold
Global pxSize:Double=0.003
Global viewCenter:=New Cplxd(0,0)
 
Global Palette:UInt[]
 
Class Julia Extends Window
 
	Field pixmap:=New Pixmap( w_size.x,w_size.y )
	Field image:=New Image( w_size.x,w_size.y,TextureFlags.Dynamic )
 
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title,width,height,flags )
	End
	
	Method OnRender( canvas:Canvas ) Override
	'
	'  local vars declaration
	'
	Local C:Cplxd, Z:Cplxd ' the complex numbers
	Local ta:Int,tb:Int,tj:Int 'the timer vars
	Local x:Int,y:Int 'coord iterators
	Local max_wh:Int 'to get the maximal value of the window wether height or width
	
	' mandatory for continuous render
	App.RequestRender()
		
		
		
    '
    ' adapt to window size (resizable window)
    '
    
    If  w_size<>Self.Rect.Size
    	w_size=Self.Rect.Size
    	image.Discard() 'Images are not GarbageCollected so it's always better to Discard before changing it... (don't know if it's usefull in this case)
    	image=New Image( w_size.x,w_size.y,TextureFlags.Dynamic )
    	pixmap=New Pixmap( w_size.x,w_size.y )
    End If 
    
    '
    ' get the mouse coord and transform it to the complex constant used in Julia set
    '
    C=ScreenToCplxView(New Vec2i(App.MouseLocation.x,App.MouseLocation.y),w_size,viewCenter,pxSize)
		
    '
    ' Calculates Julia in indexed colors (iterations up to MaxIt-1 due to array starting at 0)
    ' and copy it to the pixmap using pointer for faster rendering
    '
		ta=Millisecs()
		
		For y=0 Until w_size.y
 
			Local p:=Cast<UInt Ptr>( pixmap.PixelPtr( 0,y ) )
		
			Z.i=(y-(w_size.y/2.0))*pxSize+viewCenter.i
				
			For x=0 Until w_size.x
			
				Z.r=(x-(w_size.x/2.0))*pxSize+viewCenter.r
				
				Local t:=NbIter( Z,MaxIt,Threshold,C )
				
				p[x]=Palette[t]
				
			Next
			
		Next
		
    tb=Millisecs()
    tj=tb-ta 'Records the time it took to calculate Julia and copy it to the array

    ' draw the rendered pixmap to the screen
		image.Texture.PastePixmap( pixmap,0,0 )
		canvas.DrawImage( image,0,0 )
		
    
		' Prints timers and FPS
		'
		canvas.Color=Color.White
    
		canvas.DrawText("Move mouse arroud to see various Julia sets",0,0)
		'canvas.DrawText( "Size="+Self.Rect.Size.ToString(),0,0 )
		canvas.DrawText("Julia to array time: "+tj,0,15)
		canvas.DrawText("FPS:"+App.FPS,0,45)
	End
 
End
 
'
' squared complex+const series (Julia)
'
Function NbIter:Int(Z:Cplxd,max_iter:Int,exit_radius:Double,C:Cplxd)
 
	Local i:=0
	Local Zr2:Double, Zi2:Double, er2:Double
	er2=exit_radius*exit_radius
	Zr2=Z.r*Z.r
	Zi2=Z.i*Z.i
	While i<max_iter-1 And Zr2+Zi2<er2
	
    '-------------------------------------------------------------------
    
    'Three different ways to calculate the square that will affect rendering time (visible due to lots of iterations)
    'Uncomment/Comment Following square calculations to see speed change 
    '
	
    ' 1- The slowest one uses all of struct abilities (method+operator) (and miss the Zr2,Zi2 algorithm optimisation)
    '             ---> 2FPS when mouse at center but very readable!
		'Z=Z.Square()+C
	
    ' 2- The second one uses properties (Capital R and I in Cplx definition) ---> 4FPS when mouse at center
		Z.I=2*Z.r*Z.i + C.i
		Z.R=Zr2-Zi2 +C.r
		
	' 3- The fastest (when using struct) uses Fields ( Lowercase r and i for Z.r Z.i) ---> 11FPS when mouse at center	
		'Z.i=2*Z.r*Z.i + C.i
	'	Z.r=Zr2-Zi2 +C.r
	
	
	'-------------------------------------------------------------------
		
	'Comment/uncomment one of the above to see fps difference..	
		
		
		
		
		Zr2=Z.r*Z.r
		Zi2=Z.i*Z.i
		i+=1
	Wend
	Return i
End

'
' convert Color type to pixmap default pixel format
'
Function ColorToBGRA:UInt( color:Color )
	Return UInt(color.a*255) Shl 24 | UInt(color.b*255) Shl 16 | UInt(color.g*255) Shl 8 | UInt(color.r*255)
End

'
' Create the indexed color Palette
'
Function CreateGlobalPalette:Void()
 
	Palette=New UInt[MaxIt] 'Palette is Global, declared at top
  
	For Local i:=0 Until MaxIt-1
		Palette[i]=ColorToBGRA( New Color(Abs(Sin(2.0*Pi*i/MaxIt)),Abs(Sin(1.2*Pi*i/MaxIt)),0.6-(i/(MaxIt*1.0))*0.3) )
	Next
 
	Palette[MaxIt-1]=ColorToBGRA( Color.Black )
	
 
End

'
' Convert position on screen in pixel to position on the complex plane (center pos and zoom capabilities to be used later)
'
Function ScreenToCplxView:Cplxd(coords:Vec2i,windowSize:Vec2i,center:Cplxd,pixSize:Double) 'pxSize is the lenght of a pixel on the complex plane
	Return New Cplxd((coords.X-(windowSize.X/2.0))*pixSize+center.R,(coords.Y-(windowSize.Y/2.0))*pixSize+center.I)
End
 
Function Main()
	CreateGlobalPalette()
	New AppInstance
	New Julia( "Julia",w_size.x,w_size.y )
	App.Run()
End