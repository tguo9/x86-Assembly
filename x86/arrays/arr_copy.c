/* File:        arr_copy.c
 * Purpose:     Copy the contents of one array into another
 *
 * Compile:     gcc -g -Wall -o ac arr_copy.c -DALL_C or
 *              gcc -g -Wall -o ac arr_copy.c arr_copy_func.s
 * Run:         ./ac
 *
 * Input:       n, contents of A
 * Output:      contents of B 
 */
#include <stdio.h>
#include <stdlib.h>

void Copy(long A[], long B[], long n);

void Read_arr(long A[], long n);
void Print_arr(long A[], long n);

int main(void) {
   long n;
   long *A, *B;

   printf("Enter n\n");
   scanf("%ld", &n);

   A = malloc(n*sizeof(long));
   B = malloc(n*sizeof(long));

   printf("Enter A\n");
   Read_arr(A, n);

   Copy(A, B, n);

   printf("The copy is:\n");
   Print_arr(B, n);

   free(A);
   free(B);

   return 0;
}  /* main */


#ifdef ALL_C
// n >= 1
// A is initialized by the caller
// A and B can both store n elements
void Copy(long A[], long B[], long n) {
   long i;
   for (i = 0; i < n; i++)
      B[i] = A[i];
}  /* Add */
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
