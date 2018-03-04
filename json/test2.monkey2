
Namespace myapp

#Import "<std>"

Using std..

Function Main()

	ChangeDir("c:/mx2_short/json")

	Local arr:=New String[4]
	arr[0]="0"
	arr[1]="1"
	arr[2]="2"
	arr[3]="3"
	
	Local jobj:=New JsonObject
	Local kobj:=New JsonObject
	Local jarr:=New JsonArray
	
	For Local str:=Eachin arr
				jarr.Add( New JsonString( str ) )
	Next
	jobj["arrai"]=jarr
	
	jobj["i"]=New JsonNumber(7)
	jobj["j"]=New JsonNumber(8)
	
	kobj["a"]=New JsonString("haha")
	kobj["o"]=New JsonString("hoho")
	jobj["hihi"]=kobj
	
	SaveString( jobj.ToJson(),"test2.json" )
	
End