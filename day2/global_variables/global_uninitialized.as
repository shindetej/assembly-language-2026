.section .rodata
    msg_main_print_before_scan:
    .string "Before scanning , g is %d\n"
    msg_main_print:
    .string "Enter number : \t"
    msg_main_scan:
    .string "%d\n"
    msg_main_print_after_scan:
    .string "After scanning , g is %d\n"

.section .bss
    .comm g, 4, 4   # common memory area varname,size,align
.section .text
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp,%ebp   # sp <==> bp

    movl    g,%eax
    pushl   %eax
    pushl   $msg_main_print_before_scan
    call    printf
    addl    $8,%esp

    pushl   $msg_main_print
    call    printf
    addl    $4,%esp

    movl    $g,%ebx     # address of g passed
    pushl   %ebx
    pushl   $msg_main_scan
    call    scanf
    addl    $8,%esp

    movl    g,%eax
    pushl   %eax
    pushl   $msg_main_print_after_scan
    call    printf
    addl    $8,%esp

    pushl $0
    call exit
