# Function:     Ins_sort 
# Purpose:      Sort an array of longs using insertion sort
# C Prototype:  void Ins_sort(long a[], long n)
#
# Args:         rdi = a
#               rsi = n 
#
# Notes:
# 1. Linux gcc expects a function called "Ins_sort", not "_Ins_sort"
# 2. This code assumes the x86-64 System V AMD64 calling conventions:
#    - The first six args are passed in registers RDI, RSI, RDX, RCX, 
#      R8, and R9, respectively.
#    - Additional arguments are passed on the stack.
#    - Registers rbx, rbp (the frame or base pointer), and r12-r15
#      should be saved by the called function (callee)
#    - The return value is stored in RAX.  A second return value can
#      be returned in rdx
# 3. We're assuming that the functions Where_ins and Insert don't
#    modify their first argument (the array a, which is the address
#    of the first element of a).  So %rdi doesn't need to be saved
#    on the stack when these functions are called.


        .global Ins_sort
#       rdi = a
#       rsi = r8 = n
#       r9 = i

Ins_sort:  
        push %rbp
        mov  %rsp, %rbp
        sub  $16, %rsp          # Make space to put i, n on stack
        
        # Array a = %rdi.  Don't need to save, since not modified
        #    by the callee.
        # Number of elements = n = %rsi = %r8.  Save on stack.
        mov  %rsi, %r8         
        mov  %r8, 8(%rsp)

        # Current element in subscript i = %r9
        mov  $1, %r9

loop_is:
        # We exit the for loop if i >= n or r9 >= r8 
        #    In Intel syntax: use cmp r9, r8.  
        #    So in AT&T syntax
        cmp  %r8, %r9           # Is i = r9 >= n = r8?
        jge  done_is            # If i >= n, we're done

        # Set up for call to Where_ins 
        mov  %r9, 0(%rsp)       # Store i = r9 on stack
        mov  %r9, %rsi          # Second arg to Where_ins = i
        call Where_ins          # First arg = a is already in rdi

        # Set up for call to Insert
        mov  %rax, %rsi         # Ret val = j is second arg
        mov  0(%rsp), %rdx      # Third arg = i
        call Insert             # First arg = a is already in rdi

        # In case r8 (= n)or r9 (= i) has been modified . . .
        mov  0(%rsp), %r9
        mov  8(%rsp), %r8

        add  $1, %r9            # i++
        jmp  loop_is

done_is:
        leave
        ret


#######################################################################
# Function:     Where_ins (C Where_to_insert)
# Purpose:      Determine where a[i] should be inserted in the sorted
#               list a[0], a[1], . . . , a[i-1]
#
# C Prototype:  void Where_ins(long a[], long i)
#
# a = rdi, i = rsi, ret val = j = rax

Where_ins:
        push %rbp
        mov  %rsp, %rbp

        # Put a[i] in r11 
        mov  0(%rdi, %rsi, 8), %r11   # a[i] is located at 
                                      #    a + i*8 = rdi + rsi*8

        # Put j = i-1 in r10
        mov  %rsi, %r10
        sub  $1, %r10

        # default return value is 0
        mov  $0, %rax    

loop_wi:
        # We exit if j < 0 or if r10 < 0.
        #    So in Intel syntax: cmp r10 0
        #    In AT&T syntax
        cmp  $0, %r10                   
        jl   done_wi                    # If j < 0 go to done_wi

        # Put a[j] in r8 
        mov  0(%rdi, %r10, 8), %r8      # a[j] is located at
                                        #    a + j*8 = rdi + r10*8

        # If a[i] < a[j] or if r11 < r8, continue searching 
        #    So in Intel syntax:  cmp r11, r8
        #    In AT&T syntax:       
        cmp  %r8, %r11                  # 
        jl   cont_wi                    # a[i] < a[j], continue searching

        # We've found the subscript
        add  $1, %r10                   # a[i] >= a[j], return j+1
        mov  %r10, %rax
        jmp  done_wi

cont_wi:
        sub  $1, %r10                   # j--
        jmp  loop_wi

done_wi:
        leave
        ret


#######################################################################
# Function:     Insert
# Purpose:      Insert a[i] into slot pos by first shifting a[i-1],
#               a[i-2], . . . , a[pos] one slot forward
#
# C Prototype:  void Insert(long a[], long j, long i);
#
# a = rdi, pos = rsi, i = rdx, k = r8, r11 = temp = a[i] when called

Insert:
        push %rbp
        mov  %rsp, %rbp

        # a[i] = r11 = temp
        mov  0(%rdi,%rdx,8), %r11       # a[i] is located at
                                        #    a + i*8 = rdi + rdx*8
        # k = i-1 = r8 
        mov  %rdx, %r8                  
        sub  $1, %r8 

loop_i: 
        # If k < pos or r8 < rsi, exit loop
        #    In Intel syntax:  cmp r8, rsi
        #    In AT&T syntax       
        cmp  %rsi, %r8                  
        jl   done_i                     # k < j, done, exit loop

        # Only one of the mov operands can be a memory location
        # So first load a[k]
        mov  0(%rdi,%r8,8), %r9         # r9 = a[k]
        # Now store a[k] in a[k+1]
        mov  %r9, 8(%rdi,%r8 ,8)	# a[k+1] = r9 = a[k]

        sub  $1, %r8                    # k--
        jmp  loop_i

done_i:
        # Assign a[pos] <-- a[i]
        mov  %r11, 0(%rdi, %rsi, 8)
        leave
        ret
