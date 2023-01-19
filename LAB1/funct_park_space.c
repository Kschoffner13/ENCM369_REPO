void report(int celsius_temp)
{
  if (celsius_temp <= 0) {
    printf("The temperature is a chilly %d degrees.\n", celsius_temp);
    printf("Don't slip on the ice.\n");
  }
  else if (celsius_temp <= 14) {
    printf("The temperature is a cool %d degrees.\n", celsius_temp);
    printf("Wear a jacket.\n");
  }
  else if (celsius_temp <= 26) {
    printf("The temperature is a pleasant %d degrees.\n", celsius_temp);
    printf("Have a nice day.\n");
  }
  else {
    printf("The temperature is a warm %d degrees.\n", celsius_temp);
    printf("Have a glass of water.\n");
  }
}


void report(int celsius_temp){
coldp:
    if(celsius_temp > 0) goto coolp;
    printf("The temperature is a chilly %d degrees.\n", celsius_temp);
    printf("Don't slip on the ice.\n");
    return 0;

  coolp:
    if(celsius_temp > 14)goto pleasantp;
    printf("The temperature is a cool %d degrees.\n", celsius_temp);
    printf("Wear a jacket.\n");
    return 0;

  pleasantp:
    if(celsius_temp > 26) goto warmp;
    printf("The temperature is a pleasant %d degrees.\n", celsius_temp);
    printf("Have a nice day.\n");
    return 0;

  warmp:
    printf("The temperature is a warm %d degrees.\n", celsius_temp);
    printf("Have a glass of water.\n");
    return 0;
}



// exercise G

for(int i = n - 1; i >= 0; i--) {
        result *= x;
        result += a[i];
    }
    return result;



 