.equ MAX, 10                        

.section .rodata
    msg_main_print1:
    .string "Enter value of n(< %d):\t"

    msg_main_scanf:
    .string "%d"

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

    subl $48, %esp                   # locations -4(%ebp)=iMax, -8(%ebp)=iCounter, -48(%ebp)=arr[0 to MAX-1]

    pushl $MAX
    pushl $msg_main_print1
    call printf
    addl $8, %esp

    leal -4(%ebp), %eax               # eax = &iMax
    pushl %eax
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    # for(iCounter = 0; iCounter < iMax; iCounter++) 
    movl $0, -8(%ebp)                  # iCounter = 0
    jmp label_for1_cond

label_for1:
    pushl -8(%ebp)                     # iCounter
    pushl $msg_main_print2
    call printf
    addl $8, %esp

    movl -8(%ebp), %eax                 # eax = iCounter
    leal -48(%ebp,%eax,4), %edx         # edx = &arr[iCounter]
    pushl %edx
    pushl $msg_main_scanf
    call scanf
    addl $8, %esp

    incl -8(%ebp)                       # iCounter++

label_for1_cond:
    movl -8(%ebp), %eax                  # iCounter
    movl -4(%ebp), %edx                  # iMax
    cmpl %edx, %eax
    jl label_for1                        # loop while iCounter < iMax

    pushl $msg_main_print3
    call printf
    addl $4, %esp

    # for(iCounter = 0; iCounter < iMax; iCounter++) 
    movl $0, -8(%ebp)                     # iCounter = 0
    jmp label_for2_cond

label_for2:
    movl -8(%ebp), %eax                    # eax = iCounter
    movl -48(%ebp,%eax,4), %edx            # edx = arr[iCounter]
    pushl %edx                             # push last parameter first
    pushl -8(%ebp)
    pushl $msg_main_print4
    call printf
    addl $12, %esp

    incl -8(%ebp)                          # iCounter++

label_for2_cond:
    movl -8(%ebp), %eax                     # iCounter
    movl -4(%ebp), %edx                     # iMax
    cmpl %edx, %eax
    jl label_for2                           # loop while iCounter < iMax

    pushl $0
    call exit
