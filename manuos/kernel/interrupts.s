
.section .text
  .code32
  .globl default_isr
  .globl default_isr_code
  .globl default_irq
  .globl kb_isr
  .extern kb_handler
  .extern prints # from video driver
  .extern puth
  .extern kernel_panic

# This contains all the interrupt/fault/trap handlers
# TODO: Name things right


# Divide by zero
.globl dbz_handler
dbz_handler:
  pushal
  pushl $dbz_msg
  call prints
  addl $4, %esp
  popal
  iretl

# Overflow
.globl of_handler
of_handler:
  pushal
  pushl $of_msg
  call prints
  addl $4, %esp
  popal
  iretl

# Illegal opcode
.globl illop_handler
illop_handler:
  pushal
  pushl $illop_msg
  call prints
  addl $4, %esp
  popal
  iretl

# Double fault
.globl df_handler
df_handler:
  pushl $df_msg
  call prints
  addl $4, %esp
  jmp kernel_panic

# General protection fault
.globl gp_handler
gp_handler:
  pushl $gp_msg
  call prints
  addl $4, %esp
  jmp kernel_panic

# Page fault handler
.globl pf_handler
pf_handler:

  # Print the error code
  popl %eax
  pushl %eax
  call puth
  addl $4, %esp
  # Print msg
  movl $pf_msg, %eax
  pushl %eax
  call prints
  addl $4, %esp

  # Panic
  jmp kernel_panic

  iretl

# PIT handler
.globl pit_handler
pit_handler:
  pushl %eax
  movb $0x20, %al
  outb %al, $0x20
  popl %eax
  iretl

# Keyboard handler
kb_isr:
  pushal
  call kb_handler
  movb $0x20, %al
  outb %al, $0x20
  popal
  iretl

default_isr:
  iretl

default_isr_code:
  addl $4, %esp
  iretl

default_irq:
  movb $0x20, %al
  outb %al, $0x20
  iretl

.section .data

dbz_msg:
  .asciz "Divide by zero\n"

of_msg:
  .asciz "Overflow\n"

illop_msg:
  .asciz "Illegal opcode\n"

df_msg:
  .asciz "Double fault\n"

gp_msg:
  .asciz "General protection fault\n"

pf_msg:
  .asciz "Page fault\n"
