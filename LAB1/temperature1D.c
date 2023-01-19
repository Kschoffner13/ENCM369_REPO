// temperature1D.c
// ENCM 369 Winter 2023 Lab 1 Exercise D

#include <stdio.h>

void report(int celsius_temp);

int main(void)
{
  report(-10);
  report(0);
  report(5);
  report(14);
  report(20);
  report(26);
  report(30);
  return 0;
}


void report(int celsius_temp){

  warmp:
    if(celsius_temp <= 26) goto pleasantp;
    printf("The temperature is a warm %d degrees.\n", celsius_temp);
    printf("Have a glass of water.\n");
    return 0;

  pleasantp:
    if (celsius_temp <= 14) goto coolp;
    printf("The temperature is a pleasant %d degrees.\n", celsius_temp);
    printf("Have a nice day.\n");
    return 0;

  coolp:
    if (celsius_temp <= 14) goto coldp;
    printf("The temperature is a cool %d degrees.\n", celsius_temp);
    printf("Wear a jacket.\n");
    return 0;
  
  coldp:
    printf("The temperature is a chilly %d degrees.\n", celsius_temp);
    printf("Don't slip on the ice.\n");
    return 0;

}




