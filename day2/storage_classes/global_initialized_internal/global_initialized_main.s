.section .rodata
    msg_main_print:
    .string "In main(), Number is %d\n"

.section .data
    .type  g_iNo, @object
    .size  g_iNo, 4 
    .align 4
    g_iNo:
    .int 101     # int g = 101;

.section .text
.global main
.type	main, @function
main:
			pushl %ebp
			movl %esp, %ebp 			
			
           movl g_iNo, %eax      # eax = g_iNo
            pushl %eax            # second argument
            pushl $msg_main_print # first argument
            call printf
            addl $8, %esp

            call    fun

            pushl $0
			call exit
            