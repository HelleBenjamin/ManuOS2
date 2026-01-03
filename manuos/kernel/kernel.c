/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../../include/manuos/kernel/kernel.h"
#include "../../include/manuos/kernel/ff.h"
#include "../../include/manuos/kernel/video.h"
#include "../../include/manuos/kernel/kb.h"
#include "../../include/manuos/kernel/syscall.h"
#include <stdint.h>
#include <string.h>


extern void syscall_dispatch(void);

/* Our filesystem, FAT12 */
static FATFS fs;

/* IDT stuff */
struct isr_t idt[256];    /* IDT entries */
struct idt_ptr_t idt_ptr; /* IDT pointer */

/* Page stuff */
uint32_t page_dir[1024] __attribute__((aligned(4096)));
uint32_t first_page[1024] __attribute__((aligned(4096)));

extern void test_syscall(void);
extern void kb_isr(void);
extern void dbz_handler(void);
extern void pf_handler(void);

/* All kernel related stuff should use printk instead of puts */

/*kernel init stuff*/
void kernel_main(void) {

  video_init();

  char kernel_msg[32] = " Manux Kernel ";
  strcat(kernel_msg, KERNEL_VER_STR);
  strcat(kernel_msg, "\n");
  printk(kernel_msg);

  idt_init();
  pic_remap();

  /* Set handlers */
  set_idt_gate(0x80, syscall_dispatch, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x21, kb_isr, GDT_SELECTOR, 0x8E);
  /* Exception handlers */
  set_idt_gate(0x00, dbz_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x0E, pf_handler, GDT_SELECTOR, 0x8E);

  asm volatile("sti");
  printk(" Set interrupt handlers\n");

  /* Test syscall */
  //test_syscall();

  FRESULT res = f_mount(&fs, "/", 1);

  if(res != FR_OK) {
    printk(" FAT12 failed to initialize\n");
    kernel_panic();
  }
  printk(" FAT12 initialized\n");
  printk(" Welcome to MANUOS2\n");

  //fs_list_root();

  /*Test read file, if it doesn't exist please create it :)*/
  /*char filebuf[32] = {0};
  FIL f = {0};
  res = f_open(&f, "testi.txt", FA_READ);
  putlong(res);
  newline();
  if(res != FR_OK) {
    printk(" Failed to open TESTI.TXT\n");
    kernel_panic();
  }

  UINT len;
  res = f_read(&f, filebuf, 32, &len);
  putlong(res);
  newline();

  printk("Read len: ");
  putlong(len);
  newline();

  if(res != FR_OK) {
    printk(" Failed to read TESTI.TXT\n");
    kernel_panic();
  }

  f_close(&f);

  prints(filebuf);*/

  /* Launch shell*/
  FIL shell = {0};
  res = f_open(&shell, "/bin/shell.bin", FA_READ);

  if(res != FR_OK) {
    printk(" Failed to open shell.bin\n");
    kernel_panic();
  }

  uint8_t dest[1024] = {0};
  size_t src_len;
  res = f_read(&shell, dest, 1024, &src_len);

  if (res != FR_OK) {
    printk(" Failed to read shell.bin\n");
    kernel_panic();
  }

  f_close(&shell);

  /* TODO: Make the shell run in usermode(ring 3)*/
  entry_func_t shell_entry = (entry_func_t)dest;
  shell_entry();


  kernel_panic(); /* kernel main should never return */
}

void page_init() {

  for (int i = 1; i < 1024; i++) {
    page_dir[i] = 2; /* No page*/
  }

  for (int i = 0; i < 1024; i++) {
    first_page[i] = (i * 0x1000) | 3;
  }

  /* Set the first page*/
  page_dir[0] = ((uint32_t)first_page) | 3;


  /* Set the kernel page*/
  page_dir[KERNEL_VIRT >> 22] = (uint32_t)first_page | PAGE_PRESENT | PAGE_RW;

  /* Set the video page*/
  page_dir[VGA_VIRT >> 22] = (uint32_t)first_page | PAGE_PRESENT | PAGE_RW;
}


void printk(char *s) {
  prints(s); /* Talks directly to the video driver*/
}

void fs_list_root(void) {
  printk("Listing root\n");
  DIR dir;
  FILINFO fno;
  FRESULT res = f_opendir(&dir, "");

  if (res != FR_OK) {
    printk("opendir failed with code ");
    puth(res);
    return;
  }

  while (1) {
    if (f_readdir(&dir, &fno) != FR_OK || fno.fname[0] == 0)
        break;

    //printk("%s  %lu\n", fno.fname, (unsigned long)fno.fsize);

    printk("Name: ");
    printk((char*)fno.fname);
    printk(" Size: ");
    putlong(fno.fsize);
    newline();


  }

  f_closedir(&dir);
  printk("Done\n");
}

