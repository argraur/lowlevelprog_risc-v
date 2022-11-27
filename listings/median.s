.text

median:
.globl median
  srli t1, a1, 1 # t1 = int(n / 2)
  slli t2, t1, 1 # t2 = int(n / 2) * 2
  sub t3, a1, t2 # t3 = n - int(n / 2) * 2 // ОСТАТОК ДЕЛЕНИЯ НА 2
  beqz t3, even # if (t3 == 0) goto even
  bnez t3, odd # if (t3 != 0) goto odd
  even:
    slli t1, t1, 2 # t1 = n / 2 << 2 = n / 2 * 4
    add t1, t1, a2 # t1 = array + n / 2 * 4 (a[n / 2])
    addi t2, t1, -4 # t2 = array + n / 2 * 4 - 1(4) (a[n / 2 - 1]
    lw t3, 0(t1) # t3 = a[n / 2]
    lw t4, 0(t2) # t4 = a[n / 2 - 1]
    add a7, t3, t4 # a0 = a[n / 2] + a[n / 2 - 1] 
    srli a7, a7, 1 # a0 /= 2
    j exit
  odd:
    slli t1, t1, 2 # t1 = n / 2 << 2 = n / 2 * 4
    add t1, t1, a2 # t1 = array + n / 2 * 4 (a[n / 2])
    lw a7, 0(t1) # a0 = a[n / 2]
    j exit

exit:
  ret # return