#include <stdio.h>
#include<stdlib.h>

int main(void)
{
    int iNo1;
    int iNo2;
    int iQuo;
    int iRem;

    printf("Enter operand 1: \t");
    scanf("%d",&iNo1);

    printf("Enter operand 2: \t");
    scanf("%d",&iNo2);

    iQuo =  iNo1 / iNo2;
    iRem =  iNo1 % iNo2;
    printf("Quotient is %d\n",iQuo);
    printf("Reminder is %d\n",iRem);
    exit(0);
}