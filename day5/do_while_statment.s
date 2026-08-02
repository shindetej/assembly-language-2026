.section .rodata
    msg_main_print1:
    .string "Enter number : \t"

    msg_main_scanf:
    .string "%d"

    msg_main_print2:
    .string "Printing number : %d\n"


.section .text
.globl  main
.type   main,@function
main:
    pushl %ebp
    movl %esp,%ebp

    subl $8, %esp      # iNo and iCounter

    pushl $msg_main_print1
    call printf
    addl $4,%esp
 		
    leal -4(%ebp), %edx     # SCANNING   		
    pushl %edx    
    pushl $msg_main_scanf
    call scanf
    addl $8,%esp 

    movl $0,-8(%ebp)
    movl -8(%ebp),%eax      

label_do_while:             # DO STATEMENT 
    pushl %eax
    pushl $msg_main_print2
    call printf
    addl $8,%esp
    
    addl $1,-8(%ebp)        # MANIPULATION

label_condition:            # CONDITION
    movl -8(%ebp),%eax      # remove this and see output
    movl -4(%ebp),%edx
    cmpl %edx,%eax
    jl label_do_while

    pushl $0
    call exit