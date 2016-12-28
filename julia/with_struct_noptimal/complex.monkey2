Namespace complexMath

#rem monkeydoc Convenience type alias for Cplx\<Float\>.
#end
Alias Cplxf:Cplx<Float>

#rem monkeydoc Convenience type alias for Cplx\<Double\>.
#end
Alias Cplxd:Cplx<Double>



#rem monkeydoc The Cplx type provides support for 2 component complexs.
#end
Struct Cplx<T>

	#rem monkeydoc Complex real part.
	#end
	Field r:T
	
	#rem monkeydoc Complex imaginary part.
	#end
	Field i:T
	
	#rem monkeydoc Creates a new complex.
	#end
	Method New()
	End
	
	Method New( x:T,y:T )
		Self.r=x
		Self.i=y
	End
	
	#rem monkeydoc The real part of the complex.
	#end
	Property R:T()
		Return r
	Setter( x:T )
		Self.r=x
	End
	
	#rem monkeydoc The imaginary part of the complex.
	#end
	Property I:T()
		Return i
	Setter( y:T )
		Self.i=y
	End
	
	#rem monkeydoc Negates the complex and returns the result.
	#end
	Operator-:Cplx()
		Return New Cplx( -r,-i )
	End
	
	#rem monkeydoc Multiplies the complex by another complex and returns the result.
	#end
	Operator*:Cplx( z:Cplx )
		Return New Cplx( r*z.r-i*z.i,r*z.i+i*z.r )
	End

	#rem monkeydoc Divides the complex by another complex and returns the result.
	#end	
	Operator/:Cplx( z:Cplx )
	  Local denom:T
	  denom=z.r*z.r+z.i*z.i
		Return New Cplx( (r*z.r+i*z.i)/denom,(i*z.r-r*z.i)/denom )
	End

	#rem monkeydoc Adds another complex to the complex and returns the result.
	#end	
	Operator+:Cplx( z:Cplx )
		Return New Cplx( r+z.r,i+z.i )
	End
	
	#rem monkeydoc Subtracts another complex from the complex and returns the result.
	#end
	Operator-:Cplx( z:Cplx )
		Return New Cplx( r-z.r,i-z.i )
	End
	
	#rem monkeydoc Scales the complex by a real value and returns the result.
	#end
	Operator*:Cplx( s:Double )
		Return New Cplx( r*s,i*s )
	End
	
	#rem monkeydoc Inverse scale the complex by a real value and returns the result.
	#end
	Operator/:Cplx( s:Double )
		Return New Cplx( r/s,i/s )
	End
	

	#rem monkeydoc The length (absolute) of the complex from origin on a plane representation.
	#end
	Property Length:Double()
		Return Sqrt( r*r+i*i )
	End
	
	#rem monkeydoc Normalizes the complex absolute and returns the result .
	#end
	Method Normalize:Cplx()
		Return Self/Length
	End
	
	#rem monkeydoc Squares the complex and returns the result .
	#end
	Method Square:Cplx()
		Return New Cplx( r*r-i*i,2*r*i )
	End
		
	#rem monkeydoc Gets a string representation for the complex.
	#end
	Method ToString:String()
		Return "Cplx("+r+","+i+")"
	End

End

