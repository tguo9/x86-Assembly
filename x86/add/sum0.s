# Function       Sum
# Purpose:       Add two long ints
# C prototype:   long Sum(long a, long b)
#
# Notes:
# 1. gcc expects a function called "Sum", not "_Sum"
# 2. This code assumes the x86-64 System V AMD64 calling conventions:
#    - The first six args are passed in registers RDI, RSI, RDX, RCX, 
#      R8, and R9, respectively.
#    - Additional arguments are passed on the stack.
#    - The return address is on the top of the stack.
#    - Registers RBX, RBP (the frame or base pointer), and R12-R15
#      should be saved by the called function (callee)
#    - The return value is stored in RAX.  A second return value can
#      be returned in RDX
# 3. This does *not* adhere to the x86 ABI specification for managing
#    the stack and base pointers.  The file sum.s does this correctly.

        .global  Sum
#       rdi = 1st arg = a
#       rsi = 2nd arg = b
#       rax = return val = c
Sum:
        add     %rdi, %rsi      # rsi += rdi, b = a + b
        mov     %rsi, %rax      # rax = rsi = a+b

        ret                     # Pop return address from stack
                                # And return to caller

