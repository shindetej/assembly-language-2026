.section .rodata
    msg_main_print1:
    .string "\nCalling fun1\n"
    
    msg_main_print2:
    .string "\nCalling fun2\n"
    
    msg_fun1_print:
    .string "In fun1, iNo = %d\n"
    
    msg_fun2_print:
    .string "In fun2, iNo = %d\n"
.section .data
    fun2_iNo:					# static int iNo = 10;  
    .long 10

main:
    pushl %ebp
    movl %esp, %ebp 			
    
    subl $4,%esp  				# reserve 4 bytes for iCounter
                                    # -4(%ebp) = iCounter
    
    pushl $msg_main_print1
    call printf
    addl $4,%esp
    
    # C: for(iCounter = 0; iCounter < 3; iCounter++) fun1();
    movl $0,-4(%ebp)				# iCounter = 0
    jmp label_for1_cond

label_for1:
    call fun1
    
    incl -4(%ebp)					# iCounter++
			
label_for1_cond:
    movl -4(%ebp),%eax				# eax = iCounter
    cmpl $3,%eax
    jl label_for1					# loop while iCounter < 3

    pushl $msg_main_print2
    call printf
    addl $4,%esp

    # C: for(iCounter = 0; iCounter < 3; iCounter++) fun2();
    movl $0,-4(%ebp)				# iCounter = 0
    jmp label_for2_cond

label_for2:
    call fun2
    
    incl -4(%ebp)					# iCounter++
			
label_for2_cond:
    movl -4(%ebp),%eax				# eax = iCounter
    cmpl $3,%eax
    jl label_for2					# loop while iCounter < 3

    pushl $0
    call exit


.globl 	fun1
.type 	fun1, @function
fun1:
    pushl %ebp
    movl %esp,%ebp				

    subl $4,%esp					# Reserve 4 bytes: for LOCAL int iNo
                                    # -4(%ebp) = iNo   (fresh copy every call)

    movl $10,-4(%ebp)				# iNo = 10;   (re-initialized EVERY call)
    incl -4(%ebp)					# iNo++;

    pushl -4(%ebp)					# push iNo
    pushl $msg_fun1_print
    call printf
    addl $8,%esp

    movl %ebp,%esp
    popl %ebp
    ret							# return; (void)


.globl 	fun2
.type 	fun2, @function
fun2:
    pushl %ebp
    movl %esp,%ebp			
                                
    incl fun2_iNo					# iNo++;   directly incremented in .data
                                    # NO re-initialization to 10 — value PERSISTS across calls

    pushl fun2_iNo					# push iNo
    pushl $msg_fun2_print
    call printf
    addl $8,%esp

    popl %ebp
    ret	

