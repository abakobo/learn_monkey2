typedef void (*callback)(int* pointr);
void register_callback(callback ptr_reg_callback,int* pointer);

void my_callback(int* pointr)
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
    int* integptr'malloc?
    register_callback(ptr_my_callback,integptr);
}*/
void register_callback(callback ptr_reg_callback,int* pointer)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)(pointer);                                  
}
