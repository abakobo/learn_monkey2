#include "console_input_mx2.h"
#include <stdio.h>

void* Console_Input_mx2(void* cstring){

printf("%s",cstring);
char input[256];
scanf( "%s" , input );

// converting char array to void ptr
void* ret;
ret=static_cast<void*>(input);
return ret;
}