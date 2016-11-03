'//
'// You can Import a .h alone but not a .cpp alone("was not declared in this scope" error)
'// Both date2.h and date.cpp contain the exact same code but you'll get an error if you try
'// to import the .cpp instead of the .h
'//

#Import "<std>"

#Import "date2.h"
'#Import "date2.cpp"

Extern 

Class Date Extends Void
	Field foo:int
	Method New(year:int,month:int,day:Int)
	Method New()
	Method ~Date()
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
	
	moment.~Date()
	
	'Print moment.getYear()
	
	

End