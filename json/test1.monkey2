
Namespace myapp

#Import "<std>"

Using std..

Function Main()

	ChangeDir("c:/mx2_short/json")

	Local arr:=New String[4]
	arr[0]="=0"
	arr[1]="=1"
	arr[2]="=2"
	arr[3]="=3"
	Local i:=7
	Local j:=8
	
	Local jobj:=New JsonObject
	Local jarr:=New JsonArray
	For Local str:=Eachin arr
				jarr.Add( New JsonString( str ) )
	Next
	jobj["arrai"]=jarr
	jobj[i]=New JsonNumber(i)
	jobj[j]=New JsonNumber(j)
	


	SaveString( jobj.ToJson(),"test1.json" )
	
	
End