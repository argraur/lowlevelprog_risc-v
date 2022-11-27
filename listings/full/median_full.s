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
  bgeu a3, a5, median # if (i >= n - 1) goto median
  j loop_i_start

median:
  srli t1, a1, 1 # t1 = int(n / 2)
  slli t2, t1, 1 # t2 = int(n / 2) * 2
  sub t3, a1, t2 # t3 = n - int(n / 2) * 2 // ОСТАТОК ДЕЛЕНИЯ НА 2
  beqz t3, even # if (t3 == 0) goto even
  bnez t3, odd # if (t3 != 0) goto odd
  even:
    slli t1, t1, 2 # t1 = n / 2 << 2 = n / 2 * 4
    add t1, t1, a2 # t1 = array + n / 2 * 4 (a[n / 2])
    li t5, -1 # t5 = -1
    slli t5, t5, 2 # t5 = -1 << 2
    add t2, t1, t5 # t2 = array + n / 2 * 4 - 1(4) (a[n / 2 - 1]
    lw t3, 0(t1) # t3 = a[n / 2]
    lw t4, 0(t2) # t4 = a[n / 2 - 1]
    add a7, t3, t4 # a0 = a[n / 2] + a[n / 2 - 1] 
    srli a7, a7, 1 # a0 /= 2
    j exit
  odd:
    slli t1, t1, 2 # t1 = n / 2 << 2 = n / 2 * 4
    add t1, t1, a2 # t1 = array + n / 2 * 4 (a[n / 2])
    lw t2, 0(t1) # a0 = a[n / 2]
    j exit

exit:
  li a0, 10 # exit code
  ecall

.rodata
n: # длина массива
  .word 8

.data
array: # массив [10, 30, 56, 79, 47, 90, 100, 101]
  .word 10, 30, 56, 79, 47, 90, 100, 101