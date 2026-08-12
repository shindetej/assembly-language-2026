.section .rodata
    msg_main_print_obj1:
    .string "obj1 is\n"

    msg_main_print_obj2:
    .string "obj2 is\n"

    msg_main_print_obj3:
    .string "obj3 is\n"

    msg_main_print_values:
    .string "chChar = %c, iNo = %d, shiNo = %hd\n\n"

    msg_main_cmp12:
    .string "obj1 & obj2 comparison is "

    msg_main_cmp23:
    .string "obj2 & obj3 comparison is "

    msg_equal:
    .string "equal\n"

    msg_not_equal:
    .string "not equal\n"

.section .data
    .globl obj1
    .type  obj1, @object
    .size  obj1, 12
    .align 4
    obj1:
        .byte  'A'
        .zero  3
        .int   10
        .value 20
        .zero  2

.section .text
.globl  main
.type   main,@function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $24, %esp        # obj2  -24 to -16,obj3 -12 to -4(%ebp)

    movb    $'B', -24(%ebp)  # obj2.chChar
    movl    $30,  -20(%ebp)  # obj2.iNo
    movw    $40,  -16(%ebp)  # obj2.shiNo

    movb    $'B', -12(%ebp)  # obj3.chChar
    movl    $30,   -8(%ebp)  # obj3.iNo
    movw    $40,   -4(%ebp)  # obj3.shiNo

    pushl   $msg_main_print_obj1
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx
    xorl    %eax,%eax       # zero out before loading data to al
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx       # zero out before loading data to cx
    movw    8(%ebx),%cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_values
    call    printf
    addl    $16,%esp

    pushl   $msg_main_print_obj2
    call    printf
    addl    $4,%esp

    leal    -24(%ebp), %ebx
    xorl    %eax,%eax
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx
    movw    8(%ebx),%cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_values
    call    printf
    addl    $16,%esp

    pushl   $msg_main_print_obj3
    call    printf
    addl    $4,%esp

    leal    -12(%ebp), %ebx
    xorl    %eax,%eax
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx
    movw    8(%ebx),%cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_values
    call    printf
    addl    $16,%esp


    # ==================================================
    # if(obj1.chChar==obj2.chChar && obj1.iNo==obj2.iNo
    #    && obj1.shiNo==obj2.shiNo)
    # ==================================================
    pushl   $msg_main_cmp12
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx         # %ebx = &obj1 
    movb    (%ebx), %al        # obj1.chChar
    movb    -24(%ebp), %dl     # obj2.chChar
    cmpb    %dl, %al
    jne     label_cmp12_not_equal

    movl    4(%ebx), %eax      # obj1.iNo
    movl    -20(%ebp), %edx    # obj2.iNo
    cmpl    %edx, %eax
    jne     label_cmp12_not_equal

    movw    8(%ebx), %ax       # obj1.shiNo
    movw    -16(%ebp), %dx     # obj2.shiNo
    cmpw    %dx, %ax
    jne     label_cmp12_not_equal

    pushl   $msg_equal
    call    printf
    addl    $4,%esp
    jmp     label_cmp12_done

label_cmp12_not_equal:
    pushl   $msg_not_equal
    call    printf
    addl    $4,%esp

label_cmp12_done:
    # ==================================================
    # if(obj3.chChar==obj2.chChar && obj3.iNo==obj2.iNo
    #    && obj3.shiNo==obj2.shiNo)
    # ==================================================
    pushl   $msg_main_cmp23
    call    printf
    addl    $4,%esp

    movb    -12(%ebp), %al     # obj3.chChar
    movb    -24(%ebp), %bl     # obj2.chChar
    cmpb    %bl, %al
    jne     label_cmp23_not_equal

    movl    -8(%ebp), %eax     # obj3.iNo
    movl    -20(%ebp), %edx    # obj2.iNo
    cmpl    %edx, %eax
    jne     label_cmp23_not_equal

    movw    -4(%ebp), %ax      # obj3.shiNo
    movw    -16(%ebp), %dx     # obj2.shiNo
    cmpw    %dx, %ax
    jne     label_cmp23_not_equal

    pushl   $msg_equal
    call    printf
    addl    $4,%esp
    jmp     label_cmp23_done

label_cmp23_not_equal:
    pushl   $msg_not_equal
    call    printf
    addl    $4,%esp

label_cmp23_done:
    pushl   $0
    call    exit

    