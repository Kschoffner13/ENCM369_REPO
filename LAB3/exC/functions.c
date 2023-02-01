/* functions.c: ENCM 369 Winter 2023 Lab 3 Exercise C */

/* INSTRUCTIONS:
 *   You are to write a RARS translation of this C program.  Because
 *   this is the first assembly language program you are writing where you
 *   must deal with register conflicts and manage the stack, there are
 *   a lot of hints given in C comments about how to do the translation.
 *   In future lab exercises and on midterms, you will be expected
 *   to do this kind of translation without being given very many hints!
 */

/* Hint: Function prototypes, such as the next two lines of C,
 * are used by a C compiler to do type checking and sometimes type
 * conversions in function calls.  They do NOT cause ANY assembly
 * language code to be generated.
 */

int procA(int first, int second, int third, int fourth);

int procB(int cat, int dog);

int train = 0x20000;

int main(void)
{
  /* Hint: This is a nonleaf function, so it needs a stack frame. */

  /* Instruction: Normally you could pick whatever two s-registers you
   * like for apple and banana, but in this exercise you must use s0
   * for plane and s1 for boat.
   */
  int plane;
  int boat;
  boat = 0xa000;
  plane = 0x3000;
  boat += procA(6, 4, 3, 2);
  train += (boat - plane);

  /* At this point train should have a value of 0x2790b. */

  return 0;
}

int procA(int first, int second, int third, int fourth)
{
  /* Hint: This is a nonleaf function, so it needs a stack frame,
   * and you will have to make copies of the incoming arguments so
   * that a-registers are free for outgoing arguments. */

  /* Instructions: Normally you would have a lot of freedom within the
   * calling conventions about what s-registers you use, and about where
   * you put copies of incoming arguments, but in this exercise you
   * must copy first to s0, second to s1, third to s2, and fourth to s3, 
   * and use s4 for alpha, s5 for beta, and s6 for gamma.
   */
  int alpha;
  int beta;
  int gamma;
  beta = procB(fourth, third);
  gamma = procB(second, first);
  alpha = procB(third, fourth);

  return alpha + beta + gamma;
}

int procB(int cat, int dog)
{
  /* Hint: this is a leaf function, and it shouldn't need to use any
   * s-registers, so you should not have use the stack at all. */
  return 256 * cat + dog;
}
