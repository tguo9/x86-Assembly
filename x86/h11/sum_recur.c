/* File:        sum_recur.c
 * Purpose:     Add the elements of an array using recursion
 *
 * Compile:     gcc -g -Wall -o sr sum_recur.c -DALL_C or
 *              gcc -g -Wall -o sr sum_recur.c sum_recur_func.s
 * Run:         ./sr
 *
 * Input:       n, contents of A
 * Output:      Sum of the elements of A
 */
#include <stdio.h>
#include <stdlib.h>

long Sum(long A[], long n);

void Read_arr(long A[], long n);
void Print_arr(long A[], long n);

int main(void) {
   long n, sum, *A;

   printf("Enter n\n");
   scanf("%ld", &n);

   A = malloc(n*sizeof(long));

   printf("Enter A\n");
   Read_arr(A, n);

   sum = Sum(A, n);

   printf("The sum is %ld\n", sum);

   free(A);

   return 0;
}  /* main */


#ifdef ALL_C
// n >= 1
// A and B are initialized by the caller
// All three arrays store n elements
long Sum(long A[], long n) {
   long tmp;
   if (n == 1)
      return A[0];
   else {
      tmp = Sum(A, n-1);
      return A[n-1] + tmp;
   }
}  /* Sum */
#endif

void Read_arr(long A[], long n) {
   int i;
   for (i = 0; i < n; i++)
      scanf("%ld", &A[i]);
}  /* Read_arr */


void Print_arr(long A[], long n) {
   int i;
   for (i = 0; i < n; i++)
      printf("%ld ", A[i]);
   printf("\n");
}  /* Print_arr */
