// lab03exE.c: ENCM 369 Winter 2023 Lab 3 Exercise E

// INSTRUCTIONS:
//   You are to write a MARS translation of this C program, compatible
//   with all of the calling conventions presented so far in ENCM 369.
//

int clamp(int bound, int x);

int special_sum(int bound, const int *x, int n);

int aaa[] = { 11, 11, 3, -11};
int bbb[] = { 200, -300, 400, 500 };
int ccc[] = { -2, -3, 2, 1, 2, 3 };

int main(void)
{
    // Normally you could pick whatever s-registers you like for red,
    // green, and blue.  However in this exercise you should use s0
    // for red, s1 for green, and s2 for blue -- this will help
    // make sure you learn to manage s-registers correctly.
    
    int red, green, blue;
    blue = 1000;
    red = special_sum(10, aaa, 4);
    green = special_sum(200, bbb, 4);
    blue += special_sum(500, ccc, 6) + red + green;

    // Here blue should have a value of 1416.

    return 0;
}

int clamp(int bound, int x)
{
    // Note: Even though this function has multiple return statements,
    // you should code it in assembly language with only one jr ra
    // instruction at the end of the procedure definition.

    // Hint: Something like sub t0, zero, a0 might be useful somewhere.

    if (x < -bound)
        return -bound;
    else if (x > bound)
        return bound;
    return x;
}

int special_sum(int bound, const int *x, int n)
{
    // Normally you could pick whatever s-registers you like for a, n,
    // bound, k, and sum.  However in this exercise you should use s0
    // for bound, s1 for x, s2 for n, s3 for result, and s4 for i; 
    // this will help make sure you manage s-registers correctly.

    int result;
    int i;
    result = 0;
    for (i = 0; i < n; i++)
        result += clamp(bound, x[i]);
    return result;
}
