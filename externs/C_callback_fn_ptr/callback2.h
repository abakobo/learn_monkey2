typedef void (*callback)(void);
void register_callback(callback ptr_reg_callback);

void my_callback(void)
{
    printf("C callback\n");
}

callback gime_c_callback(void)
{
return my_callback;
}

void callcallback(void)
{
    callback ptr_my_callback=my_callback;                           
    printf("inside C callcallback\n");
    register_callback(ptr_my_callback);
}

void register_callback(callback ptr_reg_callback)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)();                                  
}
