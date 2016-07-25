'
'
' Julia Set example ------AVOIDING Structs------- (and resizable window)
'
'     a monkey 2 example-learning exercise initiated by abakobo
'     next steps/points of interest is (done)1:to optimise: -the drawpoint speed
'                                                        (done?, optimised by marksibly, using pixmap and pointer
'                                                        pointer is faster local compared to field
'                                                        should try using smaller pixel formats for pixmap (not done, need to understand how to point to 24bits))
'                                                     -the choice for globals, fields, locals, struct:
'                                                        using struct for iterations is slower, see julia_with_struct(non_optim).monkey2
'                                                        Double or Float doesn't change anything (on 64bit computers at least?)
'                                                        Local is faster for basic variables, fields and globals seems to have same speed
'
'                                      (done)2:to make a kind of "explorer": zooming, Threshold, Iterations, +Constant(various sets)
'                                     
'                                      (done)3:to save pictures
'
'                                            
 
#Import "<std>"
#Import "<mojo>"
 
Using std..
Using mojo..
 
Global w_width:=800 'initial window size
Global w_height:=600
 
Global MaxIt:=16 'Julia's calculation precision
Global Threshold:Double=2.5 'Julia's escape Threshold
Global pxSize:Double=0.006 'Initial size of a pixel on the complex plane (inverted zoom factor)
Global viewCenter_r:Double=0.0, viewCenter_i:Double=0.0 'Initial center point for viewing (on complex plane)
Global move_spd:Double=0.06
Global Palette:UInt[]
 
