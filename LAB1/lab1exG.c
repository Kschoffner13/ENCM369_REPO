// lab1exG.c
// ENCM 369 Winter 2023 Lab 1 Exercise G

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ABS_F (5.0e-9)
#define POLY_DEGREE 4

double polyval(const double *a, int n, double x);
/* Return a[0] + a[1] * x + ... + a[n] * pow(x, n). */

int main(void)
{
    double f[] = {1.47, 0.73, -2.97, -1.15, 1.00};
    double dfdx[POLY_DEGREE];

    double guess;
    int max_updates;
    int update_count;
    int n_scanned;
    int i;

    double current_x, current_f, current_dfdx;

    printf("This program demonstrates use of Newton's Method to find\n"
           "approximate roots of the polynomial\nf(x) = ");
    printf("%.2f", f[0]);

    // first set

    i = 1;
    for1_top:
        if(i > POLY_DEGREE) goto for1_bot;          // end clause
        
        if1_top:
            if(f[i] < 0) goto if1_bot;
            printf(" + %.2f*pow(x,%d)", f[i], i);
        
        if1_bot:
            printf(" - %.2f*pow(x,%d)", -f[i], i);
        
        i++;                                        // loop ender


    for1_bot:
    ;


    printf("\nPlease enter a guess at a root, and a maximum number of\n"
           "updates to do, separated by a space.\n");
    n_scanned = scanf("%lf%d", &guess, &max_updates);


    // second set

    if3_top_loop:
        if(n_scanned == 2) goto if3_bot_loop;
        printf("Sorry, I couldn't understand the input.\n");
        exit(1);

    if3_bot_loop:
        ;


    if4_top_loop:
        if (max_updates >=1) goto if4_bot_loop;
        printf("Sorry, I must be allowed do at least one update.\n");
        exit(1);

    if4_bot_loop:
        ;
   


    printf("Running with initial guess %f.\n", guess);

    // third set
    i = POLY_DEGREE -1;

    for2_top_loop:
        if( i < 0) goto for2_bot_loop;
        printf("%d\n", i);
        dfdx[i] = (i + 1) * f[i + 1];   // Calculus!
        i--;
    
    for2_bot_loop:
        ;

        
    
    current_x = guess;
    update_count = 0;

    // fourth set 


    while (1) { 
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
            update_count, current_x, current_f);
       
        if (fabs(current_f) < MAX_ABS_F)
            break;
        if (update_count == max_updates)
            break;


        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;
    }


    // fifth set

    if (fabs(current_f) >= MAX_ABS_F)
        printf("%d updates performed, |f(x)| still >= %g.\n", 
               update_count, MAX_ABS_F);
    else
        printf("Stopped with approximate solution of %.10f.\n", 
               current_x);

    
    return 0;
}

double polyval(const double *a, int n, double x)
{
    double result = a[n];
    int i = n-1;

    f_top_loop:
        if(i < 0) goto f_bot_loop;
        result *= x;
        result += a[i];
        i--;
        goto f_top_loop;

    f_bot_loop:
        return result;

}
