
Namespace myapp

#Import "<std>"
#Import "<chipmunk>"


Using std..
Using chipmunk..

Struct cpVect Extension
	Operator To:Vec2f()
		Return New Vec2f(x,y)
		'Local v:Vec2f
		'v.x=x
		'v.y=y
		'Return v
	End
	Operator To:const_cpVect()
		Local cv:const_cpVect
		cv.x=x
		cv.y=y
		Return cv
	End
End
#rem
Struct Vec2<T> Extension
	Operator To:cpVect()
		Return cpv(x,y)
	End
	Operator To:const_cpVect()
		Local cv:const_cpVect
		cv.x=x
		cv.y=y
		Return cv
	End
End
#end
Function Main()
	Local vf:=New Vec2f(10,20)
	Local cpvect:cpVect
	cpvect=cpv(3,4)
	Print vf.x+" "+vf.y
	vf=cpvect
	Print vf.x+" "+vf.y
End