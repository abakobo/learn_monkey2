#Import "<std>"

#Import "Foo.h"
'#Import "Foo.cpp"

Using std..

Extern 

'Class Foo Extends Void Abstract
'	Field foo:Int
'	Method MyVirtualMethod(i:Int) Virtual
'End

Class b2QueryCallback Extends Void Abstract
	Method ReportFixture:Bool(i:Int) Virtual
End

Public

'Class nonAbstractFoo Extends Foo
' Method MyVirtualMethod(i:Int) Override
'  Print "MyVirtualMethod has been called! "+i
' End
'End

Class nonAbstract Extends b2QueryCallback
	Field st:Stack<Int>
	Method New()
		st=New Stack<Int>
	End
	Method ReportFixture:Bool(i:Int) Override
		Return False
	End
End

Function Main()

	Print "monkey2 extern class test"
	
	Local instance:nonAbstract
	
	instance=New nonAbstract()
	
	
	Repeat	
		GCCollect()
	Forever

End