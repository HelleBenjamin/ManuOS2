
.section .text
  .code32
  .globl _start
  .extern main

_start:
  # setup stack, fds, etc..
  call main
  movl $0, %eax
  int $0x80
  # TODO: exit 
