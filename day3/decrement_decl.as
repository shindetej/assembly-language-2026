.section .rodata
msg_main_print:
    .string "Decrement result : iNo1 = %d\niNo2 = %d\niAns1 = %d\niAns2 = %d\n"

.section .text
.globl main
.type main,@function
main:
    pushl %ebp
    movl %esp,%ebp

    subl $16,%esp               # iNo1,iNo2,iAns1,iAns2
    movl $10,-4(%ebp)           # iNo1 = 10;   
    movl $20,-8(%ebp)           # iNo2 = 20;

    # post decrement
    movl -4(%ebp),%eax
    movl %eax,-12(%ebp)
    decl -4(%ebp)            # --iNo1
    movl -4(%ebp),%ecx

    # pre decrement
    decl -8(%ebp)
    movl -8(%ebp),%edx
    movl %edx,-16(%ebp)


    pushl %edx        # iAns2
    pushl %eax        # iAns1
    pushl %edx        # iNo2
    pushl %ecx        # iNo1
    pushl $msg_main_print
    call printf
    addl $20,%esp

    pushl $0
    call exit


    