#ifndef CALLBACK6_H
#define CALLBACK6_H
typedef void (*callback)(void* potr);
void register_callback(callback ptr_reg_callback,void* pointer);

void my_callback(void* pointr);

callback gime_c_callback(void);

void register_callback(callback ptr_reg_callback,void* ponter);
#endif
