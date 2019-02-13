/* File:    main.c
 *
 * Purpose: C driver for x86 assembler insertion sort function.
 *
 * Compile: gcc -o ins ins_sort.c -DALL_C
 * Usage:   ./ins <n>
 *             n:   number of elements in list
 *
 * Input:   list n long ints 
 * Output:  sorted list
 *
 * Notes:
 * 1.  If the macro ALL_C is defined, the assembly code should be
 *     omitted:
 *
 *           gcc -o ins ins_sort.c -DALL_IN_C
 */
#include <stdio.h>
#include <stdlib.h>

void Usage(char* prog_name);
void Get_args(int argc, char* argv[], long* n_p);
void Print_list(long a[], long n);
void Read_list(long a[], long n);
void Ins_sort(long a[], long n);      /* The assembly function */
#ifdef ALL_C
long Where_to_insert(long a[], long i);
void Insert(long a[], long j, long i);
#endif

/*-----------------------------------------------------------------*/
int main(int argc, char* argv[]) {
   long  n, *a;

   Get_args(argc, argv, &n);
   a = malloc(n*sizeof(long));
   printf("Enter the elements of the list\n");
   Read_list(a, n);

   Ins_sort(a, n);

   printf("Sorted list\n");
   Print_list(a, n);
   
   free(a);
   return 0;
}  /* main */


/*-----------------------------------------------------------------
 * Function:  Usage
 * Purpose:   Summary of how to run program
 */
void Usage(char* prog_name) {
   fprintf(stderr, "usage:   %s <n>\n", prog_name);
   fprintf(stderr, "    n:   number of elements in list\n");
}  /* Usage */


/*-----------------------------------------------------------------
 * Function:  Get_args
 * Purpose:   Get and check command line arguments
 * In args:   argc, argv
 * Out arg:   n_p
 */
void Get_args(int argc, char* argv[], long* n_p) {
   if (argc != 2 ) {
      Usage(argv[0]);
      exit(0);
   }
   *n_p = strtol(argv[1], NULL, 10);

}  /* Get_args */


/*-----------------------------------------------------------------
 * Function:  Print_list
 * Purpose:   Print the elements in the list
 * In args:   a, n
 */
void Print_list(long a[], long n) {
   int i;

   for (i = 0; i < n; i++)
      printf("%ld ", a[i]);
   printf("\n\n");
}  /* Print_list */


/*-----------------------------------------------------------------
 * Function:  Read_list
 * Purpose:   Read elements of list from stdin
 * In args:   n
 * Out arg:   a
 */
void Read_list(long a[], long n) {
   int i;

   for (i = 0; i < n; i++)
      scanf("%ld", &a[i]);
}  /* Read_list */


#ifdef ALL_C
/*-----------------------------------------------------------------
 * Function:     Ins_sort
 * Purpose:      Sort list using insertion sort
 * In arg:       n
 * In/out arg:   a
 */
void Ins_sort(long a[], long n) {
   long i, pos;

   for (i = 1; i < n; i++) {
      pos = Where_to_insert(a, i);
      Insert(a, pos, i);
   }
}  /* Ins_sort */


/*-----------------------------------------------------------------
 * Function:     Where_to_insert
 * Purpose:      Find where a[i] should be inserted in the sorted
 *               list a[0], a[1], . . . , a[i-1]
 * In args:      a, i, n
 * Return val:   Subscript where a[i] should be inserted 
 */
long Where_to_insert(long a[], long i) {
   long j;

   for (j = i-1; j >= 0; j--)
      if (a[i] >= a[j]) return j+1;
   return 0;
}  /* Where_to_insert */


/*-----------------------------------------------------------------
 * Function:     Insert
 * Purpose:      Shift elements a[i-1], . . . , a[pos] forward by 1,
 *               and put a[i] in slot pos.
 * In args:      pos, i
 * In/out arg:   a
 */
void Insert(long a[], long pos, long i) {
   long k, temp;

   temp = a[i];
   for (k = i-1; k >= pos; k--)
      a[k+1] = a[k];
   a[pos] = temp;
}  /* Insert */
#endif
