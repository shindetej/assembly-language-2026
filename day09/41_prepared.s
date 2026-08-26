.section .rodata
    msg_main_print1:
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
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    movl $4, %eax          # sizeof(int)
    movl $4, %ecx          # elements per row
    mull %ecx               # eax = 4 * 4 = 16 (row stride in bytes)
    movl %eax, %ecx          # ecx = 16

    movl $2, %eax           # counter1 = row index
    mull %ecx                # eax = counter1 * 16 = 2 * 16 = 32

    leal -48(%ebp), %ebx     # ebx = base address (&arr)
    addl %eax, %ebx           # ebx = base_address + 32 = &arr[2][0]

    movl $3, %eax
    leal (%ebx, %eax, 4), %ebx   # ebx = &arr[2][3]
    pushl %ebx
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    pushl $0
    call exit
