/*
 * swap.c
 * ENCM 369 Winter 2023 Lab 3 Exercise F
 */


/* INSTRUCTIONS:
 *   A partially-completed assembly language translation of this
 *   file can be found in swap.asm.  Complete the translation
 *   by adding the necessary instructions to main and swap in
 *   swap.asm.
 */

void swap(int *left, int *right);
/* REQUIRES:
 *   left and right point to variables
 * PROMISES:
 *   *left == original value of *right.
 *   *right == original value of *left.
 */

int foo[] =  { 0x600, 0x500, 0x400, 0x300, 0x200, 0x100 };

int main(void)
{
  /* These three swaps will reverse the order of the elements
   * in the array foo. */
  swap(&foo[5], &foo[0]);
  swap(&foo[4], &foo[1]);
  swap(&foo[3], &foo[2]);

  return 0;
}

void swap(int *left, int *right)
{
  /* Hint: Think carefully about when use of the C * operator
   * means "load" and when it means "store".
   */
  int old_star_left;

  old_star_left = *left;
  *left = *right;
  *right = old_star_left;
}
