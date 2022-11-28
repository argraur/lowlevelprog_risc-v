.text

main:
.globl main
  addi sp, sp, -16 # выделение памяти в стеке
  sw ra, 12(sp) # сохранение ra
  
  lw a1, n # х1 = 6, длина массива
  la a2, array # x2 = адрес 0-го элемента массива
  call bubble_sort # вызов функции сортировки массива
  call median # вызов функции подсчета медианы
  
  lw ra, 12(sp) # восстановление ra
  addi sp, sp, 16 # освобождение памяти в стеке

  # Print returned value to console
  add a1, x0, a0
  addi a0, x0, 1
  ecall

  li a0, 0
  ret # return

.rodata
n: # длина массива
  .word 8

.data
array: # массив [10, 30, 56, 79, 47, 90, 100, 101]
  .word 10, 30, 56, 79, 47, 90, 100, 101