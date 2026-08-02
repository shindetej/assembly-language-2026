.section .rodata
    msg_main_print1:
    .string "g = %d\n"
    msg_main_print2:
    .string "&g = %d\n"

.section .data
    .type  g, @object
    .size  g, 4 
    .align 4
    g:
    .int 10     # int g = 10;
.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp,%ebp   # sp <==> bp

    movl    g,%eax
    pushl   %eax
    pushl   $msg_main_print1
    call    printf
    addl    $8,%esp

    leal    g,%ebx      # OR ALTERNATIVE movl $g, %ebx
    pushl   %ebx        
    pushl   $msg_main_print2
    call    printf
    addl    $8,%esp
    pushl $0
    call exit
