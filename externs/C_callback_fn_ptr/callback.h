

void my_callback(void)
{
 
    printf("Enter a character: ");
char mystring[256];
scanf( "%s" , mystring );  
    printf("You entered %s.",mystring); 
}

typedef void (*callback)(void);
void register_callback(callback ptr_reg_callback);

/*'callback gime_callback(void)
'{
'callback ptr_my_callback=my_callback;
'return ptr_my_callback;
'}*/

void callcallback(void)
{
    callback ptr_my_callback=my_callback;                           
    printf("calling function callback\n");
    register_callback(ptr_my_callback);                             
    printf("back\n");
}

void register_callback(callback ptr_reg_callback)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)();                                  
}


