#Import "<std>"
#Import "<mojo>"

#Import "box2d.monkey2"
#Import "b2Draw_mojo.monkey2"

#Import "iforce2d-b2djson/mx2b2djson.monkey2"
#Import "assets/"
#Import "assets/images/@/images/"

Using std..
Using mojo..
Using box2d..

Global w_width:=1000 'initial window size
Global w_height:=700


Class Box2DgfxTest Extends Window

	
	Field DDrawer:b2Draw_mojo
	Field world:b2World
	Field down:b2Vec2
	'Bodies  --------- bodies are set as field because you'll need them to connect your sprites to it
	Field body:b2Body
	Field body2:b2Body
	Field body3:b2Body
	'step values
	Field timeStep:= 0.01666666667
	Field velocityIterations := 6
	Field positionIterations := 2
	
	Field bodyInfoArr:b2BodyImageInfo[]
	
	'Field img1:Image

	'center point of camera in physics world
	Field viewpoint:=New b2Vec2(0,2)
	
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		
		
		Super.New( title,width,height,flags )
	
	    Local bd:b2BodyDef
	    Local fd:b2FixtureDef
	    
	'------- Initialising the world 


		Local jsonPath:="asset::127.json"

		'Local theStr:=LoadString("asset::scene1.json",True)
		world=mx2b2dJson.b2dJsonReadFromAsset(jsonPath)

	'----- debugdrawer init and link---------------------------------------------------------------------------------------------
		DDrawer=New b2Draw_mojo 'this one must be a field or a global 
		world.SetDebugDraw( DDrawer  ) '
		DDrawer.SetFlags( e_shapeBit )
		DDrawer.SetCamera(New b2Vec2(2,2),70)  
		
		
		'comparage body index
		
		bodyInfoArr=Createb2BodyImageInfoArray(world,jsonPath)
		
		For Local i:=0 Until bodyInfoArr.Length
			''Print bodyInfoArr[i]?.imagePosition
		Next
		
'		For Local i:=0 Until world.GetBodyCount()
'			'Print b2Vec2ToS(barr[i].GetPosition ())
'		Next


		'img1=Image.Load("asset::images/bikebody.png")
		
		Print bodyInfoArr[4].imageFileName
		
		'img1=bodyInfoArr[4].image
		

 	
	End
	
	Method OnRender( canvas:Canvas ) Override
		App.RequestRender()
		canvas.Clear(Color.Black)
		
		'// Instruct the world to perform a single step of simulation.
		'// It is generally best to keep the time step and iterations fixed. ---> they have been set globally
		world.Stepp(timeStep, velocityIterations, positionIterations)
		
		' passing the canvas to the b2Draw_mojo instance (DDrawer)
		' It's mandatory before calling world.DrawDebugData()	
		DDrawer.SetCanvas(canvas) 
		
		'ask physics world to draw debug datas (using our DDrawer instance of b2Draw_mojo class)
		world.DrawDebugData()
		
		

		
		For Local i:=0 Until world.GetBodyCount()
				If bodyInfoArr[i].image<>Null
			'		canvas.DrawImage(bodyInfoArr[i].image,b2Vec2ToVec2f(bodyInfoArr[i].body.GetPosition()),bodyInfoArr[i].imageAngle,New Vec2f (bodyInfoArr[i].imageScale,bodyInfoArr[i].imageScale))
				Local pos:=DDrawer.PhysicsToCanvas(bodyInfoArr[i].body.GetPosition())
				Local rot:=bodyInfoArr[i].imageAngle
				Local zoo:=bodyInfoArr[i].imageScale

				'canvas.DrawImage(bodyInfoArr[i].image,pos,rot,zoo)
				canvas.DrawImage(bodyInfoArr[i].image,pos,rot,New Vec2f (zoo,zoo))
				
				End
		Next
		
		
		
		'quit the app after 800 cycles
		
		If Keyboard.KeyPressed(Key.Escape)
      App.Terminate()
		End 
	End
End
Function CreateBodyArray:b2Body[](world:b2World)

	Local count:=world.GetBodyCount ()
	Local BodyArray:=New b2Body[count]
	Local BodyArrayInv:=New b2Body[count]
	
	BodyArray[0]=world.GetBodyList()
	Local i:=1
	While i < count
		BodyArray[i]=BodyArray[i-1].GetNext()
		i+=1
	Wend
	For Local i:=0 Until count
		BodyArrayInv[i]=BodyArray[count-1-i]
	Next
	
	Return BodyArrayInv
	
End

