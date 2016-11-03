#Import "<std>"
#Import "<mojo>"
 
Using std..
Using mojo..
 
Class MyWindow Extends Window
	Field theFont:Font
 
	Method OnRender( canvas:Canvas ) Override
		'canvas.Font = Font.Load( "C:\Windows/Fonts/comic.ttf", 20 )
		Local s:String
		For Local i:=0 To  255
			Local j:=i
			Local k:=15
			Repeat
				If j>616/10
					j=j-616/10
					k=k+30
				End
			Until j<=616/10
			s=String.FromChar(i)
			Print  s[0]+" "+s
			canvas.DrawText( s,j*10,k )
		Next
		s="elegant" 
		For Local i:=0 To 6
		 Print s[i]+" -->  "+String.FromChar(s[i])
		Next
		Print "--------"
		s="élégant" 'this contains 2 special "e" for elegant in french
		For Local i:=0 To 6
		 Print s[i]+" -->  "+String.FromChar(s[i])
		Next
		canvas.DrawText( s,10,300 )
		Print s
	End
End
 
Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End
