.section .rodata
    msg_main_print1:
    .string "Enter two numbers:\t"
    
    msg_main_scan:
    .string "%d%d"
    
    msg_main_print2:
    .string "Sum is %d\n"
    
    msg_main_print3:
    .string "Difference is %d\n"

.section .text
.globl main
.type	main, @function
main:
    pushl %ebp
    movl %esp, %ebp 			
    
    subl $16,%esp  				
    pushl $msg_main_print1
    call printf
    addl $4,%esp
    
    leal -4(%ebp), %eax			# eax = &iNo1
    leal -8(%ebp), %edx			# edx = &iNo2
    pushl %edx
    pushl %eax
    pushl $msg_main_scan
    call scanf
    addl $12,%esp
    
    # SumDiff(iNo1, iNo2, &iSum, &iDiff);
    leal -16(%ebp), %eax			# eax = &iDiff
    leal -12(%ebp), %edx			# edx = &iSum
    pushl %eax						# push &iDiff (4th arg, pushed first)
    pushl %edx						# push &iSum  (3rd arg)
    movl -8(%ebp),%eax				# eax = iNo2
    pushl %eax						# push iNo2   (2nd arg)
    movl -4(%ebp),%eax				# eax = iNo1
    pushl %eax						# push iNo1   (1st arg, pushed last)
    call SumDiff
    addl $16,%esp					# clean up 4 arguments (4 x 4 bytes)
    
    pushl -12(%ebp)					# push iSum
    pushl $msg_main_print2
    call printf
    addl $8,%esp
    
    pushl -16(%ebp)					# push iDiff
    pushl $msg_main_print3
    call printf
    addl $8,%esp
    
    pushl $0
    call exit


.section .text
.globl  SumDiff
.type   SumDiff,@function
SumDiff:
    pushl   %ebp
    movl    %esp,%ebp

    movl 8(%ebp),%eax
    movl 12(%ebp),%edx
    addl %edx,%eax
    movl 16(%ebp),%ebx
    movl %eax,(%ebx)     # *piSum = eax 

    movl 8(%ebp),%eax
    movl 12(%ebp),%edx
    subl %edx,%eax
    movl 20(%ebp),%ebx
    movl %eax,(%ebx)     # *piDiff = eax 

	movl %ebp, %esp
    popl    %ebp
    ret



    