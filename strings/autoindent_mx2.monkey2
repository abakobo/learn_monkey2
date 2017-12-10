
Namespace myapp

#Import "<std>"

Using std..

Global path:="c:\users\w7son\desktop\monkey2git\modules\monkey\docs\"

Function Main()

	Local files:=New String[27]
	
	files[0]=path+"language\modules.md"
	files[1]=path+"language\namespaces.md"
	files[2]=path+"language\types.md"
	files[3]=path+"language\arrays.md"
	files[4]=path+"language\strings.md"
	files[5]=path+"language\variants.md"
	files[6]=path+"language\Enums.md"
	files[7]=path+"language\variables.md"
	files[8]=path+"language\pointers.md"
	files[9]=path+"language\functions.md"
	files[10]=path+"language\loop-statements.md"
	files[11]=path+"language\conditional-statements.md"
	files[12]=path+"language\expressions.md"
	files[13]=path+"language\user-types.md"
	files[14]=path+"language\preprocessor.md"
	files[15]=path+"language\reflection.md"
	files[16]=path+"language\error-handling.md"
	files[17]=path+"language\assets-management.md"
	files[18]=path+"language\native-code.md"
	files[19]=path+"language\build-system.md"
	files[20]=path+"language\misc.md"
	files[21]=path+"articles\operator-overloading.md"
	files[22]=path+"articles\lambda-functions.md"
	files[23]=path+"articles\namespaces-and-using.md"
	files[24]=path+"articles\multifile-projects.md"
	files[25]=path+"sdks.md"
	files[26]=path+"mx2cc.md"
	
	Local text:String 
	Local missingFiles:=0
	
	text+="# Monkey2 Language Reference~n"
	text+="~n"
	text+="!! this is WIP with non official addons !!"
	text+="~n "
	text+="~n "
	text+="~n "
	text+="please review and comment on http://monkeycoder.co.nz/forums/topic/integrated-docs-github-community-organisation/ ~n"
	text+="or https://github.com/mx2DocsCommunity/monkey2 ~n"
	text+="~n "
	text+="~n "
	text+="~n"
	
	text+=LoadString("C:\Users\W7Son\Dropbox\mx2\learn_monkey2\strings\tableofcontents.md")
	
	
	For Local file:=Eachin files
		If GetFileType(file)=FileType.File
			Print file+" is file"
			text+=LoadString(file)
			If file.EndsWith("misc.md")
				text+="~n"
				text+="# Articles and Tutorials"
				text+="~n"
			endif
		Else
			Print file+" pas is File"
			missingFiles+=1
		Endif
	Next
	Print "missing/error on Files: "+missingFiles
	 
	SaveString(text,path+"printableDocs.md",True)
	
End