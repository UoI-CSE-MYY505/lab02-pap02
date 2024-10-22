

.data

array: .word 1, 0, 1, 12, 0, 1, 4

.text

    la a0, array
    li a1, 7    # unsigned
    li a2, 1
 #   j  findLast_forwards_withIndex
 #   j  findLast_forwards_withPointers

# -------------------------------
# Prefered solution: start from last element of the array and scan it backwards
#  using pointer, the first match is returned.
# Some extra work is done ouside the loop, so that the loop body is 
#  just a few instructions
# Algorithm:
# if a1 == 0
#   goto ret0
# s0 = a0 + a1 *4
# do {
#   s0--;
#   if *s0 == a2
#     goto done
# } while s0 != a0
# ret0:
#   s0 = 0  // not found
# done:
#   return
findLast_backwards_withPointers:
    beq  a1, zero, ret0
    slli s0, a1, 2  # offset of 1 word past the end of the array
    add  s0, s0, a0 # full address of the above
loop:
    addi s0, s0, -4   # s0--
    lw   t1, 0(s0)
    beq  t1, a2, done
    bne  s0, a0, loop
ret0:
    add  s0, zero, zero  # return address - not found
done:
    addi a7, zero, 10 
    ecall

