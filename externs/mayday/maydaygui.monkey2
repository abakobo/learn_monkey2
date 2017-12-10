
Namespace myapp

#Import "<std>"
#Import "<mojo>"
#Import "v3.h"

Using std..
Using mojo..

Extern

struct sVector3
	Field x:Float
	Field y:Float
	Field z:Float
	
	Method New()
	Method New(a:float,b:float,c:float)
	
	'inline sVector3 operator *(const sVector3& v, float s)
	Operator*:sVector3(s:float )
	Operator+:sVector3(v:sVector3 )
	Operator+=( v:sVector3 )
	
'!!!!!!operator skipped!! line: Float& operator [](int i)
'!!!!!!operator skipped!! line: float& operator [](int i)
'!!!!!!operator skipped!! line: sVector3& operator *=(float s)
'!!!!!!operator skipped!! line: sVector3& operator /=(float s)
'!!!!!!operator skipped!! line: sVector3& operator +=(sVector3& v)
'!!!!!!operator skipped!! line: sVector3& operator -=(sVector3& v)
end

'Function :sVector3 Opeerator
'Function :sVector3 Opeerator
'Function :sVector3 Opeerator
Function Dot:float(a:sVector3,b:sVector3)
Function Cross:sVector3(a:sVector3,b:sVector3)
Function Project:sVector3(a:sVector3,b:sVector3)
Function Reject:sVector3(a:sVector3,b:sVector3)
Function Magnitude:float(v:sVector3)
Function Normalize:sVector3(v:sVector3)
'Function :sVector3 Opeerator
'Function :sVector3 Opeerator

Public

Class MyWindow Extends Window
	
	Field s3:sVector3
	Field s3b:sVector3
	

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )

		Super.New( title,width,height,flags )
		s3=New sVector3(7.0,8.0,9.0)
		s3b=New sVector3(20.0,20.0,20.0)
		s3b=s3+s3b*15.0
	End

	Method OnRender( canvas:Canvas ) Override
	
		App.RequestRender()
	
		canvas.DrawText( "Hello World!"+s3b.x,Width/2,Height/2,.5,.5 )
	End
	
End

Function Main()

	New AppInstance
	
	New MyWindow
	
	App.Run()
End
