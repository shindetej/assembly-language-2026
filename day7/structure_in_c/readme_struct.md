### Structure In C
```c
struct demo
{
    char chChar;
    int iNo;
    short int shiNo;
}obj1 = {'A', 10, 20};
```
- Concept of Padding
    - Compiler take large size datatype and processor word size
    - Smaller of(size datatype and processor word size)
        - called alignment size 
        - struct of(char and double) -> (double , word) -> smaller(8,4)->4
        - in above struct example -> small(int,word)-> (4,4) ->4
    - What to do with this alignment size
        - give memory in multiple of it IF member size in multiple of alignment size
        - if smaller give entire alignment size
- je waya gelele bytes ahet tyala padding bytes mhantat