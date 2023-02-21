// funcs.c: part of ENCM 369 W22 Lab 5 Exercises D and E

#include "funcs.h"

int use_pointers(const int *p, int n)
{
  const int *end = p + n;
  int max = *p;
  while (p != end) {
    if (*p > max)
      max = *p;
    p++;
  }
  return max;
}

int use_indexes(const int *a, int n)
{
  int i, max = a[0];
  for (i = 0; i < n; i++)
    if (a[i] > max)
      max = a[i];
  return max;
}
