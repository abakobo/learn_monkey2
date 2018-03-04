
Namespace myapp

#Import "<std>"
#Import "assets/imtest3.json"

Using std..

Function Main()

	#rem
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
	
	SaveString( jobj.ToJson(),"test3.json" )
	#End
	
	Local lobj:=JsonObject.Load( "asset::imtest3.json" )
	
			Print lobj.IsObject
			Print lobj.IsBool
			Print lobj.IsArray
			Print lobj.IsNull
			Print lobj.IsNumber
			Print lobj.IsString
	
	'Local objmap:=lobj.ToObject()
	
	Local JOAll:=lobj.All()
	
	While JOAll.Current <> Null
		Print JOAll.Current.Key
		JOAll.Bump()
	Wend
	
	If lobj["image"] 
		Local mobj:=lobj["image"] 
'		Print mobj
		
		Print mobj.IsObject
		Print mobj.IsBool
		Print mobj.IsArray
		Print mobj.IsNull
		Print mobj.IsNumber
		Print mobj.IsString
		
		'image est d'abord un array contennant un objet json (?? zarb)
		
		Local marr:=mobj.ToArray()
		
		Local leobj:=marr[0]
		Print "-------"
		Print leobj.IsObject
		Print leobj.IsBool
		Print leobj.IsArray
		Print leobj.IsNull
		Print leobj.IsNumber
		Print leobj.IsString
		
		Local levobj:=leobj.ToObject()
		
		If levobj["center"]
			
			Local imgval:=levobj["center"]
			
	'		Print imgval
			Print "-------"
			Print imgval.IsObject
			Print imgval.IsBool
			Print imgval.IsArray
			Print imgval.IsNull
			Print imgval.IsNumber
			Print imgval.IsString
			Print "++++++++++"
		Else
			Print "-+-+-+-+-+-+-+-+-+"
		End
		
		
		JOAll=leobj.ToObject().All()
		
		While JOAll.Current <> Null
			Print JOAll.Current.Key
			JOAll.Bump()
		Wend
		
		'Print marrALL
		
		'While marrALL.Current <> Null
		'	Print marrALL.Current.ToString()
		'	marrALL.Bump()
		'Wend
		
		
		'Local mobjALL:=mobj.All()

		'Print cobj.IsObject
		'Print cobj.IsBool
		'Print cobj.IsArray
		'Print cobj.IsNull
		'Print cobj.IsNumber
		'Print cobj.IsString
		
	End
	
End