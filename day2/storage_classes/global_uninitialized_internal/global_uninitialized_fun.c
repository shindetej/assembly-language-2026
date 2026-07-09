#include<stdio.h>
#include<stdlib.h>

static int g_iNo; // for internal linkage of uninitialized
void fun()
{
    printf("In fun, g_iNo is %d\n",g_iNo);
    printf("In fun, Address of g_iNo is %d\n",&g_iNo);

}