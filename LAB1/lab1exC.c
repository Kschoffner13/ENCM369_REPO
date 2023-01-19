#include <stdio.h>


int main(void)
{
    int outer, inner;
    outer = 3;
    
    outer_loop:
        if (outer == 0) goto quit_outer_loop;
        inner = 0;
    
    inner_loop:
        if (inner > outer) goto quit_inner_loop;
        printf(" %d", 100 * outer + inner);
        inner++;
        goto inner_loop;
    
    quit_inner_loop:
        printf(" **\n");
        outer--;
        goto outer_loop;
    
    quit_outer_loop:
        printf("*****\n");
        return 0;
}