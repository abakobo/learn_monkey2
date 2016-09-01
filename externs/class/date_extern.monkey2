#Import "<std>"

#Import "date.h"
#Import "date.cpp"

Extern 

Class Date Extends Void
	Field foo:int
	Method New(year:int,month:int,day:Int)
	Method New()
	Method getYear:Int()
	Method getDay:Int()
	Method getMonth:Int()
End

Public


Function Main()

	Print "monkey2 extern class test"
	
	Local moment:Date
	
	moment=New Date()
	
	Print moment.getYear()
	
	moment=New Date(2077,9,10)
	
	Print moment.getYear()
	
	Print moment.foo 'has not been initialised yet
	
	moment.foo=3000
	
	Print moment.foo
	

End