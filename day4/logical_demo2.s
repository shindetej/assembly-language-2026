

# iAns = iNo1 && ++iNo2 || ++iNo3

    movl -4(%ebp) , %eax
    cmpl    $0, %eax
    je      label_first_and_result
    addl    $1, -8(%ebp)
    movl    -8(%ebp), %eax
    cmpl    $0, %eax
    je      label_and_result  
    movl    $1, %eax

label_and_result:
    cmpl    $0, %eax
    jne      label_or_result 
    addl    $1, -12(%ebp)
    movl    -12(%ebp), %eax
    cmpl    $0, %eax
    je      label_second_and_result
    movl    $1, %eax

label_or_result:
    movl    %eax, -16(%ebp)

    movl    -4(%ebp),%edx
    movl    -8(%ebp),%ecx
    movl    -12(%ebp),%edx
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   msg_print2
    call    printf
    addl    $20, %esp