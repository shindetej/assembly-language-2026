#include <stdio.h>
#include<stdlib.h>

int main(void)
{
    int iNo1;
    int iNo2;
    long long iAns;

    printf("Enter operand 1: \t");
    scanf("%d",&iNo1);

    printf("Enter operand 2: \t");
    scanf("%d",&iNo2);

    iAns =  iNo1 * iNo2;
    printf("Multiplication is %qd\n",iAns);
    exit(0);
}