Function CreateImageToBodyArray:Int[](path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local bodyImageArray: Int[]
	
	If lobj["image"]
		Local imgval:=lobj["image"]
		Local imgarr:=imgval.ToArray()
		Local imgArraySize:=imgarr.Length
		bodyImageArray=New Int[imgArraySize]
		
		For Local i:=0 Until imgArraySize
			Local imgarrelem:=imgarr[i]
			Local imgelemobj:=imgarrelem.ToObject()
			
			bodyImageArray[i]=imgelemobj["body"].ToNumber()
		Next
	End
	Return bodyImageArray	
End

Function GetImageCenterMap:IntMap<b2Vec2>(path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local positionsMap:=New IntMap<b2Vec2>
	
	If lobj["image"]
		Local imgval:=lobj["image"]
		Local imgarr:=imgval.ToArray() 'image est d'abord un array contennant objet json 
		Local imgArraySize:=imgarr.Length


		For Local i:=0 Until imgArraySize
			'Print "image" +i
			Local imgarrelem:=imgarr[i]
			
			Local imgelemobj:=imgarrelem.ToObject()
			
			'Print imgelemobj["body"].ToNumber()
			
			If imgelemobj["center"]

				Local imgval:=imgelemobj["center"]
				
				If imgval.IsNumber 'center is (0,0)
					
					'Print "center: 0,0 :  "+imgval.ToNumber()
					
					positionsMap[i]=New b2Vec2(0,0)
					
				Else 'imgval.isObject --> center with two elements x and y
					
					Local centerobj:=imgval.ToObject()
					Local x:= centerobj["x"].ToNumber()
					Local y:= centerobj["y"].ToNumber()
					''Print "center: "+ x +" , "+y
					positionsMap[i]=New b2Vec2(x,y)
						
				End			
			Else
				"-+-+-+-+-+-+-+-+-+"
			End
		Next

	Else
		'Print "no 'image' value"
	End
	
	Return positionsMap
	
End

Function GetImageFileNameMap:IntMap<String>(path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local namesMap:=New IntMap<String>
	
	If lobj["image"]
		Local imgval:=lobj["image"]
		Local imgarr:=imgval.ToArray() 'image est d'abord un array contennant objet json 
		Local imgArraySize:=imgarr.Length


		For Local i:=0 Until imgArraySize
			'Print "image name" +i
			Local imgarrelem:=imgarr[i]
			
			Local imgelemobj:=imgarrelem.ToObject()
			
			'Print imgelemobj["body"].ToNumber()
			
			If imgelemobj["file"]

				Local imgval:=imgelemobj["file"]
				
				If imgval.IsString 'center is (0,0)
					
					namesMap[i]=imgval.ToString()
					
					'Print "file name: "+namesMap[i]
					
				Else 'imgval.isObject --> center with two elements x and y
					
					'Print "no name" 
						
				End			
			Else
				Print "houlala prob de json"
			End
		Next

	Else
		'Print "no 'image' value"
	End
	
	Return namesMap
	
End

Function GetBodyNameMap:IntMap<String>(path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local namesMap:=New IntMap<String>
	
	If lobj["body"]
		
		Local imgval:=lobj["body"]
		Local imgarr:=imgval.ToArray() 'image est d'abord un array contennant objet json 
		Local imgArraySize:=imgarr.Length

		For Local i:=0 Until imgArraySize
			'Print "bodyname" +i
			Local imgarrelem:=imgarr[i]
			
			Local imgelemobj:=imgarrelem.ToObject()
			
			'Print i
			
			If imgelemobj["name"]

				Local imgval:=imgelemobj["name"]
				
				If imgval.IsString 'center is (0,0)
					
					namesMap[i]=imgval.ToString()
					
					'Print "body name: "+namesMap[i]
					
				Else 'imgval.isObject --> center with two elements x and y
					
					'Print "no name!" 
						
				End			
			Else
				"-+-+-+-+-+-+-+-+-+"
			End
		Next

	Else
		'Print "no 'image' value"
	End
	
	Return namesMap
	
End

Function GetImageScaleMap:IntMap<Float>(path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local scalesMap:=New IntMap<Float>
	
	If lobj["image"]
		Local imgval:=lobj["image"]
		Local imgarr:=imgval.ToArray() 'image est d'abord un array contennant objet json 
		Local imgArraySize:=imgarr.Length


		For Local i:=0 Until imgArraySize
			'Print "image name" +i
			Local imgarrelem:=imgarr[i]
			
			Local imgelemobj:=imgarrelem.ToObject()
			
			'Print imgelemobj["body"].ToNumber()
			
			If imgelemobj["scale"]

				Local imgval:=imgelemobj["scale"]
				
				If imgval.IsNumber 'center is (0,0)
					
					scalesMap[i]=imgval.ToNumber()
					
					'Print "file name: "+namesMap[i]
					
				Else 'imgval.isObject --> center with two elements x and y
					
					Print "no Scale!!!!!" 
						
				End			
			Else
				Print "houlala prob de json"
			End
		Next

	Else
		'Print "no 'image' value"
	End
	
	Return scalesMap
	
End

Function GetImageAngleMap:IntMap<Float>(path:String)
	
	Local lobj:=JsonObject.Load( path )
	Local anglesMap:=New IntMap<Float>
	
	If lobj["image"]
		Local imgval:=lobj["image"]
		Local imgarr:=imgval.ToArray() 'image est d'abord un array contennant objet json 
		Local imgArraySize:=imgarr.Length


		For Local i:=0 Until imgArraySize
			'Print "image name" +i
			Local imgarrelem:=imgarr[i]
			
			Local imgelemobj:=imgarrelem.ToObject()
			
			'Print imgelemobj["body"].ToNumber()
			
			If imgelemobj["angle"]

				Local imgval:=imgelemobj["angle"]
				
				If imgval.IsNumber 'center is (0,0)
					
					anglesMap[i]=imgval.ToNumber()
					
					'Print "file name: "+namesMap[i]
					
				Else 'imgval.isObject --> center with two elements x and y
					
					Print "no Angle!!!!!" 
						
				End			
			Else
				anglesMap[i]=0
			End
		Next

	Else
		'Print "no 'image' value"
	End
	
	Return anglesMap
	
End

Function Createb2BodyImageInfoArray:b2BodyImageInfo[](world:b2World,path:String)
	
	Local bodyCount:=world.GetBodyCount()
	Local ret:=New b2BodyImageInfo[bodyCount]
	
	Local bodyArray:=CreateBodyArray(world)
	For Local i:=0 Until bodyCount
		ret[i]=New b2BodyImageInfo()
		ret[i].body=bodyArray[i]
		ret[i].index=i
	Next
	
	Local imageToBodyArray:=CreateImageToBodyArray(path)
	Local bodyToImageMap:=New IntMap<Int>
	'Print "IIIIIIIIIIIIIIIIIIIIIIIIIIII" + imageToBodyArray.Length
	For Local i:=0 Until imageToBodyArray.Length
	'Print i +"--------------popoi"
		bodyToImageMap[imageToBodyArray[i]]=i

	Next

	
	'-----------------------------------------------------BodyName
	Local bodyNameMap:=GetBodyNameMap(path)
	For Local i:=0 Until bodyCount
		If bodyNameMap.Contains(i)
		ret[i].bodyName=bodyNameMap[i]
			'Print "body"+i+ " has name " + bodyNameMap[i]
		Else
			ret[i].bodyName=Null
			Print "body "+i+ " has no name!!!!!!!!!!!!!!!"
		End
	Next
	'------------------------------------------------------ CENTER
	Local posMap:=GetImageCenterMap(path)
	For Local i:=0 Until bodyCount

		If bodyToImageMap.Contains(i)
			ret[i].imagePosition=b2Vec2ToVec2f(posMap[bodyToImageMap[i]])
			'Print "body "+i+ " has image centered at " + b2Vec2ToS (posMap[bodyToImageMap[i]])
		Else
			ret[i].imagePosition=Null
			'Print "YOLLO"
		End
	Next
	'----------------------------FileName and image load
	Local nameMap:=GetImageFileNameMap(path)
	For Local i:=0 Until bodyCount
	
		If bodyToImageMap.Contains(i)
			ret[i].imageFileName="asset::"+nameMap[bodyToImageMap[i]]
			Print ret[i].imageFileName
			ret[i].image=Image.Load(ret[i].imageFileName)
			If ret[i].image<>Null
				ret[i].image.Handle=New Vec2f (0.5,0.5)
				Print "image load ok"
			Else
				Print "image load not ok "+i+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			End
			'Print "imge "+i+ " has filename " + nameMap[bodyToImageMap[i]]
		Else
			ret[i].imageFileName=Null
			'Print "image "+i+ " has no file"
		End
	Next
	
	Local scaleMap:=GetImageScaleMap(path)
	For Local i:=0 Until bodyCount
	
		If bodyToImageMap.Contains(i)
		ret[i].imageScale=scaleMap[bodyToImageMap[i]]
			'Print "imge "+i+ " has filename " + nameMap[bodyToImageMap[i]]
		Else
			ret[i].imageScale=Null
			'Print "image "+i+ " has no file"
		End
	Next
	
	Local angleMap:=GetImageAngleMap(path)
	For Local i:=0 Until bodyCount
	
		If bodyToImageMap.Contains(i)
		ret[i].imageAngle=angleMap[bodyToImageMap[i]]
			'Print "imge "+i+ " has filename " + nameMap[bodyToImageMap[i]]
		Else
			ret[i].imageAngle=Null
			'Print "image "+i+ " has no file"
		End
	Next
	
	For Local i:=0 Until bodyCount
		
	
			Print "----------------"
			Print ret[i].index
			
			Print ret[i].bodyName
			Print b2Vec2ToS(ret[i].body.GetPosition())
			
			Print ret[i].imageFileName
			Print ret[i].imagePosition
			Print ret[i].imageScale
			Print ret[i].imageAngle
		
	Next
	
	
	
	Return ret

End

Struct b2BodyImageInfo
	
	Field body:b2Body
	Field index:Int
	
	Field bodyName:String
	
	Field imageFileName:String
	Field imagePosition:Vec2f
	Field imageScale:Float
	Field imageAngle:Float
	Field image:Image
	
End


Function Main()

	New AppInstance
	New Box2DgfxTest( "Box2D_test",w_width,w_height )
	App.Run()
End