Class Julia Extends Window
 
	
	Field image:=New Image( w_width,w_height,TextureFlags.Dynamic )
	Field Cr:Double=0.0, Ci:Double=0.0
  Field modif_const:=True 'Blocks the anim or not (true=animated) (bad name)
  Field count:=-1 'count for the auto anim
  Field modif_const_mouse:=False 'flag/selector for auto or mouse anim (bad name)
  Field pixmap:=New Pixmap( w_width,w_height,PixelFormat.RGBA32 )
  Field saveIt:=False
  
 
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title,width,height,flags )
	End
	
	'
	'These are equivalent to Keyboard.KeyPressed(Key.XXX) But with better memory of things
	'Sometimes in OnRender with low FPS it skips some Keyboard.Keyxxxxx here not!
	'
	Method OnKeyEvent( event:KeyEvent ) Override	
		Select event.Type
			Case EventType.KeyDown
			Select event.Key
				Case Key.Space
			    modif_const=Not modif_const
			  Case Key.P
          saveIt=True
        Case Key.C
          modif_const_mouse=Not modif_const_mouse
			End Select
		End Select		
	End Method

	Method OnRender( canvas:Canvas ) Override
	
	
	'
	'  local vars declaration
	'
	Local Zr:Double, Zi:Double ' the complex number parts (should probably use struct...)
	Local ta:Int,tb:Int,tj:Int 'the timer vars
	Local x:Int,y:Int 'coord iterators
	Local max_wh:Int 'to get the maximal value of the window wether height or width
  Local p:UInt Ptr
		
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
    	
    	image.Discard() 'Images are not Garbage Collected so it's always better to Discard before changing it... (here it's a Field so probably not usefull)
    	image=New Image( w_width,w_height,TextureFlags.Dynamic )
    	pixmap=New Pixmap( w_width,w_height )
    End If
    
    
    
    '
    '
    '   Keyboard controls
    '
    '
    If Keyboard.KeyDown(Key.Up) Then viewCenter_i-=move_spd*(pxSize/0.006)
    If Keyboard.KeyDown(Key.Down) Then viewCenter_i+=move_spd*(pxSize/0.006)
    If Keyboard.KeyDown(Key.Left) Then viewCenter_r-=move_spd*(pxSize/0.006)
    If Keyboard.KeyDown(Key.Right) Then viewCenter_r+=move_spd*(pxSize/0.006)
    If Keyboard.KeyDown(Key.W|Key.Raw) Then pxSize=pxSize/1.05
    If Keyboard.KeyDown(Key.S|Key.Raw) Then pxSize=pxSize*1.05
    If Keyboard.KeyDown(Key.A|Key.Raw) Then Threshold/=1.01
    If Keyboard.KeyDown(Key.D|Key.Raw) Then Threshold*=1.01
    If Keyboard.KeyDown(Key.I|Key.Raw)
      MaxIt+=1
      CreateGlobalPalette()
    Endif
    If Keyboard.KeyDown(Key.K|Key.Raw) 
      MaxIt=Max(2,MaxIt-1)
      CreateGlobalPalette()
    Endif
   
    
    '
    ' auto or mouse anim
    '
    If modif_const_mouse=True
     '
     ' get the mouse coord and transform it to the complex constant used in Julia set
     '
     If modif_const=True
      Cr=(App.MouseLocation.x-(w_width/2.0))*pxSize+viewCenter_r
      Ci=(App.MouseLocation.y-(w_height/2.0))*pxSize+viewCenter_i
		 Endif
		Else
		 '
		 ' create an anim while modifying the julia's const
		 '
		 If modif_const=True
		  count+=1
		  Cr=1.65*Cos(count/29.0)
      Ci=1.4*Sin(count/30.0)
     Endif
    Endif
		
		
    '
    ' Calculates Julia in indexed colors (iterations up to MaxIt-1 due to array starting at 0)
    ' and copy it to the pixmap with pointer for faster copy (faster than stepixel necause the adress only calculated #height times
    '
		
		For y=0 Until w_height
 
			p=Cast<UInt Ptr>( pixmap.PixelPtr( 0,y ) )
		
			Zi=(y-(w_height/2.0))*pxSize+viewCenter_i
				
			For x=0 Until w_width
			
				Zr=(x-(w_width/2.0))*pxSize+viewCenter_r
				
				Local t:=NbIter( Zr,Zi,MaxIt,Threshold,Cr,Ci )
				
				p[x]=Palette[t]
				
			Next
			
		Next
		
    '
    '  copy the pixmap to an image and put the image to the main canvas
    '
		image.Texture.PastePixmap( pixmap,0,0 )
		canvas.DrawImage( image,0,0 )

    '
    ' Save the pixmap (if asked) before drawing text on it
    '
    If saveIt=True 'this is on the eventlistener for better response while on low FPS
      saveIt=False
      Local filename:="Nothing"
      filename = RequestFile("Save the file","png",True,"Julia")
      print ("youy"+filename+"youy")
      If filename<>""
        pixmap.Save(filename)
      Else
        Notify("Blempro","No files where selected")
      Endif
    
    Endif
    
		' Prints
		'
		canvas.Color=Color.White
    
		canvas.DrawText("Space: Pause/Play --- C to switch to auto-anim or mouse-anim --- P:Save as PNG",0,0)
		canvas.DrawText("W/S(Raw):Zoom --- A/D(Raw):Thershold --- I/K:Iterations --- Cursor:Move",0,20)
		canvas.DrawText("Cr:"+Cr,0,40)
    canvas.DrawText(" Ci:"+Ci,175,40)
    canvas.DrawText(" Iter:"+MaxIt,350,40)
		canvas.DrawText("FPS:"+App.FPS,0,55)
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
 
	Palette=New UInt[MaxIt] 'Palette is Global, Max It is global. declared at top
  
	For Local i:=0 Until MaxIt-1
		Palette[i]=ColorToBGRA( New Color(0.9*Abs(Sin(1.0*Pi*i/MaxIt)),0.9*Abs(Sin(1.0*Pi*i/MaxIt)),0.35-(i/(MaxIt*1.0))*0.34) )
	Next
 
	Palette[MaxIt-1]=ColorToBGRA( Color.Black )
 
End
 
Function Main()
	CreateGlobalPalette()
	New AppInstance
	New Julia( "Julia",w_width,w_height )
	App.Run()
End