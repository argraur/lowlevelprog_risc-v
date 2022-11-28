.text

bubble_sort:
.globl bubble_sort
  li a3, 0 # i = 0, счетчик внешнего цикла

loop_i_start:
  li a4, 0 # j = 0, счетчик внутреннего цикла

loop_j:
  slli t1, a4, 2 # t1 = j << 2 = j * 4
  add t1, t1, a2 # t1 = array + j * 4 (a[j])
  lw t3, 0(t1) # t3 = a[j]
  lw t4, 4(t1) # t4 = a[j+1]
  ble t3, t4, loop_j_end # if (a[j] <= a[j+1]) goto loop_j_end

if_a:
  sw t4, 0(t1) # a[j + 1] = a[j]
  sw t3, 4(t1) # a[j] = a[j + 1]

loop_j_end:
  addi a4, a4, 1 # j++
  # j < n - i - 1 ?
  sub a6, a1, a3 # x6 = n - i
  addi a6, a6, -1 # x6--
  blt a4, a6, loop_j # if (j < n - i - 1) goto loop_j

loop_i_end:
  addi a3, a3, 1 # i++
  addi a5, a1, -1 # x5 = n - 1
  blt a3, a5, loop_i_start # if (i < n - 1) goto loop_i_start

exit:
  ret # return