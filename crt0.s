
.section .text
  .code32
  .globl _start
  .extern main

_start:
  # setup stack, fds, etc..
  call main

  # How we exit?