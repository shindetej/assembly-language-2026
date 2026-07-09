#include<stdio.h>
#include<stdlib.h>

int g_iNo; // for Internal linkage unintialzed
void fun()
{
    printf("In fun(), Number is %d\n",g_iNo);
}