#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int arr[3][4];

    printf("%d\n", arr);
    printf("%d\n", &arr[2][3]);
    exit(0);
}