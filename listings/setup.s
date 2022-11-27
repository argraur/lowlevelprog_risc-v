.text

__start:
.globl __start
  call main # вызов main функции

finish:
  li a0, 10 # exit code
  ecall