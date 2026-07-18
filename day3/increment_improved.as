.section .rodata
    msg_main_print:
    .string "iNo1 = %d\niNo2 = %d\niAns1= %d \niAns2 = %d\n"

.section .text
.globl   main
.type    main, @function
main:
    pushl   %ebp
    movl    %esp , %ebp     # Create stack frame
    
    subl    $16,%esp        # 4 local variables sathi jaga

    movl    $10, -4(%ebp)   # add 10 to iNo1
    movl    $20, -8(%ebp)   # add 20 to iNo2

    addl    $1, -4(%ebp)    # PRE INCREMENT ++iNo1
    movl    -4(%ebp),%eax
    movl    %eax,-12(%ebp)

    movl    -8(%ebp), %edx
    movl    %edx, -16(%ebp)  # POST INCREMENT iAns2 = iNo2++
    addl    $1, -8(%ebp)   

    movl    -8(%ebp),%ecx   # value catched for iAns2 in ecx not edx now
    pushl   %edx            # iAns2
    pushl   %eax            # iAns1
    pushl   %ecx            # iNo2 : captured post increment
    pushl   %eax            # iNo1
    pushl   $msg_main_print
    call    printf
    addl    $20, %esp

    pushl   $0
    call    exit
    