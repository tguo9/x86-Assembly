# Function:     Fibo
# Purpose:      Return the nth Fibonacci number, where
#
#                     Fibo(0) = 0
#                     Fibo(1) = 1
#                     Fibo(n) = Fibo(n-1) + Fibo(n-2), n >= 2
#
# C Prototype:  long Fibo (long n)
# Args:         n = rdi
# Return val:   Fibo(n) = rax
# 
# This version uses push and pop instead of mov to store and retrieve
# information to/from the stack

        .global Fibo
#       n = rdi
#       F_n = rax on return

Fibo:
        push %rbp
        mov  %rsp, %rbp

        # Is n = 0?
        cmp  $0, %rdi           # Is n = rdi == 0?  Note that the immediate
                                #    must come first here
        jne  n_gt_0             # Look at the flags register to see whether
                                #    the previous comparison result in !=
        mov  $0, %rax           # Return 0
        jmp  done               # Go to done

n_gt_0:
        # Is n = 1?
        cmp  $1, %rdi           # Is n = rdi == 1?
        jne  n_gt_1             # Look at the flags register to see whether
                                #    the previous comparison result in !=
        mov  $1, %rax           # Return 1
        jmp  done               # Go to done
        
n_gt_1:
        # n >= 2
        push  %rdi              # Save n = rdi on the stack 
        sub  $1, %rdi           # n = n-1
        call Fibo
        pop  %rdi               # Get n off the stack
        push %rax               # Save Fibo(n-1) on the stack
        sub  $2, %rdi           # n = n-2
        call Fibo
        pop  %rdx               # Get Fibo(n-1) from the stack
        add  %rdx, %rax         # return Fibo(n-1) + Fibo(n-2)

done:
        leave                   # Assigns rbp to rsp:  no need to
                                #    add 16 to rsp
        ret
