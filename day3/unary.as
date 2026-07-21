.section .rodata
    msg_main_print:
    .string "%d\n"

.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $4, %esp
    pushl   $-100
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    movl    -4(%ebp), %eax
    pushl   %eax
    pushl   $msg_main_print
    call    printf
    addl    $8 , %esp
    
    movl    -4(%ebp), %eax
    # movl    $0, %edx
    # subl    %eax,   %edx
    # movl    %edx,   %eax
    negl      %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp
    
    
    movl    -4(%ebp), %eax
    pushl    %eax
    pushl   $msg_main_print
    call    printf
    addl    $8, %esp

    pushl   $0
    call    exit
