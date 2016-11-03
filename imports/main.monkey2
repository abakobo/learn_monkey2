Namespace myapp

#Import "<std>"
#Import "lib_a"

'you could comment this line because lib_d imports lib_b but as I directly use lib_b I prefer to import it twice, won't be double after compil
#Import "lib_b"
 
#Import "lib_c"
#Import "lib_d"

Using std..
Using lib_b..
' I use lib_c. prefix and not "Using lib_c.." for demonstration
Using lib_d..

Function Main()

	'Glob_a is already defined in lib_a (=5)
	Glob_b=7
	lib_c.Glob_c=12 'using namespace prefix
	Local foo:=New Class_b(21)
	Local foo2:=New Class_d(37)
	
	Print Glob_a
	Print Glob_b
	Print lib_c.Glob_c
	Print foo.Get()
	Print foo2.Get()
	Print fooGlobal.Get()'defined in lib_d
	
End