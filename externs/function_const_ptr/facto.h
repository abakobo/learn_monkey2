//#ifndef FACTO_C_H
//#define FACTO_C_H

//typedef struct integor{int i;} integor;

const int* Factorial(int M)
{
   int factorial=1;
   int* returner;
   // Calculate the factorial with a FOR loop
   for(int i=1; i<=M; i++)
   {
      factorial = factorial*i;
   }
	returner=&factorial;
   return returner; // returning directly &factorial was not working, it had to be assigned to a 'named' pointer
}
//#endif