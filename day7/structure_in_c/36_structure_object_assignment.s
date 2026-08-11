.section .rodata
    msg_main_obj2_hdr:
    .string "Enter obj2 values,\n"

    msg_main_prompt_chChar:
    .string "Enter chChar\t:"

    msg_main_prompt_iNo:
    .string "Enter iNo\t:"

    msg_main_prompt_shiNo:
    .string "Enter shiNo\t:"

    msg_scan_chChar:
    .string "%c"

    msg_scan_iNo:
    .string "%d"

    msg_scan_shiNo:
    .string "%hd"

    msg_main_print_obj2:
    .string "obj2 is\n"

    msg_main_print_obj1:
    .string "\nobj1 is\n"

    msg_main_print_obj3:
    .string "obj3 is\n"

    msg_main_print_values:
    .string "chChar = %c, iNo = %d, shiNo = %hd\n"

.comm   obj1, 12, 4

.section .text
.globl  main
.type   main,@function
main:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $24, %esp        # -24/-20/-16(%ebp)=obj2, -12/-8/-4(%ebp)=obj3

    # -------- printf("Enter obj2 values,\n"); --------
    pushl   $msg_main_obj2_hdr
    call    printf
    addl    $4,%esp

    # -------- scanf("%c", &obj2.chChar); --------
    pushl   $msg_main_prompt_chChar
    call    printf
    addl    $4,%esp

    leal    -24(%ebp), %ebx
    pushl   %ebx                # &obj2.chChar
    pushl   $msg_scan_chChar
    call    scanf
    addl    $8,%esp

    # -------- scanf("%d", &obj2.iNo); --------
    pushl   $msg_main_prompt_iNo
    call    printf
    addl    $4,%esp

    leal    -20(%ebp), %ebx
    pushl   %ebx                # &obj2.iNo
    pushl   $msg_scan_iNo
    call    scanf
    addl    $8,%esp

    # -------- scanf("%hd", &obj2.shiNo); --------
    pushl   $msg_main_prompt_shiNo
    call    printf
    addl    $4,%esp

    leal    -16(%ebp), %ebx
    pushl   %ebx                # &obj2.shiNo
    pushl   $msg_scan_shiNo
    call    scanf
    addl    $8,%esp


    # -------- printf("obj2 is\n"); --------
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


    # ==================================================
    # obj1.chChar = obj2.chChar;
    # obj1.iNo    = obj2.iNo;
    # obj1.shiNo  = obj2.shiNo;
    # ==================================================
    movb    -24(%ebp), %al
    movb    %al, obj1            # obj1.chChar = obj2.chChar

    movl    -20(%ebp), %eax
    movl    %eax, obj1+4         # obj1.iNo = obj2.iNo

    movw    -16(%ebp), %ax
    movw    %ax, obj1+8          # obj1.shiNo = obj2.shiNo

    # ==================================================
    # obj3.chChar = obj2.chChar;
    # obj3.iNo    = obj2.iNo;
    # obj3.shiNo  = obj2.shiNo;
    # ==================================================
    movb    -24(%ebp), %al
    movb    %al, -12(%ebp)       # obj3.chChar = obj2.chChar

    movl    -20(%ebp), %eax
    movl    %eax, -8(%ebp)       # obj3.iNo = obj2.iNo

    movw    -16(%ebp), %ax
    movw    %ax, -4(%ebp)        # obj3.shiNo = obj2.shiNo


    # -------- printf("\nobj1 is\n"); --------
    pushl   $msg_main_print_obj1
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx
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

    # -------- printf("obj3 is\n"); --------
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


    pushl   $0
    call    exit