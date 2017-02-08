typedef void (*callback)(void* pointr);
void register_callback(callback ptr_reg_callback,void* pointer);

void my_callback(void* pointr)
{
    printf("C callback\n");
    int* ipt;
    ipt=(int*)pointr;   
    *ipt=6;
}

callback gime_c_callback(void)
{
return my_callback;
}

/*int callcallback(void)
{
    callback ptr_my_callback=my_callback;                           
    printf("inside C callcallback\n");
    int i;
    int* iptr;
    i=7;
    iptr=&i;
    void* vptr;
    vptr=iptr;
    
    register_callback(ptr_my_callback,vptr);
}*/
void register_callback(callback ptr_reg_callback,void* pointer)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)(pointer);                                  
}
