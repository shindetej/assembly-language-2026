.section .rodata    
    msg_main_print1:
    .string "Enter two numbers : \t"

    msg_main_scanf:
    .string "%d%d"

    msg_main_print2:
    .string "In main(), %d %d %d \n"

.section .data
    .globl iNo1
    .type  iNo1, @object
    .size  iNo1, 4
    .align 4
    iNo1:
    .int 10

.section .bss   
    .comm iNo2 ,4,4

.section .text
.globl   main
.type    main, @function
main:
        pushl %ebp
        movl  %esp,%ebp     # stack frame
        
        subl $4,%esp

        pushl $msg_main_print1
        call printf
        addl $4,%esp

        leal iNo2 , %eax
        leal -4(%ebp),%edx
        pushl %edx
        pushl %eax
        pushl $msg_main_scanf
        call scanf
        addl $12,%esp 
        
        movl -4(%ebp), %edx  # edx = iNo3
        pushl %edx
        movl iNo2, %eax         # eax = iNo2
        pushl %eax
        movl iNo1, %eax          # eax = iNo1
        pushl %eax
        pushl $msg_main_print2
        call printf
        addl $16,%esp

        call fun1

        # exit(0)
        pushl $0
        call exit

