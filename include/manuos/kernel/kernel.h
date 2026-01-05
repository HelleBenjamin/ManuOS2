// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (c) 2025 Benjamin Helle
//
// Kernel include file

#ifndef KERNEL_H
#define KERNEL_H

#include <stdint.h>
#include <stddef.h>

#define KERNEL_VER 1
#define KERNEL_VER_STR "0.0.1\0"

/* PIC stuff */
#define PIC_MASTER_CMD  0x20
#define PIC_MASTER_DATA 0x21
#define PIC_SLAVE_CMD   0xA0
#define PIC_SLAVE_DATA  0xA1
#define PIC_EOI         0x20

/* GDT stuff*/
#define GDT_SELECTOR    0x08

/* Paging and memory related stuff*/
#define PAGE_PRESENT    0x01
#define PAGE_RW         0x02
#define PAGE_USER       0x04
#define KERNEL_VIRT     0xC0000000 /* Kernel virtual address*/
#define VGA_VIRT        0xC10B8000 /* VGA virtual address*/
#define VGA_PHYS        0x000B8000 /* VGA physical address*/

#define PAGE_SIZE       4096
#define MAX_MEMORY      0x10000000  /* 256 MB */
#define MAX_PAGES       (MAX_MEMORY / PAGE_SIZE)

#define KERNEL_HEAP     0xC0400000
#define KSTACK_TOP      0xC1000000
#define KSTACK_SIZE     (64 * 1024) /* 64 KB, adjust as needed */  

#define PHYS_OFFSET 0xC0000000 /* Only for the kernel */
#define phys_to_virt(p) ((void*)((p) + PHYS_OFFSET)) /* Convert physical address to virtual, ONLY FOR THE KERNEL!! (wasted hours debugging and the issue was this piece of shit)*/


/* Interrupt stuff */
#define GATE_TRAP       0x8F
#define GATE_INTERRUPT  0x8E

/* Grub multiboot structures */
typedef struct {
  uint32_t flags;
  uint32_t mem_low;
  uint32_t mem_high;
  uint32_t boot_device;
  uint32_t cmdline;
  uint32_t mods_count;
  uint32_t mods_addr;
  uint32_t syms[4];
  uint32_t mmap_len;
  uint32_t mmap_addr;
} mb_info;

typedef struct {
  uint32_t size;
  uint64_t addr;
  uint64_t len;
  uint32_t type;
} __attribute__((packed)) mb_mmap_entry;

typedef void (*entry_func_t)(void);

/* only in kernel mode!!*/
static inline uint8_t inb(uint16_t port) {
  uint8_t value;
  __asm__ volatile ("inb %1, %0" : "=a"(value) : "dN"(port));
  return value;
}

static inline void outb(uint16_t port, uint8_t data) {
  __asm__ volatile ("outb %0, %1" : : "a"(data), "dN"(port));
}

static inline uint16_t inw(uint16_t port) {
  uint16_t value;
  __asm__ volatile ("inw %1, %0" : "=a"(value) : "dN"(port));
  return value;
}

static inline void outw(uint16_t port, uint16_t value) {
  __asm__ volatile ("outw %0, %1" : : "a"(value), "dN"(port));
}

static inline void PIC_sendEOI(uint8_t irq) {
  if (irq >= 8) {
    outb(PIC_SLAVE_CMD, PIC_EOI);
  }
  outb(PIC_MASTER_CMD, PIC_EOI);
}

static inline void io_wait() {
  outb(0x80, 0x00);
}

struct idt_ptr_t{
  uint16_t limit;
  uint32_t base;
} __attribute__((packed));

struct isr_t{
  uint16_t offset1;
  uint16_t selector;
  uint8_t  null;
  uint8_t  attr;
  uint16_t offset2;
} __attribute__((packed));

struct regs {
  uint32_t eax, ebx, ecx, edx;
  uint32_t esp, ebp, esi, edi;
  uint32_t gs, fs, es, ds;
  uint32_t eip, cs, eflags, useresp, ss;
};

void kernel_main();
void* kmalloc(size_t size);
void kfree(void* ptr);
uint32_t alloc_kstack();

void pic_remap(void);
void idt_init(void);
void set_idt_gate(uint8_t vector, void* handler, uint16_t selector, uint8_t attr);

void page_init(uint32_t mbh);
uint32_t alloc_page(void);
void free_page(uint32_t addr);
void free_page(uint32_t addr);
void map_page(uint32_t virt_addr, uint32_t phys_addr, uint32_t flags);
void unmap_page(uint32_t virt_addr);
void dump_pinfo(void);
void reserve_range(void* addr, size_t size);
uint32_t virt_to_phys(uint32_t virt);

uint16_t get_uptime_seconds(void);
void kernel_panic(void);
void stack_trace(void);
void fs_list_root(void);
void printk(char *s);

#endif