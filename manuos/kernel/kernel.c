/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025 Benjamin Helle
 */

#include "../../include/manuos/kernel/kernel.h"
#include "../../include/manuos/kernel/ff.h"
#include "../../include/manuos/kernel/video.h"
#include "../../include/manuos/kernel/kb.h"
#include "../../include/manuos/kernel/syscall.h"


extern void syscall_dispatch(void);

/* Our filesystem, FAT12 */
static FATFS fs;

struct isr_t idt[256];    /* IDT entries */
struct idt_ptr_t idt_ptr; /* IDT pointer */

extern void test_syscall(void);
extern void kb_isr(void);

/*kernel init stuff*/
void kernel_main(void) {
  video_init();

  char kernel_msg[32] = "Manux Kernel ";
  strcat(kernel_msg, KERNEL_VER_STR);
  strcat(kernel_msg, "\n");
  printk(kernel_msg);

  idt_init();
  pic_remap();

  /* Set main syscall handler*/
  set_idt_gate(0x80, syscall_dispatch, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x21, kb_isr, GDT_SELECTOR, 0x8E);

  asm volatile("sti");
  printk(" Set interrupt handlers\n");

  /* Test syscall */
  test_syscall();

  FRESULT res = f_mount(&fs, "/", 1);

  if(res != FR_OK) {
    printk(" FAT12 failed to initialize\n");
    kernel_panic();
  }
  printk(" FAT12 initialized\n");
  printk(" Welcome to MANUOS2\n");

  //fs_list_root();

  /*Test read file, if it doesn't exist please create it :)*/
  char filebuf[32] = {0};
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

  puts("Read len: ");
  putlong(len);
  newline();

  if(res != FR_OK) {
    printk(" Failed to read TESTI.TXT\n");
    kernel_panic();
  }

  f_close(&f);

  prints(filebuf);

  kernel_panic(); /* kernel main should never return */
}

void fs_list_root(void) {
  puts("Listing root\n");
  DIR dir;
  FILINFO fno;
  FRESULT res = f_opendir(&dir, "");

  if (res != FR_OK) {
    puts("opendir failed with code ");
    puth(res);
    return;
  }

  while (1) {
    if (f_readdir(&dir, &fno) != FR_OK || fno.fname[0] == 0)
        break;

    //printk("%s  %lu\n", fno.fname, (unsigned long)fno.fsize);

    puts("Name: ");
    puts((char*)fno.fname);
    puts(" Size: ");
    putlong(fno.fsize);
    newline();


  }

  f_closedir(&dir);
  puts("Done\n");
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
    set_idt_gate(i, default_isr, GDT_SELECTOR, 0x8E);
  }

  /* Set all IRSs that use error code, pretty inefficient and ugly*/
  set_idt_gate(0x08, default_isr_code, GDT_SELECTOR, 0x8E);
  for (int i = 0x0A; i < 0x0F; i++) {
    set_idt_gate(i, default_isr_code, GDT_SELECTOR, 0x8E);
  }
  set_idt_gate(0x11, default_isr_code, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x15, default_isr_code, GDT_SELECTOR, 0x8E);

  /* Set IQRs for the PIC*/
  for (int i = 0; i < 16; i++) {
    set_idt_gate(i + 0x20, default_irq, GDT_SELECTOR, 0x8E);
  }

  /* Load the IDT */
  asm volatile("lidt %0" : : "m"(idt_ptr) : "memory");
  puts(" IDT Loaded with base 0x");
  puth(idt_ptr.base);
  puts(" and limit ");
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
  puts("\nKERNEL PANIC!\n");
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
  puts("EAX: ");
  puth(eax);
  puts(" EBX: ");
  puth(ebx);
  puts(" ECX: ");
  puth(ecx);
  puts(" EDX: ");
  puth(edx);
  puts(" ESI: ");
  puth(esi);
  puts(" EDI: ");
  puth(edi);
  puts(" ESP: ");
  puth(esp);
  puts(" EBP: ");
  puth(ebp);
  puts("\nEIP: ");
  puth(eip);
  puts(" ES: ");
  puth(es);
  puts(" DS: ");
  puth(ds);
  puts(" SS: ");
  puth(ss);
  puts(" CS: ");
  puth(cs);
  while (1); /* hang */
}