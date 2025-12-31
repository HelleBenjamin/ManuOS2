// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (c) 2025 Benjamin Helle
//
// Kernel include file

#ifndef KERNEL_H
#define KERNEL_H

#include "../../../libc/lansker-libc.h"

#define KERNEL_VER 1
#define KERNEL_VER_STR "0.0.1\0"

/* PIC stuff */
#define PIC_MASTER_CMD  0x20
#define PIC_MASTER_DATA 0x21
#define PIC_SLAVE_CMD   0xA0
#define PIC_SLAVE_DATA  0xA1
#define PIC_EOI         0x20

#define GDT_SELECTOR    0x08

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

void kernel_main(void);
void pic_remap();
void idt_init();
void set_idt_gate(uint8_t vector, void* handler, uint16_t selector, uint8_t attr);

uint16_t get_uptime_seconds();
void kernel_panic(void);
void fs_list_root(void);

#endif