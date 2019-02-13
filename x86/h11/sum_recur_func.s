# Function:     Sum
# Purpose:      Add the elements of an array using recursion
# C Prototype:  long Sum(long A[], long n);
# Args:         A = rdi (in)
#               n = rcx (in)
# Ret val:      rax = sum of the elements of A

        .global Sum
#       rdi = A
#       rsi = n
#       r8 = i
#       r9 = temporary (used for intermediate sums)
#       r10 = offset into arrays
#       r11 = address (array + offset)

Sum:
        push %rbp         # Store caller's base pointer
        mov %rsp, %rbp    # Set our base pointer = stack pointer
        sub $16, %rsp     # Increase stack size; need a multiple of 16


        cmp $1, %rsi      # Check whether n = 1
        jne n_gt_1        # if n > 1 go to n_gt_1
        
        mov (%rdi), %rax  # ret val = rax = A[0]
        jmp Done

        # n > 1, make recursive calls
n_gt_1: 
        mov %rsi, (%rsp)  # Save value of n on stack
        sub $1, %rsi      # n = n-1;
        call Sum          # rax = A[0] + ... + A[n-2]

        mov (%rsp), %r8   # r8 = n
        sub $1, %r8       # r8 = n-1
        imul $8, %r8      # r8 = 8*(n-1) 
        add %rdi, %r8     # r8 = &A[n-1]
        mov (%r8), %r9    # r9 = A[n-1]
        add %r9, %rax     # rax = A[0] + ... + A[n-1]

Done:   leave             # Set rsp = rbp; 
                          # Set rbp = caller's rbp
                          # Set rsp = rsp + 8
        ret               # Branch to return address
