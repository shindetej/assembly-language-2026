### NEED TO KNOW
- what is external and internal linkage of variables and function
- for internal linkage make variable static
```
main.o

g_iNo = 101
   ^
   |
main() uses this


fun.o

g_iNo = 10
   ^
   |
fun() uses this
```
-----
In C:
there are two common uses of extern:

Forward declaration within the same source file (your example).
Declaration of a variable defined in another source file (the more common use when discussing linkage).

- 
```
| C                        | GAS                                      |
| ------------------------ | ---------------------------------------- |
| `int g_iNo = 10;`        | `.data` + `.globl g_iNo` + `.int 10`     |
| `int g_iNo;`             | `.bss` + `.comm g_iNo,4,4`               |
| `static int g_iNo = 10;` | `.data` + `g_iNo: .int 10` (no `.globl`) |
| `static int g_iNo;`      | `.bss` + `.lcomm g_iNo,4`                |

```