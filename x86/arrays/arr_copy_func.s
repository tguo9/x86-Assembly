# Function:     Copy
# Purpose:      Copy the contents of one array of long ints into another
# C Prototype:  void Copy(long A[], long B[], long n);
# Args:         A = rdi (in)
#               B = rsi (out)
#               n = rdx (out)
# Ret val:      none

        .global Copy
#       rdi = A
#       rsi = B
#       rdx = n
#       r8 = i
#       r9 = temporary (used for A[i])
#       r10 = offset into arrays
#       r11 = address (array + offset)

Copy:
        push %rbp       # Store caller's base pointer
        mov %rsp, %rbp  # Set our base pointer = stack pointer

        mov $0, %r8     # i = 0;
        mov $0, %r10    # offset = 0;

Loop:   cmp %rdx, %r8   # Check whether i = r8 >= n = rdx
                        # Intel syntax:  cmp %r8, %rdx
                        # ATT syntax:  cmp %rdx, %r8
        jge Done        # if i >= n, go to Done

        # Load A[i]   
        mov %r10, %r11  # r11 gets offset into A
        add %rdi, %r11  # r11 gets &A[i]
        mov (%r11), %r9 # r9 gets A[i] 

        # Store A[i] in B[i]
        mov %r10, %r11  # r11 gets offset into B
        add %rsi, %r11  # r11 = &B[i]
        mov %r9, (%r11) # B[i] = A[i]

        add $1, %r8     # i++
        add $8, %r10    # Next offset into arrays
        jmp Loop        # Go to beginning of loop

Done:   leave           # Set rsp = rbp; 
                        # Set rbp = caller's rbp
                        # Set rsp = rsp + 8
        ret             # Branch to return address
