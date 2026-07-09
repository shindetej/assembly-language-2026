#include <stdio.h>
#include <stdlib.h>

int iNo1 = 10;
int iNo2;

void fun1();

int main()
{
    int iNo3;

    printf("Enter two numbers : \t");
    scanf("%d%d",&iNo2,&iNo3);

    printf("In main(), %d %d %d \n",iNo1,iNo2,iNo3);

    fun1();
    exit(0);
}

