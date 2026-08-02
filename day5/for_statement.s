.section .rodata
    msg_main_print1:
    .string "Enter number : \t"

    msg_main_scanf:
    .string "%d%d"

    msg_main_print2:
    .string "Printingn number : %d\n"


.section .text
.globl  main
.type   main,@function
main:
    pushl %ebp
    movl %esp,%ebp

    subl $8, %esp

    pushl $msg_main_print1
    call printf
    addl $4,%esp
 		
    leal -4(%ebp), %edx     # scanning logic to take iNo   		
    pushl %edx    
    pushl $msg_main_scanf
    call scanf
    addl $8,%esp 

    movl $0,-8(%ebp)
    jmp  label_for_cond

label_for:
    pushl %eax
    pushl $msg_main_print2
    call printf
    addl $8,%esp
    
    addl $1,-8(%ebp)   # increment counter

label_for_cond:
    movl -8(%ebp),%eax
    movl -4(%ebp),%edx
    cmpl %edx,%eax
    jl label_for

    pushl $0
    call exit