#include<stdio.h>
#include <stdlib.h>

static int g=10;
int main(void)
{
    printf("g is %d\n",g);
    printf("&g is %d\n",&g);
    exit(0);
}