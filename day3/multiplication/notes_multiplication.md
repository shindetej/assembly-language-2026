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
