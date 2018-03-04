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

Class Date Extension
	Method Youhou()
		Print "youhou "+getYear()
	End
End


Function Main()

	Print "monkey2 extern class test"
	
	Local moment:=New Date(2018,02,19)

	moment.Youhou()

End