.section .rodata    
    msg_main_print1:
    .string "Enter operand 1: \t"
    msg_main_print2:
    .string "Enter operand 2: \t"
    msg_main_scan:
	.string "%u"
    msg_main_print3:
    .string "Quotient is : %u"
    msg_main_print4:
    .string "Reminder is : %u"

.section .text
.globl   main
.type    main,@function
main:
    pushl %ebp
    movl  %esp,%ebp

    subl   $16,%esp

	pushl  $msg_main_print1
	call 	printf
	addl 	$4, %esp

	leal	-4(%ebp), %ebx
	pushl   %ebx
	pushl   $msg_main_scan
	call	scanf
	addl	$8, %esp

    pushl   $msg_main_print2
	call 	printf
	addl 	$4, %esp

	leal	-8(%ebp), %ebx
	pushl   %ebx
	pushl   $msg_main_scan
	call	scanf
	addl	$8, %esp

    movl    -4(%ebp), %eax
    xorl    %edx, %edx      # Zero-out edx to avoid garbage
    movl    -8(%ebp), %ecx
    divl    %ecx

    movl    %eax,-12(%ebp)  # store quotient
    movl    %edx,-16(%ebp)  # store reminder

    pushl   -12(%ebp)
    pushl   $msg_main_print3
    call    printf
    addl    $8, %esp

    pushl   -16(%ebp)
    pushl   $sg_main_print4
    call    printf
    addl    $8, %esp
    pushl $0
    call  exit