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

    subl    $24, %esp        # obj2 -24 to -16 and then obj 3

    pushl   $msg_main_obj2_hdr
    call    printf
    addl    $4,%esp

    pushl   $msg_main_prompt_chChar
    call    printf
    addl    $4,%esp

    leal    -24(%ebp), %ebx
    pushl   %ebx                # &obj2.chChar
    pushl   $msg_scan_chChar
    call    scanf
    addl    $8,%esp

    pushl   $msg_main_prompt_iNo
    call    printf
    addl    $4,%esp

    leal    -20(%ebp), %ebx
    pushl   %ebx                # &obj2.iNo
    pushl   $msg_scan_iNo
    call    scanf
    addl    $8,%esp

    pushl   $msg_main_prompt_shiNo
    call    printf
    addl    $4,%esp

    leal    -16(%ebp), %ebx
    pushl   %ebx                # &obj2.shiNo
    pushl   $msg_scan_shiNo
    call    scanf
    addl    $8,%esp

    # ---- scanning completed for all obj2 members -----

    pushl   $msg_main_print_obj2
    call    printf
    addl    $4,%esp

    # ----  printed all values of obj 2 -----
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


    # ---- smart copy: obj1 = obj2 (whole struct, dword-at-a-time) ----
    leal    -24(%ebp), %ebx      # %ebx = &obj2 (source)
    leal    obj1, %edx           # %edx = &obj1 (destination)
    movl    (%ebx), %eax
    movl    %eax, (%edx)         # dword 0 : chChar + padding
    movl    4(%ebx), %eax
    movl    %eax, 4(%edx)        # dword 1 : iNo
    movl    8(%ebx), %eax
    movl    %eax, 8(%edx)        # dword 2 : shiNo + padding


    leal    -24(%ebp), %ebx      # %ebx = &obj2 (source)
    leal    -12(%ebp), %edx      # %edx = &obj3 (destination)
    movl    (%ebx), %eax
    movl    %eax, (%edx)         # dword 0 : chChar + padding
    movl    4(%ebx), %eax
    movl    %eax, 4(%edx)        # dword 1 : iNo
    movl    8(%ebx), %eax
    movl    %eax, 8(%edx)        # dword 2 : shiNo + padding


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
