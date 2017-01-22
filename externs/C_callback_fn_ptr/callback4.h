typedef void (*callback)(void* pointr);
void register_callback(callback ptr_reg_callback,void* pointer);

void my_callback(void* pointr)
{
    printf("C callback\n");
    *pointr=6;
}

callback gime_c_callback(void)
{
return my_callback;
}

/*int callcallback(void)
{
    callback ptr_my_callback=my_callback;                           
    printf("inside C callcallback\n");
    void* integptr'malloc?
    register_callback(ptr_my_callback,integptr);
}*/
void register_callback(callback ptr_reg_callback,void* pointer)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)(pointer);                                  
}
