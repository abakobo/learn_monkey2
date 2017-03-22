#Import "<libc>"
 
Using libc
 
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
 
Function Main()
 
	Print "Hi how are you?"
	
	'Get C Input
	Local answer:String = GetInput("Enter: ",50)
	Print "good boy johny "+answer+ " is."
	Print "all ok?"
 
End