# Function       Larger
# Purpose:       Return the larger of two longs
# C prototype:   long Larger(long a, long b)
#
# Notes:
# 1. Linux gcc expects a function called "Larger", not "_Larger"
# 2. This code assumes the x86-64 System V AMD64 calling conventions:
#    - The first six args are passed in registers RDI, RSI, RDX, RCX, 
#      R8, and R9, respectively.
#    - Additional arguments are passed on the stack.
#    - Registers rbx, rbp (the frame or base pointer), and r12-r15
#      should be saved by the called function (callee)
#    - The return value is stored in RAX.  A second return value can
#      be returned in rdx
# 3. The cmp instruction is a little confusing.  It takes two
#    registers:
#
#          cmp %rsi, %rdi
#
#    It *subtracts* the first register from the second.  (So this
#    is the opposite of subs and cmp in ARMv8.)  A subsequent
#    conditional branch looks at the flags set by the subtraction.
#    We don't need to know the details of the various flag bits.   
#    We can decide how to branch on the basis of the sign of 
#    of the difference:
#    - If the difference is positive, jge will take the branch
#         jle will fall through.
#    - If the difference is zero, jge will take the branch and
#         jle will also take the branch.
#    - If the difference is negative, jge will not take the branch
#         and jle will take the branch.

        .global  Larger

Larger:
        push    %rbp            # Convention requires saving RBP
        mov     %rsp, %rbp      # Now the base and the top of the stack 
                                #    frame are the same.


        cmp     %rsi, %rdi      # Set bits in the FLAGS register according to
                                #    the value rdi-rsi.  
                                #    Remember ATT reverses operand order
        jge     rdi_big         # Go to rdi_big if rdi >= rsi
        mov     %rsi, %rax      # If we got here rsi is bigger, set ret val
                                #    = rax to rsi
        jmp     done            # Go to done

rdi_big:
        mov     %rdi, %rax      # If we got here rsi is bigger, set ret val
                                #    = rax to rsi

done:
        leave                   # Set stack pointer to frame pointer 
                                #    and pop old frame pointer
        ret                     # Pop return address and jump to it

