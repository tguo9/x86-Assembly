# Function:     Add
# Purpose:      Add corresponding entries in two arrays of long ints
# C Prototype:  void Add(long A[], long B[], long C[], long n);
# Args:         A = rdi (in)
#               B = rsi (in)
#               C = rdx (out)
#               n = rcx (in)
# Ret val:      none

        .global Add
#       rdi = A
#       rsi = B
#       rdx = C
#       rcx = n
#       r8 = i
#       r9 = temporary (used for intermediate sums)
#       r10 = offset into arrays
#       r11 = address (array + offset)

Add:
        push %rbp       # Store caller's base pointer
        mov %rsp, %rbp  # Set our base pointer = stack pointer

        mov $0, %r8     # i = 0;
        mov $0, %r10    # offset = 0;

Loop:   cmp %rcx, %r8   # Check whether i = r8 >= n = rcx
                        # Intel cmp %r8, %rcx
                        # ATT cmp %rcx, %r8
        jge Done        # if i >= n go to Done

        # Load A[i]   
        mov %r10, %r11  # r11 gets offset into arrays 
        add %rdi, %r11  # r11 gets &A[i]
        mov (%r11), %r9 # r9 gets A[i] 

        # Add A[i] + B[i]
        mov %r10, %r11  # r11 gets offset into arrays 
        add %rsi, %r11  # r11 gets &B[i]
        add (%r11), %r9 # r9 gets A[i] + B[i]

        # Store A[i] + B[i] in C[i]
        mov %r10, %r11  # r11 gets offset into arrays 
        add %rdx, %r11  # r11 = &C[i]
        mov %r9, (%r11) # C[i] = A[i] + B[i]

        add $1, %r8     # i++
        add $8, %r10    # Next offset into arrays
        jmp Loop        # Go to beginning of loop

Done:   leave           # Set rsp = rbp; 
                        # Set rbp = caller's rbp
                        # Set rsp = rsp + 8
        ret             # Branch to return address
