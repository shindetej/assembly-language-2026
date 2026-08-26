.section .rodata
    msg_main_print:
    .string "%d\n"

.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $48, %esp

    leal -48(%ebp), %ebx
    pushl %ebx
    pushl $msg_main_print
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
    leal (%ebx, %eax, 4), %ebx  
    pushl %ebx
    pushl $msg_main_print
    call printf
    addl $8, %esp

    pushl $0
    call exit


# -2718532
# -2718488
