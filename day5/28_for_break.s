.section .rodata
    msg_main_print1:
    .string "Enter number:\t"

    msg_main_scanf:
    .string "%d"

    msg_main_print2:
    .string "%d\n"


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

    movl $1,-8(%ebp)        # iCounter
    jmp  label_for_cond

label_for:
    xorl    %edx, %edx      # Zero-out edx to avoid garbage
    movl    $2, %ecx
    divl    %ecx
    
    cmpl    $0,%edx
    je     label_exit
    
    pushl  -8(%ebp)         # take counter value
    pushl $msg_main_print2
    call printf
    addl $8,%esp
    
    addl $1,-8(%ebp)   # increment counter

label_for_cond:
    movl -8(%ebp),%eax      # iCounter
    movl -4(%ebp),%edx      # iNo
    cmpl %edx,%eax          
    jl label_for            # iNo(eax) >= iCounter(edx)

label_exit:
    pushl $0
    call exit
    