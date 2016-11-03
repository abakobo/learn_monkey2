Namespace lib_d

'if lib_b is imported elsewhere via main you could miss the following but it would be bad practice, keep sure your dependecies are imported
'anyway you can import this several times, it won't be duplicated after compilation
#Import "lib_b"  

Using lib_b..


Global fooGlobal:=New Class_d(51)

Class Class_d Extends Class_b
	Method New(i:Int) 'in monkey2 you must define the constuctor if you defined one in the super class
		Super.New(i)
	End
	Method Set(i:Int)
		fi=i
	End
End

