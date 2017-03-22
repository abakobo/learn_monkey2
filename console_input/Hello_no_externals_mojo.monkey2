
Namespace myapp

#Import "<std>"
#Import "<mojo>"

Using std..
Using mojo..
 
Function GetInput:String(prompt:String, maxLength:Int)
	Local char := New Byte[1]
	Local input := New Byte[maxLength]
	Local count:Int = 0
	Local data:String = ""
	
	libc.fputs(prompt, libc.stdout) ' InLine Prompt
	
	While(True)
		If(String.FromChar(char[0]) <> "~n" And count < maxLength)
			libc.fread(char.Data, 1, 1, libc.stdin)
			input[count] = char[0]
			count += 1
		Else
			input[count - 1] = 0
			Exit
		Endif
	Wend
	
	For Local i := 0 Until count-1
		data += String.FromChar(input[i])
	Next
	
	Return data
	
End Function


Class MyWindow Extends Window

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
	
		canvas.DrawText( "Hello World!",Width/2,Height/2,.5,.5 )
		
		 
		Print "Hi how are you?"
		'Get C Input
		Local answer:String = GetInput("Enter: ",50)
		Print "good boy johny "+answer+ " is."
	
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End