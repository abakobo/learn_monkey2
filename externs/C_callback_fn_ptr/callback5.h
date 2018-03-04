typedef void (*callback)(void* potr);
static void register_callback(callback ptr_reg_callback,void* pointer);

static void my_callback(void* pointr)
{
    printf("C callback\n");
    int* ipt;
    ipt=(int*)pointr;   
    *ipt=6;
}

static callback gime_c_callback(void)
{
return my_callback;
}

static void register_callback(callback ptr_reg_callback,void* ponter)
{
    printf("inside C register_callback\n");
    
    (*ptr_reg_callback)(ponter);                                  
}
