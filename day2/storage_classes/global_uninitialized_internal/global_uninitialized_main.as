.section .rodata
    msg_main_print1:
    .string "In main, g_iNo is %d\n"
    msg_main_print2:
    .string "In main, Address of g_iNo is %d\n"

.section .bss
    .comm g_iNo,4,4
    
.section .text
.global main
.type	main, @function
main:
			pushl %ebp
			movl %esp, %ebp 			
			
            movl 	g_iNo ,%eax
            pushl    %eax
            pushl $msg_main_print1
            call printf
            addl $8,%esp

            leal g_iNo,%ebx
            pushl %ebx
            pushl $msg_main_print2
            call printf
            addl $8,%esp

            call    fun

            pushl $0
			call exit
            