.section  .rodata
    msg_main_print_obj1:
    .string "obj1 is :\n"

    msg_main_print_obj2:
    .string "obj2 is :\n"

    msg_main_print_obj1_values:
    .string "chChar =%c ,iNo=%d,shiNo= %hd\n"
    
    msg_main_print_obj2_values:
    .string "chChar =%c ,iNo=%d,shiNo= %hd\n"

.section .data
    .globl obj1
    .type  obj1, @object
    .size  obj1, 12
    .align 4
    obj1:
        .ascii "A"
        .zero   3
        .int    10
        .value   20
.section .text
.globl  main
.type   main,@function
main:
    push    %ebp
    movl    %esp ,%ebp

    subl    $12, %esp

    movb    $'B',-12(%ebp)
    movl    $30,-8(%ebp)
    movw    $40,-4(%ebp)

    pushl   $msg_main_print_obj1
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx      # address of obj1 to ebx register
    xorl    %eax,%eax       # zero out to handle garbage values
    movb    (%ebx),%al      # from ebx to 1 byte
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx       # zero out to handle garbage values
    movw    8(%ebx),%cx     # from ebx + 8 to two byte
    pushl   %ecx    # push last parameter in print statement 1st
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj1_values
    call    printf
    addl    $16,%esp

    pushl   $msg_main_print_obj2
    call    printf
    addl    $4,%esp


    leal    -12(%ebp), %ebx 
    xorl    %eax,%eax       # zero out to handle garbage values
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx       # zero out to handle garbage values
    movw    8(%ebx),%cx
    pushl   %ecx            # push last parameter first
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj2_values
    call    printf
    addl    $16,%esp


    pushl   $0
    call    exit
