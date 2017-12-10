
Namespace myapp
#Import "<std>"
#Import "v2.h"
Using std..

Extern

struct sVect2
	Field x:Float
	Field y:Float
	Field arros:Float[]
	
	Method New()
	Method New(a:float,b:float)
	Method aroule:float (a:Float ptr)
	Method MSwap<T>(a:T,b:T)
End

Function FSwap<T>(a:T,b:T)

Public

Function Main()

	Local va:sVect2
	va=New sVect2(1.0,2.0)
	Local vb:sVect2
	vb=New sVect2(20.0,20.0)
	
	Local arr:=New Float[] (10.0,7.0)
	Print va.aroule(arr.Data)
	
	Print va.x+" "+vb.x
	FSwap (va,vb) 'this works with variables passed by reference
	Print va.x+" "+vb.x 'swap has succeded !! 
	
	va.MSwap(va,vb) 'This one doesn't work (has 3 params instead of 2 and g++ says " 'MSwap' was not declared in this scope ")
	Print va.x+" "+vb.x ' :(
	
End