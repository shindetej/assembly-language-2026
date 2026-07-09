.section .rodata
    msg_fun1_print1:
    .string  "Enter number : \t"
    msg_fun1_scan:
    .string  "%d"
    msg_fun1_print2:
    .string  "In fun1,iNo1 is %d & iNo2 is %d\n"
    msg_fun2_print:
    .string  "In static fun2"

.section .bss   
    .lcomm iNo1, 4

.section .data  
    .type iNo2 ,@object
    .size iNo2, 4
    .align 4
    iNo2:
    .int 40

.section .text
.globl  fun1
.type  fun1, @function
fun1:
        pushl %ebp
		movl %esp,%ebp				# Create stack frame
    
        pushl $msg_fun1_print1
        call printf
        addl $4,%esp    
        
        leal iNo1, %eax
        pushl %eax
        pushl $msg_fun1_scan
        call scanf
        addl $8,%esp

        movl iNo2,%edx      # register edx <== iNo2
        movl iNo1,%eax      # register eax <== iNo1
        pushl %edx
        pushl %eax
        pushl $msg_fun1_print2
        call printf
        addl $12,%esp   

        call fun2

        movl %ebp, %esp
		popl %ebp
		ret						


.type  fun2, @function
fun2:
    pushl %ebp
	movl %esp,%ebp				# Create stack frame
    
    pushl $msg_fun2_print
    call printf
    addl $4,%esp

    movl %ebp, %esp
	popl %ebp
	ret			