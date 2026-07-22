.section .rodata
    msg_fun_print1:
    .string "In fun, g_iNo is %d\n"
    msg_fun_print2:
    .string "In fun, Address of g_iNo is %d\n"

.section .bss
    .lcomm g_iNo,4

.section .text
.global fun
.type	fun, @function
fun:
			pushl %ebp
			movl %esp, %ebp 			
			
            
            movl 	g_iNo ,%eax
            pushl    %eax
            pushl 	$msg_fun_print1 
			call 	printf
			addl	$8, %esp

            # printf("In fun, Address of g_iNo is %d\n", &g_iNo);
            leal    g_iNo, %ebx
            pushl    %ebx
            pushl   $msg_fun_print2
            call 	printf
			addl	$8, %esp

            movl %ebp, %esp
            popl %ebp
            ret
            