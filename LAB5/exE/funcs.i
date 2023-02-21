# 1 "funcs.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "funcs.c"


# 1 "funcs.h" 1





int use_pointers(const int *p, int n);

int use_indexes(const int *a, int n);
# 4 "funcs.c" 2

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