/* Remap the pic,*/
void pic_remap() {

  /* Remove all depending interrupts*/
  outb(PIC_MASTER_CMD, 0x20);
  io_wait(); /* Wait for some slow devices*/
  outb(PIC_SLAVE_CMD, 0x20);

  uint8_t offset1 = 0x20; /* Remap to 0x20-0x27*/
  uint8_t offset2 = 0x28; /* Remap to 0x28-0x2F*/

  uint8_t mask1 = inb(PIC_MASTER_DATA);
  uint8_t mask2 = inb(PIC_SLAVE_DATA);

  /* Do some stuff*/
  outb(PIC_MASTER_CMD, 0x11);
  io_wait();
  outb(PIC_SLAVE_CMD, 0x11);
  io_wait();

  outb(PIC_MASTER_DATA, offset1);
  io_wait();
  outb(PIC_SLAVE_DATA, offset2);
  io_wait();

  outb(PIC_MASTER_DATA, 4);
  io_wait();
  outb(PIC_SLAVE_DATA, 2);
  io_wait();

  outb(PIC_MASTER_DATA, 1);
  io_wait();
  outb(PIC_SLAVE_DATA, 1);

  outb(PIC_MASTER_DATA, 0xfd); /* Allow keyboard only */
  io_wait();
  outb(PIC_SLAVE_DATA, 0xff);

}

/* Export assembly functions*/
extern void default_isr(void);
extern void default_isr_code(void);
extern void default_irq(void);

void idt_init() {
  idt_ptr.limit = sizeof(idt) - 1;
  idt_ptr.base = (uint32_t)&idt;

  /* Set all IDT entries to default handler */
  for (int i = 0; i < 256; i++) {
    set_idt_gate(i, default_isr, GDT_SELECTOR, GATE_INTERRUPT);
  }

  /* Set all IRSs that use error code, pretty inefficient and ugly*/
  set_idt_gate(0x08, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);
  for (int i = 0x0A; i < 0x0F; i++) {
    set_idt_gate(i, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);
  }
  set_idt_gate(0x11, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);
  set_idt_gate(0x15, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);

  /* Set IQRs for the PIC*/
  for (int i = 0; i < 16; i++) {
    set_idt_gate(i + 0x20, default_irq, GDT_SELECTOR, GATE_INTERRUPT);
  }

  /* Load the IDT */
  asm volatile("lidt %0" : : "m"(idt_ptr) : "memory");
  printk(" IDT Loaded with base 0x");
  puth(idt_ptr.base);
  printk(" and limit ");
  putlong(idt_ptr.limit);
  printk(" Done\n");
}

/* Setup interrupt*/
void set_idt_gate(uint8_t vector, void* handler, uint16_t selector, uint8_t attr) {
  uint32_t base = (uint32_t)handler;
  idt[vector].offset1   = base & 0xFFFF;
  idt[vector].selector  = selector;
  idt[vector].null      = 0;
  idt[vector].attr      = attr;
  idt[vector].offset2   = (base >> 16) & 0xFFFF;
}

void kernel_panic() {
  printk("\nKERNEL PANIC!\n");
  uint32_t eax, ecx, edx, ebx, esi, edi, esp, ebp, eip, es, ds, ss, cs;
  asm volatile(
    /* save general registers into memory operands (16-bit portion) */
    "movl %%eax, %1\n\t"
    "movl %%ecx, %2\n\t"
    "movl %%edx, %3\n\t"
    "movl %%ebx, %4\n\t"
    "movl %%esi, %5\n\t"
    "movl %%edi, %6\n\t"

    /* read stack/frame pointers (SP/BP) */
    "movl %%esp, %7\n\t"
    "movl %%ebp, %8\n\t"

    /* read segment registers ES,DS,SS,CS via mov to general reg then store */
    "movl $0x00000000, %%eax\n\t"
    "movl %%es, %%eax\n\t"
    "movl %%eax, %9\n\t"
    "movl %%ds, %%eax\n\t"
    "movl %%eax, %10\n\t"
    "movl %%ss, %%eax\n\t"
    "movl %%eax, %11\n\t"
    "movl %%cs, %%eax\n\t"
    "movl %%eax, %12\n\t"

    /* read instruction pointer*/
    "pushl %%eax\n\t"
    "call dummy\n\t"
    "dummy:\n\t"
    "pop %%eax\n\t"
    "movl %%eax, %13\n\t"
    "pop %%eax\n\t"

    :
    : "i"(0x01)
    , "m"(eax), "m"(ecx), "m"(edx), "m"(ebx), "m"(esi), "m"(edi)
    , "m"(esp), "m"(ebp), "m"(es), "m"(ds), "m"(ss), "m"(cs),"m"(eip)
    : "cc", "memory"
  );
  printk("EAX: ");
  puth(eax);
  printk(" EBX: ");
  puth(ebx);
  printk(" ECX: ");
  puth(ecx);
  printk(" EDX: ");
  puth(edx);
  printk(" ESI: ");
  puth(esi);
  printk(" EDI: ");
  puth(edi);
  printk(" ESP: ");
  puth(esp);
  printk(" EBP: ");
  puth(ebp);
  printk("\nEIP: ");
  puth(eip);
  printk(" ES: ");
  puth(es);
  printk(" DS: ");
  puth(ds);
  printk(" SS: ");
  puth(ss);
  printk(" CS: ");
  puth(cs);
  while (1); /* hang */
}