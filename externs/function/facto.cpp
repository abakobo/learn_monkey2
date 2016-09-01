//
// looks like you don't have to include the .h once more here (only in monkey2) (with classes you'll have to)
//

int Factorial(int M)
{
   int factorial=1;

   // Calculate the factorial with a FOR loop
   for(int i=1; i<=M; i++)
   {
      factorial = factorial*i;
   }

   return factorial; // This value is returned to caller
}