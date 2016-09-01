
#Import "<std>"

#Import "stru.h"

Extern 

struct px 
	Field x:Int
	Field y:int
End

Public


Function Main()

	Print "monkey2 extern struct test"
	
	Local pix:px
	
	pix.x=10
	pix.y=15
	
	Print pix.x+" "+pix.y
	

End