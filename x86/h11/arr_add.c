/* File:        arr_add.c
 * Purpose:     Add corresponding entries in two arrays of long ints
 *
 * Compile:     gcc -g -Wall -o aa arr_add.c -DALL_C or
 *              gcc -g -Wall -o aa arr_add.c arr_add_func.s
 * Run:         ./aa
 *
 * Input:       n, contents of A, contents of B
 * Output:      contents of C = A+B
 */
#include <stdio.h>
#include <stdlib.h>

void Add(long A[], long B[], long C[], long n);

void Read_arr(long A[], long n);
void Print_arr(long A[], long n);

int main(void) {
   long n;
   long *A, *B, *C;

   printf("Enter n\n");
   scanf("%ld", &n);

   A = malloc(n*sizeof(long));
   B = malloc(n*sizeof(long));
   C = malloc(n*sizeof(long));

   printf("Enter A\n");
   Read_arr(A, n);
   printf("Enter B\n");
   Read_arr(B, n);

   Add(A, B, C, n);

   printf("The sum is:\n");
   Print_arr(C, n);

   free(A);
   free(B);
   free(C);

   return 0;
}  /* main */


#ifdef ALL_C
// n >= 1
// A and B are initialized by the caller
// All three arrays store n elements
void Add(long A[], long B[], long C[], long n) {
   long i;
   for (i = 0; i < n; i++)
      C[i] = A[i] + B[i];
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
