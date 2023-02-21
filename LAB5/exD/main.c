// main.c: part of ENCM 369 W22 Lab 5 Exercises D and E

#include <stdio.h>
#include <time.h>

#include "funcs.h"

#define N_ELEMENT ((int) 1e5) // 100,000
#define WHICH_CLOCK CLOCK_THREAD_CPUTIME_ID

int arr[N_ELEMENT];

// The clock_gettime function is not part of the Standard C
// library but is available on Linux and many other platforms.
// It can be used to be high-precision time measurements.  In
// the code in main it is used to collect how much CPU time was
// spent in calls to use_pointers and use_indexes. The function
// reports results in an object of type struct timespec, which
// describes time using two integers: a count of seconds and a
// count of nanoseconds.

// Conversion from struct timespec to total nanoseconds.
double timespec2ns(const struct timespec *tp)
{
  return 1.0e9 * tp->tv_sec + (double) tp->tv_nsec;
}

int main(void)
{
  for (int i = 0; i < N_ELEMENT; i++)
    arr[i] = i;
  
  struct timespec start, stop;
  int max;
  for (int run = 1; run <= 10; run++) {
    printf("run %d\n", run);

    clock_gettime(WHICH_CLOCK, &start);
    max = use_pointers(arr, N_ELEMENT);
    clock_gettime(WHICH_CLOCK, &stop);
    printf("    max from use_pointers: %d\n", max);
    printf("    time for use_pointers, in ns: %.2f\n",
           timespec2ns(&stop) - timespec2ns(&start));

    clock_gettime(WHICH_CLOCK, &start);
    max = use_indexes(arr, N_ELEMENT);
    clock_gettime(WHICH_CLOCK, &stop);
    printf("    max from use_indexes: %d\n", max);
    printf("    time for use_indexes, in ns: %.2f\n",
           timespec2ns(&stop) - timespec2ns(&start));
  }
  return 0;
}
