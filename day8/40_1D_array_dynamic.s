.section .rodata
    msg_main_print1:
    .string "Enter value of n:\t"

    msg_main_scanf:
    .string "%d"

    msg_main_fail:
    .string "Memory allocation FAILED"

    msg_main_print2:
    .string "Enter %d value:\t"

    msg_main_print3:
    .string "Entered elements are:\n"

    msg_main_print4:
    .string "%d value is:\t%d\n"

.section .text
.globl  main
.type   main, @function
main:
    pushl %ebp
    movl %esp, %ebp

    subl $12, %esp                    # -4(%ebp)=iMax, -8(%ebp)=iCounter, -12(%ebp)=pPtr

    movl $0, -12(%ebp)                 # pPtr = NULL

    pushl $msg_main_print1
    call printf
    addl $4, %esp

    leal -4(%ebp), %eax                 # eax = &iMax
    pushl %eax
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    # pPtr = (int *) malloc(iMax * sizeof(int));
    movl -4(%ebp), %eax                  # eax = iMax
    movl $4, %ecx                        # ecx = sizeof(int)
    mull %ecx                            # edx:eax = iMax * sizeof(int)
    pushl %eax                           # eax holds the result, edx (MSB) unused
    call malloc
    addl $4, %esp
    movl %eax, -12(%ebp)                 # pPtr = malloc(...)

    # if(NULL == pPtr)
    cmpl $0, -12(%ebp)
    je label_malloc_null

    # for(iCounter = 0; iCounter < iMax; iCounter++)
    movl $0, -8(%ebp)                     # iCounter = 0
    jmp label_for1_cond

label_for1:
    pushl -8(%ebp)                        # iCounter
    pushl $msg_main_print2
    call printf
    addl $8, %esp

    movl -12(%ebp), %ebx                   # ebx = pPtr (base address)
    movl -8(%ebp), %eax                    # eax = iCounter
    leal (%ebx,%eax,4), %edx               # edx = &pPtr[iCounter]
    pushl %edx
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    incl -8(%ebp)                          # iCounter++

label_for1_cond:
    movl -8(%ebp), %eax                     # iCounter
    movl -4(%ebp), %edx                     # iMax
    cmpl %edx, %eax
    jl label_for1                           # loop while iCounter < iMax

    pushl $msg_main_print3
    call printf
    addl $4, %esp

    # C: for(iCounter = 0; iCounter < iMax; iCounter++) 
    movl $0, -8(%ebp)                        # iCounter = 0
    jmp label_for2_cond

label_for2:
    movl -12(%ebp), %ebx                      # ebx = pPtr (base address)
    movl -8(%ebp), %eax                       # eax = iCounter
    movl (%ebx,%eax,4), %edx                  # edx = pPtr[iCounter]
    pushl %edx                                
    pushl -8(%ebp)
    pushl $msg_main_print4
    call printf
    addl $12, %esp

    incl -8(%ebp)                             # iCounter++

label_for2_cond:
    movl -8(%ebp), %eax                        # iCounter
    movl -4(%ebp), %edx                        # iMax
    cmpl %edx, %eax
    jl label_for2                              # loop while iCounter < iMax

    # free(pPtr); pPtr = NULL;
    pushl -12(%ebp)
    call free
    addl $4, %esp

    movl $0, -12(%ebp)                          # pPtr = NULL;

    pushl $0
    call exit

label_malloc_null:
    pushl $msg_main_fail
    call puts
    addl $4, %esp

    pushl $-1                            # exit(-1);
    call exit
