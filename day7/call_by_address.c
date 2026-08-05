#include <stdio.h>
#include <stdlib.h>

void SumDiff(int, int, int*, int*);

int main()
{
    int iNo1;
    int iNo2;
    int iSum;
    int iDiff;

    printf("Enter two numbers:\t");
    scanf("%d%d", &iNo1, &iNo2);

    SumDiff(iNo1, iNo2, &iSum, &iDiff);

    printf("Sum is %d\n", iSum);
    printf("Difference is %d\n", iDiff);

    exit(0);
}

void SumDiff(int iNo1, int iNo2, int *piSum, int *piDiff)
{
    *piSum = iNo1 + iNo2;
    *piDiff = iNo1 - iNo2;
}