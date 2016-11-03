
Namespace myapp

#Import "<std>"

Using std..


class C
   field t:=10
   method test:void()
      print t
   end
End
Function ftest:Void(i:int)
 Print "hoho"+i
End

function Main:void()
   local c:=New C
   Local f:void()=c.test   'Note: "c.test" is the 'tuple' you're after...
   f()
   Local f2:Void(i:int)=ftest
   f2(15)
end