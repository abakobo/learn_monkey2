//
// looks like you don't have to go #ifndef #define #end with functions (but you have to import the .h file in mx2)
//

//int Factorial(int M); 

int Factorial_send_var(int M)
{
   int factorial=1;

   // Calculate the factorial with a FOR loop
   for(int i=1; i<=M; i++)
   {
      factorial = factorial*i;
   }

   return factorial; // This value is returned to caller
}

int Factorial_send_ptr(int* M)
{
   int factorial=1;

   // Calculate the factorial with a FOR loop
   for(int i=1; i<=*M; i++)
   {
      factorial = factorial*i;
   }

   return factorial; // This value is returned to caller
}

int Factorial_send_ref(int& M)
{
   int factorial=1;

   // Calculate the factorial with a FOR loop
   for(int i=1; i<=M; i++)
   {
      factorial = factorial*i;
   }

   return factorial; // This value is returned to caller
}