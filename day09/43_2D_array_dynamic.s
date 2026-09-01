.section .rodata
    msg_main_print1:
    .string "Enter value of rows & columns:\t"

    msg_main_scanf2:
    .string "%d%d"

    msg_main_scanf1:
    .string "%d"

    msg_main_fail:
    .string "Memory allocation FAILED"

    msg_main_print2:
    .string "Enter [%d][%d] value:\t"

    msg_main_print3:
    .string "Entered elements are:\n"

    msg_main_print4:
    .string "[%d][%d] value is:\t%d\n"

.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $20, %esp                     # -4=iRows -8=iColumns -12=iCounter1 -16=iCounter2 -20=ppPtr

    movl $0, -20(%ebp)                 # ppPtr = NULL

    # printf("Enter value of rows & columns:\t");
    pushl $msg_main_print1
    call printf
    addl $4, %esp

    # scanf("%d%d", &iRows, &iColumns);
    leal -8(%ebp), %edx                # &iColumns
    leal -4(%ebp), %eax                # &iRows
    pushl %edx
    pushl %eax
    pushl $msg_main_scanf2
    call scanf
    addl $12, %esp

    # ppPtr = (int **) malloc(iRows * sizeof(int *));
    movl -4(%ebp), %eax                # iRows
    movl $4, %ecx                      # sizeof(int *)
    mull %ecx                          # eax = iRows * 4
    pushl %eax
    call malloc
    addl $4, %esp
    movl %eax, -20(%ebp)               # ppPtr = malloc(...)

    # if(NULL == ppPtr)
    cmpl $0, -20(%ebp)
    je label_malloc_null

    # for(iCounter1 = 0; iCounter1 < iRows; iCounter1++)
    movl $0, -12(%ebp)                 # iCounter1 = 0
    jmp label_for1_cond

label_for1:
    # ppPtr[iCounter1] = (int *) malloc(iColumns * sizeof(int));
    movl -8(%ebp), %eax               # iColumns
    movl $4, %ecx                      # sizeof(int)
    mull %ecx                          # eax = iColumns * 4
    pushl %eax
    call malloc
    addl $4, %esp

    movl -20(%ebp), %edx               # edx = ppPtr
    movl -12(%ebp), %ecx               # ecx = iCounter1
    movl %eax, (%edx,%ecx,4)           # ppPtr[iCounter1] = malloc(...)

    # if(NULL == ppPtr[iCounter1])
    cmpl $0, %eax
    je label_row_null

    # for(iCounter2 = 0; iCounter2 < iColumns; iCounter2++)
    movl $0, -16(%ebp)                 # iCounter2 = 0
    jmp label_for2_cond

label_for2:
    # printf("Enter [%d][%d] value:\t", iCounter1, iCounter2);
    pushl -16(%ebp)                    # iCounter2
    pushl -12(%ebp)                    # iCounter1
    pushl $msg_main_print2
    call printf
    addl $12, %esp

    # scanf("%d", &ppPtr[iCounter1][iCounter2]);
    movl -20(%ebp), %eax              # ppPtr
    movl -12(%ebp), %edx              # iCounter1
    movl (%eax,%edx,4), %eax          # eax = ppPtr[iCounter1]  (row base)
    movl -16(%ebp), %edx             # iCounter2
    leal (%eax,%edx,4), %eax          # &ppPtr[iCounter1][iCounter2]
    pushl %eax
    pushl $msg_main_scanf1
    call scanf
    addl $8, %esp

    incl -16(%ebp)                     # iCounter2++

label_for2_cond:
    movl -16(%ebp), %eax
    movl -8(%ebp), %edx
    cmpl %edx, %eax
    jl label_for2                      # iCounter2 < iColumns

    incl -12(%ebp)                     # iCounter1++

label_for1_cond:
    movl -12(%ebp), %eax
    movl -4(%ebp), %edx
    cmpl %edx, %eax
    jl label_for1                      # iCounter1 < iRows

    # printf("Entered elements are:\n");
    pushl $msg_main_print3
    call printf
    addl $4, %esp

    # for(iCounter1 = 0; iCounter1 < iRows; iCounter1++)
    movl $0, -12(%ebp)
    jmp label_for3_cond

label_for3:
    #   for(iCounter2 = 0; iCounter2 < iColumns; iCounter2++)
    movl $0, -16(%ebp)
    jmp label_for4_cond

label_for4:
    # printf("[%d][%d] value is:\t%d\n", iCounter1, iCounter2, ppPtr[iCounter1][iCounter2]);
    movl -20(%ebp), %eax
    movl -12(%ebp), %edx
    movl (%eax,%edx,4), %eax          # row base = ppPtr[iCounter1]
    movl -16(%ebp), %edx
    movl (%eax,%edx,4), %eax          # ppPtr[iCounter1][iCounter2]
    pushl %eax
    pushl -16(%ebp)
    pushl -12(%ebp)
    pushl $msg_main_print4
    call printf
    addl $16, %esp

    incl -16(%ebp)

label_for4_cond:
    movl -16(%ebp), %eax
    movl -8(%ebp), %edx
    cmpl %edx, %eax
    jl label_for4

    incl -12(%ebp)

label_for3_cond:
    movl -12(%ebp), %eax
    movl -4(%ebp), %edx
    cmpl %edx, %eax
    jl label_for3

    # for(iCounter1 = 0; iCounter1 < iRows; iCounter1++) { free(ppPtr[iCounter1]); ppPtr[iCounter1] = NULL; }
    movl $0, -12(%ebp)
    jmp label_for5_cond

label_for5:
    movl -20(%ebp), %eax
    movl -12(%ebp), %edx
    movl (%eax,%edx,4), %eax          # ppPtr[iCounter1]
    pushl %eax
    call free
    addl $4, %esp

    movl -20(%ebp), %eax
    movl -12(%ebp), %edx
    movl $0, (%eax,%edx,4)            # ppPtr[iCounter1] = NULL

    incl -12(%ebp)

label_for5_cond:
    movl -12(%ebp), %eax
    movl -4(%ebp), %edx
    cmpl %edx, %eax
    jl label_for5

    # free(ppPtr); ppPtr = NULL;
    pushl -20(%ebp)
    call free
    addl $4, %esp
    movl $0, -20(%ebp)

    # exit(0);
    pushl $0
    call exit

label_row_null:
    # puts("Memory allocation FAILED"); ppPtr = NULL; return -1;
    pushl $msg_main_fail
    call puts
    addl $4, %esp
    movl $0, -20(%ebp)                 # ppPtr = NULL
    pushl $-1
    call exit

label_malloc_null:
    # puts("Memory allocation FAILED"); return -1;
    pushl $msg_main_fail
    call puts
    addl $4, %esp
    pushl $-1
    call exit
