'
'
' Julia Set example ------AVOIDING Structs------- (and resizable window)
'
'     a monkey 2 example-learning exercise initiated by abakobo
'     next steps/points of interest is 1:to optimise: -the drawpoint speed
'                                                        (done?, optimised by marksibly, using pixmap and pointer
'                                                        will try to have the pixel pointer as a field to avoid the call of New
'                                                        and also using smaller pixel formats for pixmap)
'                                                     -the choice for globals, fields, locals, struct:
'                                                        using struct for iterations is slower, see julia_with_struct(non_optim).monkey2
'                                                        Double or Float doesn't change anything (on 64bit computers at least?)
'
'                                      2:to make a kind of "explorer": zooming, Threshold, Iterations, +Constant(various sets)
'                                     
'                                      3:to save pictures or even animations!?
'
 
#Import "<std>"
#Import "<mojo>"
 
Using std..
Using mojo..
 
Global w_width:=800 'initial window size
Global w_height:=600
 
Global MaxIt:=64 'Julia's calculation precision
Global Threshold:Double=1.1 'Julia's escape Threshold
Global pxSize:Double=0.0035 'Initial size of a pixel on the complex plane (inverted zoom factor)
Global viewCenter_r:Double=0.0, viewCenter_i:Double=0.0 'Initial center point for viewing (on complex plane)
Global Palette:UInt[]
 
Class Julia Extends Window
 
	Field pixmap:=New Pixmap( w_width,w_height )
	Field image:=New Image( w_width,w_height,TextureFlags.Dynamic )
	Field center_pt:=New Vec2i(0,0)
 
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title,width,height,flags )
	End
	
	Method OnRender( canvas:Canvas ) Override
	
	
	'
	'  local vars declaration
	'
	Local Cr:Double, Ci:Double, Zr:Double, Zi:Double ' the complex number parts (should probably use struct...)
	Local ta:Int,tb:Int,tj:Int 'the timer vars
	Local x:Int,y:Int 'coord iterators
	Local max_wh:Int 'to get the maximal value of the window wether height or width
		
	' mandatory for continuous render
	App.RequestRender()
		
    '
    ' adapt to window size (resizable window)
    '
    
    If  w_width<>Self.Rect.Size.X or w_height<>Self.Rect.Size.Y
    
      Local maxs:=Max(w_width,w_height)
    	w_width=Self.Rect.Size.X
    	w_height=Self.Rect.Size.Y
    	Local maxs2:=Max(w_width,w_height)
    	
    	pxSize=pxSize*(maxs/(maxs2*1.0)) 'adapt zoom to new window size (because zoom factor is pixel's lenght)
    	
    	image.Discard() 'Images are not Garbage Collected so it's always better to Discard before changing it... (don't know if it's usefull in this case)
    	image=New Image( w_width,w_height,TextureFlags.Dynamic )
    	pixmap=New Pixmap( w_width,w_height )
    End If 
    
    '
    ' get the mouse coord and transform it to the complex constant used in Julia set
    '
		Cr=(App.MouseLocation.x-(w_width/2.0))*pxSize+viewCenter_r
		Ci=(App.MouseLocation.y-(w_height/2.0))*pxSize+viewCenter_i
		
		
    '
    ' Calculates Julia in indexed colors (iterations up to MaxIt-1 due to array starting at 0)
    ' and copy it to the pixmap
    '
		ta=Millisecs()
		
		For y=0 Until w_height
 
			Local p:=Cast<UInt Ptr>( pixmap.PixelPtr( 0,y ) )
		
			Zi=(y-(w_height/2.0))*pxSize+viewCenter_i
				
			For x=0 Until w_width
			
				Zr=(x-(w_width/2.0))*pxSize+viewCenter_r
				
				Local t:=NbIter( Zr,Zi,MaxIt,Threshold,Cr,Ci )
				
				p[x]=Palette[t]
				
			Next
			
		Next
		
		tb=Millisecs()
		tj=tb-ta 'Records the time it took to calculate Julia and copy it to the pixmap
    
		image.Texture.PastePixmap( pixmap,0,0 )
		canvas.DrawImage( image,0,0 )
		
		ta=Millisecs()
    tb=ta-tb
    
		' Prints timers and FPS
		'
		canvas.Color=Color.White
    
		canvas.DrawText( "Size="+Self.Rect.Size.ToString(),0,0 )
		canvas.DrawText("Julia to pixmap time: "+tj,0,15)
		canvas.DrawText("pixmap to canvas time: "+tb,0,30)
		canvas.DrawText("FPS:"+App.FPS,0,45)
	End
 
End
 
'
' squared complex+const series (Julia)
'
Function NbIter:Int(Zr:Double,Zi:Double,max_iter:Int,exit_radius:Double,Cr:Double,Ci:Double)
 
	Local i:=0
	Local Zr2:Double, Zi2:Double, er2:Double
	er2=exit_radius*exit_radius
	Zr2=Zr*Zr
	Zi2=Zi*Zi
	While i<max_iter-1 And Zr2+Zi2<er2
		Zi=2*Zr*Zi + Ci
		Zr=Zr2-Zi2 +Cr
		Zr2=Zr*Zr
		Zi2=Zi*Zi
		i+=1
	Wend
	Return i
End
 
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
 
Function Main()
	CreateGlobalPalette()
	New AppInstance
	New Julia( "Julia",w_width,w_height )
	App.Run()
End