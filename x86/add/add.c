/* File:     add.c
 *
 * Purpose:  Linux program that adds two user-input long ints.  Calls x86 
 *           assembly function to do the addition.
 *
 * Compile:  gcc -g -Wall -o add -DALL_C or
 *           gcc -g -Wall -o add add.c sum.s 
 * Run:      ./add
 *
 * Input:    Two long ints
 * Output:   Their sum
 *
 * Notes:     
 * 1. This should be run on 64-bit x86 hardware running Linux.
 */

#include <stdio.h>

long Sum(long a, long b);

int main(void) {
   long a, b, c;

   printf("Enter two ints\n");
   scanf("%ld%ld", &a, &b);

   c = Sum(a, b);

   printf("The sum is %ld\n", c);

   return 0;
}

#ifdef ALL_C
long Sum(long a, long b) {
   long c;

   c = a+b;
   return c;
}  /* Sum */
#endif
