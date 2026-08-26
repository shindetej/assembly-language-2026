.equ MAX, 10                       # #define MAX 10

.section .rodata
    msg_main_print1:
    .string "Enter value of n(< %d):\t"

    msg_main_scanf:
    .string "%d"

    msg_main_print2:
    .string "Enter %d value:\t"

    msg_main_print3:
    .string "arr1 is:\n"

    msg_main_print4:
    .string "%d value is:\t%d\n"

    msg_main_print5:
    .string "arr2 is:\n"


.section .bss
    .comm  arr2, MAX*4, 4            # int arr2[MAX];

.section .data
    .globl arr1                    # int arr1[] = {10, 20, 30};
    .type  arr1, @object
    .size  arr1, 12
    .align 4
    arr1:
    .int  10, 20, 30


.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $8, %esp                  # -4(%ebp) = iMax, -8(%ebp) = iCounter

    pushl $MAX
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    leal -4(%ebp), %eax            # eax = &iMax
    pushl %eax
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    # C: for(iCounter = 0; iCounter < iMax; iCounter++) scanf(..., &arr2[iCounter]);
    movl $0, -8(%ebp)               # iCounter = 0
    jmp label_for1_cond

label_for1:
    pushl -8(%ebp)                  # iCounter
    pushl $msg_main_print2
    call printf
    addl $8, %esp

    movl -8(%ebp), %eax             # eax = iCounter
    leal arr2(,%eax,4), %edx        # edx = &arr2[iCounter]
    pushl %edx
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    incl -8(%ebp)                   # iCounter++

label_for1_cond:
    movl -8(%ebp), %eax             # iCounter
    movl -4(%ebp), %edx             # iMax
    cmpl %edx, %eax
    jl label_for1                   # loop while iCounter < iMax

    pushl $msg_main_print3
    call printf
    addl $4, %esp

    # C: for(iCounter = 0; iCounter < 3; iCounter++) printf(..., iCounter, arr1[iCounter]);
    movl $0, -8(%ebp)                # iCounter = 0
    jmp label_for2_cond

label_for2:
    movl -8(%ebp), %eax               # eax = iCounter
    movl arr1(,%eax,4), %edx          # edx = arr1[iCounter]
    pushl %edx                        # push last parameter first
    pushl -8(%ebp)
    pushl $msg_main_print4
    call printf
    addl $12, %esp

    incl -8(%ebp)                     # iCounter++

label_for2_cond:
    movl -8(%ebp), %eax                # iCounter
    cmpl $3, %eax
    jl label_for2                      # loop while iCounter < 3

    pushl $msg_main_print5
    call printf
    addl $4, %esp

    # C: for(iCounter = 0; iCounter < iMax; iCounter++) printf(..., iCounter, arr2[iCounter]);
    movl $0, -8(%ebp)                   # iCounter = 0
    jmp label_for3_cond

label_for3:
    movl -8(%ebp), %eax                 # eax = iCounter
    movl arr2(,%eax,4), %edx            # edx = arr2[iCounter]
    pushl %edx                          # push last parameter first
    pushl -8(%ebp)
    pushl $msg_main_print4
    call printf
    addl $12, %esp

    incl -8(%ebp)                       # iCounter++

label_for3_cond:
    movl -8(%ebp), %eax                  # iCounter
    movl -4(%ebp), %edx                  # iMax
    cmpl %edx, %eax
    jl label_for3                        # loop while iCounter < iMax

    pushl $0
    call exit
