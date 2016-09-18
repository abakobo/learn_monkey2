#Import "<std>"




Function Main()

	Local i:=New int[64]
	
	For Local j:=0 To 63
		i[j]=j+15
	Next 
	Local pt:Int Ptr
	Local pt2:Int Ptr
	Local pt3:Int Ptr
	pt=Varptr i[5]
	pt2=i.Data
	'pt3=pt2.Data   'error! an array of int and a pointer to int are more or less the same thing but not!
	
	Print i[5]
	Print pt[0] '[0] is actualy dereferencing the pointer
	Print pt2[5] 	' an array of int and a pointer to int are more or less the same thing but in this case
					'but in this case ptx are not arrays in the monkey2 world the don't have .Data or .Lenght ...
	
	Local c:=Cast<Long>(i[5]) 'explicit convert (altough this one could be implicit)
	Print c
	Print "------"

	i[5]=100

	Print i[5]
	Print i.Data[5]
	Print pt[0]
	Print c ' this one won't have the change because value was copied in c at the time (not a pointer)
	Print "------"
	Print i[100] 'too far without error ? -> nasty bugs to arrive
	Print pt[1000000] ' you can go very too far while calling an array->probable fatal error 
	
End