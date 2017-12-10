
'-------------------------------------------------------------------
'./importsnocomasepar.temph
'-------------------------------------------------------------------
'-------------------------------------------------------------------
'./v3.h
'-------------------------------------------------------------------
struct sVector3
'-----------------------------------Multiple Fields
	Field y:float		x,
	Field z:float		x,
'------Ya du array à gérer ici!
	Field  arros:float[]
	Method New()
	Method New(a:float,b:float,c:float)
'------Ya du array à gérer ici!
'------Ya du array à gérer ici!
'------Ya du array à gérer ici!
'------Ya du array à gérer ici!
'------Ya du array à gérer ici!
'------Ya du array à gérer ici!
'--- a is actualy an array, a extension/override could be cool
	Method aroule:float(a:float Ptr)
'------Ya du array à gérer ici!
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



