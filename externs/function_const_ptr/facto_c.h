const int* Factorial(int M)
{
   int factorial=1;
   int* returner;

   for(int i=1; i<=M; i++)
   {
      factorial = factorial*i;
   }
   returner=&factorial;
   return returner; // 'returning directly &factorial was not working, it had to be assigned to a 'named' int pointer
}
