typedef void (*callback)(void* potr);
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

void register_callback(callback ptr_reg_callback,void* ponter)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)(ponter);                                  
}
