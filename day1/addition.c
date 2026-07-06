#include <stdio.h>
#include <stdlib.h>

int addition(int, int);

int main(void)
{
    int no1;
    int no2;
    int ans;

    printf("Enter two numbers : \t");
    scanf("%d%d", &no1, &no2);

    ans = addition(no1, no2);
    printf("Answer is %d\n", ans);

    exit(0);
}

int addition(int num1, int num2)
{
    int sum;
    sum = num1 + num2;
    return sum;
}