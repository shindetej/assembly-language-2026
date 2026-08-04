### Multiplication
> 	mull	  %ecx
- Multiplication done between eax and operand given with mull instruction
- here value in %ecx multiplied by value in %eax
- stored in eax | edx combined (64 bit register)

- If two operands 8 bit then result stored in 16 bit
    - %al * %cl = %ax 
- If two operands 16 bit result stored in 32 bit
    - %ax * %cx = %dx %ax
- If two operands 32 bit result stored in 64 bit
    - %eax * %ecx = %edx %eax
    - or say %edx:%eax = %eax * %ecx

- where LSB is eax and MSB edx
    - we will see endianness afterwards


### Division
> 	divl	  %ecx
- Division is done between the combined edx:eax (dividend) and the operand given with divl instruction (divisor)
- here value in edx:eax (64-bit) is divided by value in %ecx
- quotient stored in %eax, remainder stored in %edx

- If dividend is 16 bit (ax) divided by 8 bit operand
    - %ax / %cl → quotient in %al, remainder in %ah
- If dividend is 32 bit (dx:ax) divided by 16 bit operand
    - %dx:%ax / %cx → quotient in %ax, remainder in %dx
- If dividend is 64 bit (edx:eax) divided by 32 bit operand
    - %edx:%eax / %ecx → quotient in %eax, remainder in %edx
    - or say %eax = (%edx:%eax) / %ecx  and  %edx = (%edx:%eax) % %ecx

- where LSB is eax and MSB edx (same endianness note as multiplication)