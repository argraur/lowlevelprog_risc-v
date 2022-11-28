.text

__start:
.globl __start
  lw a1, n # х1 = 6, длина массива
  la a2, array # x2 = адрес 0-го элемента массива
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

median:
  srli t1, a1, 1 # t1 = int(n / 2)
  slli t2, t1, 1 # t2 = int(n / 2) * 2
  sub t3, a1, t2 # t3 = n - int(n / 2) * 2 // ОСТАТОК ДЕЛЕНИЯ НА 2
  slli t1, t1, 2 # t1 = n / 2 << 2 = n / 2 * 4
  add t1, t1, a2 # t1 = array + n / 2 * 4 (a[n / 2])
  bnez t3, odd # if (t3 != 0) goto odd
  even:
    lw t3, 0(t1) # t3 = a[n / 2]
    lw t4, -4(t1) # t4 = a[n / 2 - 1]
    add a7, t3, t4 # a0 = a[n / 2] + a[n / 2 - 1] 
    srli a7, a7, 1 # a0 /= 2
    j exit
  odd:
    lw a7, 0(t1) # a0 = a[n / 2]

exit:
  # Print returned value to console
  add a1, x0, a7 # set output value to a7
  addi a0, x0, 1 # set output to stdout
  ecall # execute system call
  
  li a0, 10 # exit code
  ecall
  
.rodata
n: # длина массива
  .word 8

.data
array: # массив [10, 30, 56, 79, 47, 90, 100, 101]
  .word 10, 30, 56, 79, 47, 90, 100, 101
