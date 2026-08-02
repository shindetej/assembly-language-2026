.section .rodata
    msg_main_print1:
    .string "Enter Your Choice:\n1. Addition\n2. Subraction\n3. Multiplication\n4. Division\n"

    msg_main_scanf:
    .string "%d"

    msg_main_print2:
    .string "Addition"

    msg_main_print3:
    .string "Subtraction"

    msg_main_print4:
    .string "Multiplication"

    msg_main_print5:
    .string "Division"

    msg_main_default:
    .string "Invalid choice"
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

    cmpl    $1, %eax
    je      label_case_addition
    cmpl    $2, %eax
    je      label_case_subtraction
    cmpl    $3, %eax
    je      label_case_multiplication
    cmpl    $4, %eax
    je      label_case_division
    jmp     label_case_default

label_case_addition:
    pushl   $msg_main_print2
    call    printf
    addl    $4, %esp

label_case_subtraction:
    pushl   $msg_main_print3
    call    printf
    addl    $4, %esp

label_case_multiplication:
    pushl   $msg_main_print4
    call    printf
    addl    $4, %esp

label_case_division:
    pushl   $msg_main_print5
    call    printf
    addl    $4, %esp

label_case_default:
    pushl   $msg_main_default
    call    printf
    addl    $4, %esp

label_exit:
    pushl   $0
    call    exit