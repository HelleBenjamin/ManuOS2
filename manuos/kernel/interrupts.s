
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

pf_msg:
  .asciz "Page fault\n"
