
.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */

.set KERNEL_VIRT, 0xC0000000

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


.section .boot
.global _start
_start:
	# Disable interrupts
	cli

	# Use our own GDT instead of the grub one
	lgdt gdt_descriptor

	# Set the segments
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss

	# Flush the CS
	ljmp $0x08, $flush_cs

flush_cs:

	.extern idt_init
	.extern pic_remap
	.extern video_init
	call video_init
	.extern prints
	pushl $kernel_msg
	call prints
	addl $4, %esp
	pushl $gdt_msg
	call prints
	addl $4, %esp
	call idt_init
	call pic_remap


	# Enable paging
	.extern page_dir
	.extern page_init
	pushl %ebx # multiboot header
	call page_init
	addl $4, %esp

	movl $page_dir, %eax
	#subl KERNEL_VIRT, %eax # Conversion if needed
	movl %eax, %cr3

	movl %cr0, %eax
	orl $0x80000000, %eax
	movl %eax, %cr0

	jmp 1f
1:

call_kernel:

	# Set the kernel stack
	.extern alloc_kstack
	call alloc_kstack
	movl %eax, %esp

	#movl $stack_top, %esp # Backup option if the alloc_kstack function doesn't work

	call kernel_main

halt_loop:
	hlt
	jmp halt_loop

.section .data
.align 8

gdt:
	.quad 0x0000000000000000 # null
	.quad 0x00CF9A000000FFFF # kernel
	.quad 0x00CF92000000FFFF
	.quad 0x00CFFA000000FFFF # user
	.quad 0x00CFF2000000FFFF
gdt_end:

.align 4
gdt_descriptor:
	.word gdt_end - gdt - 1
	.long gdt

gdt_msg:
	.asciz " GDT loaded\n"

kernel_msg:
  .asciz "Manux Kernel 0.0.1\n"

.section .bss
# Pointer to multiboot struct, needed for the kernel
.align 4
multiboot_struct:
.long 0

.align 16
stack_bottom:
.skip 65536 # 64kb
stack_top:
