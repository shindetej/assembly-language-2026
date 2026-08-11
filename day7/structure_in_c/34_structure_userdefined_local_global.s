.section  .rodata
    msg_main_obj1_hdr:
    .string "Enter obj1 values,\n"

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

    msg_scan_c_chChar:
    .string "%c%c"

    msg_scan_c_iNo:
    .string "%c%d"

    msg_scan_c_shiNo:
    .string "%c%hd"

    msg_main_print_obj1:
    .string "obj1 is\n"

    msg_main_print_obj2:
    .string "obj2 is\n"

    msg_main_print_obj1_values:
    .string "chChar = %c, iNo = %d, shiNo = %hd\n\n"

    msg_main_print_obj2_values:
    .string "chChar = %c, iNo = %d, shiNo = %hd\n"

.section .bss
    .comm   obj1, 12, 4

.section .text
.globl  main
.type   main,@function
main:
    push    %ebp
    movl    %esp ,%ebp

    subl    $16, %esp          # -16(%ebp)=t, -12/-8/-4(%ebp)=obj2

    # -------- printf("Enter obj1 values,\n"); --------
    pushl   $msg_main_obj1_hdr
    call    printf
    addl    $4,%esp

    # -------- scanf("%c", &obj1.chChar); --------
    pushl   $msg_main_prompt_chChar
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx
    pushl   %ebx                # take obj1 address and scan
    pushl   $msg_scan_chChar
    call    scanf
    addl    $8,%esp

    # -------- scanf("%d", &obj1.iNo); --------
    pushl   $msg_main_prompt_iNo
    call    printf
    addl    $4,%esp

    leal    4(%ebx), %ebx
    pushl   %ebx                # take obj1+4
    pushl   $msg_scan_iNo
    call    scanf
    addl    $8,%esp

    # -------- scanf("%hd", &obj1.shiNo); --------
    pushl   $msg_main_prompt_shiNo
    call    printf
    addl    $4,%esp

    leal    4(%ebx), %ebx        # take obj1+4 to  obj1+8
    pushl   %ebx                # take obj1+8 and scan
    pushl   $msg_scan_shiNo
    call    scanf
    addl    $8,%esp


    # -------- printf("Enter obj2 values,\n"); --------
    pushl   $msg_main_obj2_hdr
    call    printf
    addl    $4,%esp

    # -------- scanf("%c%c", &t, &obj2.chChar); --------
    pushl   $msg_main_prompt_chChar
    call    printf
    addl    $4,%esp

    leal    -12(%ebp), %ebx      # &obj2.chChar
    leal    -16(%ebp), %ecx      # &t
    pushl   %ebx
    pushl   %ecx
    pushl   $msg_scan_c_chChar
    call    scanf
    addl    $12,%esp

    # -------- scanf("%c%d", &t, &obj2.iNo); --------
    pushl   $msg_main_prompt_iNo
    call    printf
    addl    $4,%esp

    leal    -8(%ebp), %ebx       # &obj2.iNo
    leal    -16(%ebp), %ecx      # &t
    pushl   %ebx
    pushl   %ecx
    pushl   $msg_scan_c_iNo
    call    scanf
    addl    $12,%esp

    # -------- scanf("%c%hd", &t, &obj2.shiNo); --------
    pushl   $msg_main_prompt_shiNo
    call    printf
    addl    $4,%esp

    leal    -4(%ebp), %ebx       # &obj2.shiNo
    leal    -16(%ebp), %ecx      # &t
    pushl   %ebx
    pushl   %ecx
    pushl   $msg_scan_c_shiNo
    call    scanf
    addl    $12,%esp


    # -------- printf("obj1 is\n"); --------
    pushl   $msg_main_print_obj1
    call    printf
    addl    $4,%esp

    leal    obj1, %ebx
    xorl    %eax,%eax           # zero out to handle garbage values
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx           # zero out to handle garbage values
    movw    8(%ebx),%cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj1_values
    call    printf
    addl    $16,%esp

    # -------- printf("obj2 is\n"); --------
    pushl   $msg_main_print_obj2
    call    printf
    addl    $4,%esp

    leal    -12(%ebp), %ebx
    xorl    %eax,%eax           # zero out to handle garbage values
    movb    (%ebx),%al
    movl    4(%ebx),%edx
    xorl    %ecx,%ecx           # zero out to handle garbage values
    movw    8(%ebx),%cx
    pushl   %ecx
    pushl   %edx
    pushl   %eax
    pushl   $msg_main_print_obj2_values
    call    printf
    addl    $16,%esp


    pushl   $0
    call    exit

