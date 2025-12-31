.section .text
  .code32
  .globl syscall_dispatch
  .globl default_isr
  .globl default_isr_code
  .globl default_irq
  .globl kb_isr

# Move these interrupt handlers to their own file

  .extern kb_handler
kb_isr:
  pushal
  call kb_handler
  movb $0x20, %al
  outb %al, $0x20
  popal
  iret

default_isr:
  iret

default_isr_code:
  addl $4, %esp
  iret

default_irq:
  movb $0x20, %al
  outb %al, $0x20
  iret

syscall_dispatch:

  pushal
  movl %eax, %edi
  shll $1, %edi
  shll $1, %edi
  addl $syscall_table, %edi
  call *(%edi)
  
  popl %edi
  popl %esi
  popl %ebp
  addl $4, %esp
  popl %ebx
  popl %edx
  popl %ecx
  addl $4, %esp # skip eax, which is the return value

  iret

# extern C syscall functions
.extern sys_write
.extern sys_read

syscall_table:
  # address         # eax(syscall code)
  .long scall_stub  # 0x00: exit
  .long swrite      # 0x01: write
  .long sread       # 0x02: read
  .long scall_stub  # 0x03: open
  .long scall_stub  # 0x04: close
  .long scall_stub  # 0x05: exec
  .long scall_stub  # 0x06: fork


scall_stub: # a syscall that does nothing
  ret

swrite:
  pushl %ecx
  pushl %ebx
  pushl %edx
  call sys_write
  addl $12, %esp
  ret

sread:
  pushl %ecx
  pushl %ebx
  pushl %edx
  call sys_read
  addl $12, %esp
  ret

.globl test_syscall
test_syscall:
  # Test print
  movl $1, %eax
  movl $msg, %ebx
  movl $5, %ecx
  movl $1, %edx
  int $0x80

  .extern puth
  # Print the return value
  push %eax
  call puth
  addl $4, %esp

  # Test read
  movl $2, %eax
  movl $buffer, %ebx
  movl $32, %ecx
  movl $0, %edx
  int $0x80

  ret


.section .data
msg:
  .asciz "Testi"

.section .bss
buffer:
  .skip 32
