.section .rodata
    msg_main_print1:
    .string "%d\n"
    msg_main_print2:
    .string "Enter arr[%d][%d] value:\t"
    msg_main_scanf:
    .string "%d"

.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $48, %esp

    leal -48(%ebp), %ebx
    pushl %ebx
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    movl $4, %eax          # sizeof(int)
    movl $4, %ecx          # elements per row
    mull %ecx               # eax = 4 * 4 = 16 (row stride in bytes)
    movl %eax, %ecx         

    movl $2, %eax           
    mull %ecx                # eax = counter1 * 16 = 2 * 16 = 32

    leal -48(%ebp), %ebx     # ebx = base address (&arr)
    addl %eax, %ebx           

    movl $3, %eax
    leal (%ebx, %eax, 4), %ebx      # where ebx has address after adding 32 and eax*4 i.e 12 added to it
    pushl %ebx
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    movl $2 ,%eax
    movl $3 ,%edx
    pushl %edx
    pushl %eax
    pushl $msg_main_print2
    call printf
    addl $12,%esp


    movl $4, %eax          # sizeof(int)
    movl $4, %ecx          # elements per row
    mull %ecx               # eax = 4 * 4 = 16 (row stride in bytes)
    movl %eax, %ecx         

    movl $2, %eax           
    mull %ecx                # eax = counter1 * 16 = 2 * 16 = 32

    leal -48(%ebp), %ebx     # ebx = base address (&arr)
    addl %eax, %ebx           

    movl $3, %eax
    leal (%ebx, %eax, 4), %ebx
    pushl %ebx
    pushl $msg_main_scanf
    call scanf
    addl $8,%esp

    movl (%ebx),%eax
    pushl %eax
    pushl $msg_main_print1
    call printf
    addl $8,%esp

    pushl $0
    call exit


# -2718532
# -2718488
