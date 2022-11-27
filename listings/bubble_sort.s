.text

bubble_sort:
.globl bubble_sort
  li a3, 0 # i = 0, счетчик внешнего цикла

loop_i_start:
  li a4, 0 # j = 0, счетчик внутреннего цикла

loop_j:
  slli t1, a4, 2 # t1 = j << 2 = j * 4
  add t1, t1, a2 # t1 = array + j * 4 (a[j])
  addi t2, t1, 4 # t2 = array + j * 4 + 1(4) (a[j+1]
  lw t3, 0(t1) # t3 = a[j]
  lw t4, 0(t2) # t4 = a[j+1]
  bgt t3, t4, if_a # if (a[j] > a[j+1]) goto if_a
  j loop_j_end

if_a:
  sw t4, 0(t1) # a[j + 1] = a[j]
  sw t3, 0(t2) # a[j] = a[j + 1]
  j loop_j_end

loop_j_end:
  addi a4, a4, 1 # j++
  # j < n - i - 1 ?
  sub a6, a1, a3 # x6 = n - i
  addi a6, a6, -1 # x6--
  bgeu a4, a6, loop_i_end # if (j >= n - i - 1) goto loop_i_start
  j loop_j

loop_i_end:
  addi a3, a3, 1 # i++
  addi a5, a1, -1 # x5 = n - 1
  bgeu a3, a5, exit # if (i >= n - 1) goto median
  j loop_i_start

exit:
  ret # return