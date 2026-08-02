#include<stdio.h>
#include<stdlib.h>

int main(void)
{   
    int iChoice;
    printf("Enter Your Choice:\n1. Addition\n2. Subraction\n3. Multiplication\n4. Division\n");
    scanf("%d",&iChoice);
    
    switch (iChoice)
    {
        case 1:
            printf("Addition");
        case 2:
            printf("Subtraction");
        case 3:
            printf("Multiplication");
        case 4:
            printf("Division");
        default:
            printf("Invalid choice");
    }
    
    return 0 ;
}