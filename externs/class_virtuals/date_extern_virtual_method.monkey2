#Import "<std>"

#Import "date.h"
#Import "date.cpp"

Extern 

Class Date Extends Void Abstract
	Field foo:int
	Method New(year:int,month:int,day:Int)
	Method New()
	Method getYear:Int()
	Method getDay:Int()
	Method getMonth:Int()
	Method MyVirtualMethod(i:Int) virtual
End

Public

Class nonAbstractDate Extends Date
 Method MyVirtualMethod(i:Int) Override
  Print "MyVirtualMethod has been called! "+i
 End
End

Function Main()

	Print "monkey2 extern class test"
	
	Local moment:Date
	
	moment=New nonAbstractDate()
	
	Print moment.getYear()
	
	'moment=New nonAbstractDate(2077,9,10)  --> generation a has no constructors error (can we call super. ?)
	
	Print moment.getYear()
	
	Print moment.foo 'has not been initialised yet
	
	moment.foo=3000
	
	Print moment.foo
	

End