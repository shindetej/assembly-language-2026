.section .rodata
			msg_main_menu:
			.string "\n1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n5.Exit\n"
			
			msg_main_print_choice:
			.string "Enter your choice:\t"
			
			msg_main_scan1:
			.string "%d"
			
			msg_main_print_nums:
			.string "Enter two numbers:\t"
			
			msg_main_scan2:
			.string "%d%d"
			
			msg_main_valid:
			.string "Enter valid choice\n"
			
			msg_main_ans:
			.string "Answer is %d\n\n"
			
			msg_main_more:
			.string "Are you want to enter more choice?(1/0):\t"

.section .text
.global main
.type	main, @function
main:
			pushl %ebp
			movl %esp, %ebp 			# C: create stack frame for main()
			
			subl $16,%esp  				# reserve 16 bytes for iNo1, iNo2, iAns, iCh
											# -4(%ebp)  = iNo1
											# -8(%ebp)  = iNo2
											# -12(%ebp) = iAns
											# -16(%ebp) = iCh

label_do:									# C: do
			pushl $msg_main_menu
			call printf
			addl $4,%esp

			pushl $msg_main_print_choice
			call printf
			addl $4,%esp

			leal -16(%ebp), %eax			# eax = &iCh
			pushl %eax
			pushl $msg_main_scan1
			call scanf
			addl $8,%esp

			# C: if(iCh > 0 && iCh < 5)
			movl -16(%ebp),%eax			# eax = iCh
			cmpl $0,%eax
			jle label_skip_input			# if iCh <= 0, skip taking numbers
			cmpl $5,%eax
			jge label_skip_input			# if iCh >= 5, skip taking numbers

			pushl $msg_main_print_nums
			call printf
			addl $4,%esp

			leal -4(%ebp), %eax				# eax = &iNo1
			leal -8(%ebp), %edx				# edx = &iNo2
			pushl %edx
			pushl %eax
			pushl $msg_main_scan2
			call scanf
			addl $12,%esp

label_skip_input:

			# C: switch(iCh)
			movl -16(%ebp),%eax				# eax = iCh
			cmpl $1,%eax
			je label_case1
			cmpl $2,%eax
			je label_case2
			cmpl $3,%eax
			je label_case3
			cmpl $4,%eax
			je label_case4
			cmpl $5,%eax
			je label_case5
			jmp label_default

label_case1:								# case 1: iAns = Addition(iNo1,iNo2);
			movl -4(%ebp),%eax
			movl -8(%ebp),%edx
			pushl %edx
			pushl %eax
			call Addition
			addl $8,%esp
			movl %eax,-12(%ebp)
			jmp label_switch_end				# break;

label_case2:								# case 2: iAns = Subtraction(iNo1,iNo2);
			movl -4(%ebp),%eax
			movl -8(%ebp),%edx
			pushl %edx
			pushl %eax
			call Subtraction
			addl $8,%esp
			movl %eax,-12(%ebp)
			jmp label_switch_end				# break;

label_case3:								# case 3: iAns = Multiplication(iNo1,iNo2);
			movl -4(%ebp),%eax
			movl -8(%ebp),%edx
			pushl %edx
			pushl %eax
			call Multiplication
			addl $8,%esp
			movl %eax,-12(%ebp)
			jmp label_switch_end				# break;

label_case4:								# case 4: iAns = Division(iNo1,iNo2);
			movl -4(%ebp),%eax
			movl -8(%ebp),%edx
			pushl %edx
			pushl %eax
			call Division
			addl $8,%esp
			movl %eax,-12(%ebp)
			jmp label_switch_end				# break;

label_case5:								# case 5: exit(0);
			pushl $0
			call exit
											# no jmp needed — exit() never returns

label_default:								# default:
			pushl $msg_main_valid
			call printf
			addl $4,%esp

			movl $1,-16(%ebp)				# iCh = 1;
			jmp label_do						# continue;  -> jumps back to top of do-while

label_switch_end:

			pushl -12(%ebp)					# push iAns
			pushl $msg_main_ans
			call printf
			addl $8,%esp

			pushl $msg_main_more
			call printf
			addl $4,%esp

			leal -16(%ebp), %eax				# eax = &iCh
			pushl %eax
			pushl $msg_main_scan1
			call scanf
			addl $8,%esp

			# C: while(iCh == 1)
			movl -16(%ebp),%eax
			cmpl $1,%eax
			je label_do

			pushl $0
			call exit


.global 	Addition
.type 	Addition, @function
Addition:
			pushl %ebp
			movl %esp,%ebp				# Create stack frame

			subl 	$4,%esp				# Reserve 4 bytes: for int sum

			movl 8(%ebp), %eax			# eax = iNo1
			movl 12(%ebp), %edx			# edx = iNo2
			addl %edx, %eax				# eax = iNo1 + iNo2
			movl  %eax,-4(%ebp)			# return value in eax

			movl %ebp, %esp
			popl %ebp
			ret							# return iNo1 + iNo2;


.global 	Subtraction
.type 	Subtraction, @function
Subtraction:
			pushl %ebp
			movl %esp,%ebp				# Create stack frame

			subl 	$4,%esp				# Reserve 4 bytes: for int diff

			movl 8(%ebp), %eax			# eax = iNo1
			movl 12(%ebp), %edx			# edx = iNo2
			subl %edx, %eax				# eax = iNo1 - iNo2
			movl  %eax,-4(%ebp)			# return value in eax

			movl %ebp, %esp
			popl %ebp
			ret							# return iNo1 - iNo2;


.global 	Multiplication
.type 	Multiplication, @function
Multiplication:
			pushl %ebp
			movl %esp,%ebp				# Create stack frame

			subl 	$4,%esp				# Reserve 4 bytes: for int prod

			movl 8(%ebp), %eax			# eax = iNo1
			movl 12(%ebp), %ecx			# ecx = iNo2
			imull %ecx, %eax				# eax = iNo1 * iNo2   (signed multiply)
			movl  %eax,-4(%ebp)			# return value in eax

			movl %ebp, %esp
			popl %ebp
			ret							# return iNo1 * iNo2;


.global 	Division
.type 	Division, @function
Division:
			pushl %ebp
			movl %esp,%ebp				# Create stack frame

			subl 	$4,%esp				# Reserve 4 bytes: for int quo

			movl 8(%ebp), %eax			# eax = iNo1  (dividend)
			cltd							# sign-extend eax into edx (signed division)
			movl 12(%ebp), %ecx			# ecx = iNo2  (divisor)
			idivl %ecx					# eax = iNo1 / iNo2, edx = remainder (unused)
			movl  %eax,-4(%ebp)			# return value in eax

			movl %ebp, %esp
			popl %ebp
			ret							# return iNo1 / iNo2;