
.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .text
.global _start
.type _start, @function
_start:
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
	ljmp $0x08, $call_kernel

call_kernel:

	# Set the stack
	mov $stack_top, %esp
	call kernel_main

	hlt

.section .rodata
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


.section .bss
.align 16
stack_bottom:
.skip 65536 # 64kb
stack_top:
