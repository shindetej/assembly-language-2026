#include<stdio.h>
#include<stdlib.h>

static int g_iNo=10; // for Internal linkage make variable static
void fun()
{
    printf("In fun(), Number is %d\n",g_iNo);
}