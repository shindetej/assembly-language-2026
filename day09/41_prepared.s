.section .rodata
    msg_main_print:
    .string "%d\n"


.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $48, %esp                   # -48(%ebp) to -4(%ebp) = arr[3][4] (12 ints)

    leal -48(%ebp),%eax
    push %eax
    push $msg_main_print
    call printf
    add $8,%esp

    movl $2, %eax
    movl $16, %edx
    mull %edx                       # edx:eax 
    leal -48(%ebp,%eax), %ecx       # ecx = &arr[2][0] = ebp-16
    
    movl $3, %eax
    leal (%ecx,%eax,4), %eax        # eax = &arr[2][3] = ebp-4
    push %eax
    push $msg_main_print
    call printf
    add $8,%esp

    pushl $0
    call exit
