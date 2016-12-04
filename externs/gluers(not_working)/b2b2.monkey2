'iuyiu
#import "<std>"
#import "b2Draw.h"

Extern



Struct b2Color
	Field r:Float
	Field g:Float
	Field b:Float
	Method Set(ri:Float,di:Float,bi:Float)
End

Struct b2Vec2
	Field r:Float
	Field g:Float
	Field b:Float
	Method Set(ri:Float,di:Float,bi:Float)
End

Struct b2Transform
	Field r:Float
	Field g:Float
	Field b:Float
	Method Set(ri:Float,di:Float,bi:Float)
End



Class b2Draw Extends Void Abstract="b2Draw_glue"
	Method SetFlags(flags:Int)
	Method GetFlags:Int()
	Method AppendFlags(flags:Int)
	Method ClearFlags(flags:Int)
	Method DrawPolygon(vertices:b2Vec2 Ptr,vertexcount:Int,color:b2Color) Abstract
	Method DrawSolidPolygon (vertices:b2Vec2 Ptr,vertexcount:Int,color:b2Color) Abstract
	Method DrawCircle(center:b2Vec2,radius:Float,color:b2Color) Abstract="DrawCircle_glue"
	Method DrawSolidCircle(center:b2Vec2,radius:Float,axis:b2Vec2,color:b2Color) Abstract="DrawSolidCircle_glue"
	Method DrawSegment(p1:b2Vec2,p2:b2Vec2,color:b2Color) Abstract="DrawSegment_glue"
	Method DrawTransform(xf:b2Transform) Abstract="DrawTransform_glue"
End

Public

Class DebugDrawer Extends b2Draw
	Method DrawCircle(center:b2Vec2,radius:Float,color:b2Color) Override 
		Print b2Vec2toS(center)+","+radius+","+color.r
	End
	Method DrawSolidCircle(center:b2Vec2,radius:Float,axis:b2Vec2,color:b2Color) Override 
		Print b2Vec2toS(center)+","+radius+","+b2Vec2toS(axis)+","+color.r
	End
	Method DrawPolygon(vertices:b2Vec2 Ptr, vertexCount:int, color:b2Color) Override 
	End
    Method DrawSolidPolygon(vertices:b2Vec2 Ptr, vertexCount:int, color:b2Color) Override 
    End
    Method DrawSegment(p1:b2Vec2, p2:b2Vec2, color:b2Color) Override 
    End
    Method DrawTransform(xf:b2Transform) Override 
    End
End

Function b2Vec2toS:String(v:b2Vec2)
 Return "youlou"
End

Function Main()

	Print "test"	

End