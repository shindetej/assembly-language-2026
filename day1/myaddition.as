.section .rodata
			msg_main_println1:
			.string "Enter two numbers : \t"
			
			msg_main_scan:
			.string "%d%d"
			
			msg_main_print2:
			.string "Answer is %d\n"
			
.section .text
.global main
.type	main, @function
main:
			pushl %ebp
			movl %esp, %ebp 			# C: create stack frame for main()
			
			subl $12,%esp  				# reserve 12 bytes: SP grows downwards for local variables in main
			
			pushl 	$msg_main_println1 ## argument for line printf()
			call 	 	printf
			addl		$4, %esp 		# stack moved by 4 downwards
			
			leal -4(%ebp), %eax 		# eax = &no1
			leal -8(%ebp), %edx   		# edx = &no2
			pushl %edx  # pushed argument no2 
			pushl %eax  # pushed argument no1 on stack
			pushl $msg_main_scan
			call scanf
			addl $12,%esp 				# Remove scanf arguments
			
			movl -4(%ebp),%eax			# eax = no1
			movl -8(%ebp),%edx			# edx = no2
			push %edx					# Push second argument (num2)
			pushl %eax					# Push first argument (num1)
			call addition
			addl $8,%esp				# Remove function arguments
			movl %eax,-12(%ebp)			# ans = return value
			
			pushl %eax					# Push ans
			pushl $msg_main_print2
			call printf
			addl $8,%esp
			
			pushl $0
			call exit
			
.global 	addition
.type 	addition, @function
addition:
			pushl %ebp
			movl %esp,%ebp				# Create stack frame
			
			subl 	$4,%esp				# Reserve 4 bytes: for int sum
			
			movl 8(%ebp), %eax			# eax = num1
			movl 12(%ebp), %edx			# edx = num2
			addl %edx, %eax				# eax = num1 + num2
			movl  %eax,-4(%ebp)			# return value in eax
			
			movl %ebp, %esp
			popl %ebp
			ret							# return sum;
	
			
			
			