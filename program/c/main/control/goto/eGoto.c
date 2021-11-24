#include "stdio.h"
int main(int argc, char** argv){
    int i = 1;
    int sum = 0;
    loop:
    if( i<=100 )
    {
        sum += i;
        i++;
        goto loop;
    }
    printf("sum(1:100): %d\n", sum);
    goto endd;
    int d;
    endd:

    return 0;
}