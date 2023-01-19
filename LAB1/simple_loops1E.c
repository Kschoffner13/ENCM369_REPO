// simple_loops1E.c
// ENCM 369 Winter 2023 Lab 1 Exercise E

// INSTRUCTIONS:
//   Recode the definition of main in Goto-C
//   Make sure your modified program produces exactly the same
//   output as the original.

#include <stdio.h>

int main(void)
{
  int a[4] = {1200, 3400, 5600, 7800};
  int *p;
  int i;

  f_loop_top:
    if(p >= a) goto f_loop_bot;
    p = a;
    goto f_loop_mid;

  f_loop_mid:
    if(p >= a) goto f_loop_bot;
    printf("%d\n", *p);
    p++;
    goto f_loop_mid;

  f_loop_bot:
  ;


  for (p = a; p < a + 4; p++)
    printf("%d\n", *p);

  i = 234567;

  w_loop_top:
    if(i <= 1) goto w_loop_bot;
    printf("%d\n", i);
    i /= 16;
    goto w_loop_top;
  
  w_loop_bot:
    ;


  return 0;
}





//for loop: p points to a, while p is less than a+4, increment p by 1

/* 
*   output:
*   1200
*   3400
*   5600
*   7800
*   234567
*   14660
*   916
*   57
*   3
*/