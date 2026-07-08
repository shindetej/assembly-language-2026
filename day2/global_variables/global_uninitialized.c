#include<stdio.h>
#include<stdlib.h>

// To learn about common memory area
/*
*   .section .bss
*        .comm g, 4, 4
*/
int g;

int main(void)
{
    printf("Before scanning , g is %d\n",g);

    printf("Enter number : \t");
    scanf("%d",&g);

    printf("After scanning , g is %d\n",g);
    exit(0);
}