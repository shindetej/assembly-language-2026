.section .rodata
    msg_main_print1:
    .string "Enter number : \t"

    msg_main_scanf:
    .string "%d"

    msg_main_print2:
    .string "Number is less than 2\n"

    msg_main_print3:
    .string "Number is greater than 2\n"

    msg_main_print4:
    .string "Number is 2\n"

.section .text
.globl  main
.type   main,@function
main:
    pushl   %ebp
    movl    %esp,%ebp

    subl    $4,%esp

    pushl   $msg_main_print1
    call    printf
    addl    $4,%esp

    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_scanf
    call    scanf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    cmpl    $2, %eax
    jnl     label_not_less
    pushl   $msg_main_print2
    call    printf
    addl    $4,%esp
    jmp     label_exit

label_not_less:
   # cmpl    $2,%eax
    jng      label_equal
    pushl   $msg_main_print3
    call    printf
    addl    $4,%esp
    jmp     label_exit

label_equal:
    pushl   $msg_main_print4
    call    printf
    addl    $4,%esp
  #  jmp     label_exit

label_exit:
    movl    $0,%eax
    call    exit
    
