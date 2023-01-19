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



 while1_top:
        if(!1) goto while1_bot;
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
               update_count, current_x, current_f);
        
        if5_top_loop:
            if(fabs(current_f)>= MAX_ABS_F) goto if5_bot_loop;
            return 0;

        if5_bot_loop:
            ;

        if6_top_loop:
            if(update_count != max_updates) goto if6_bot_loop;
            return 0;
        
        if6_bot_loop:
            ;
        
        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;

    while1_bot:
        ;