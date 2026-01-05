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
uint32_t page_dir[1024]         __attribute__((aligned(4096)));
uint32_t first_page_table[1024] __attribute__((aligned(4096)));
uint32_t *page_tables[1024]     __attribute__((aligned(4096)));

static uint8_t phys_mem_bitmap[MAX_PAGES / 8];
static uint32_t pages_num;
static uint32_t free_pages_num;

static uint32_t kheap = KERNEL_HEAP;

/* Provided by the linker :)*/
extern uint32_t _kend;
extern uint32_t _kstart;

static inline void set_bit(uint32_t i)   { phys_mem_bitmap[i/8] |=  (1 << (i%8)); }
static inline void clear_bit(uint32_t i) { phys_mem_bitmap[i/8] &= ~(1 << (i%8)); }
static inline int  test_bit(uint32_t i)  { return phys_mem_bitmap[i/8] & (1 << (i%8)); }


extern void test_syscall(void);
extern void kb_isr(void);
extern void dbz_handler(void);
extern void of_handler(void);
extern void illop_handler(void);
extern void df_handler(void);
extern void gp_handler(void);
extern void pf_handler(void);

/* All kernel related stuff should use printk instead of puts */

/*kernel init stuff*/
void kernel_main() {
  dump_pinfo();

  /* Map kernel heap*/
  map_page(KERNEL_HEAP, alloc_page(), 3);

  /* Test heap */
  uint32_t *test = kmalloc(4);
  *test = 0xDEADBEEF; /* I know that's funny*/
  if (*test != 0xDEADBEEF) {
    printk(" kmalloc test failed\n");
    kernel_panic();
  }
  printk(" kmalloc test passed\n");
  kfree(test);

  asm volatile("sti"); /* Interrupts on after tests passed*/

  /* Test syscall */
  //test_syscall();

  FRESULT res = f_mount(&fs, "/", 1);

  if(res != FR_OK) {
    printk(" FAT12 failed to initialize\n");
    kernel_panic();
  }
  printk(" FAT12 initialized\n");
  printk(" Welcome to MANUOS2\n");

  /* Launch shell*/
  FIL shell = {0};
  res = f_open(&shell, "/bin/shell.bin", FA_READ);

  if(res != FR_OK) {
    printk(" Failed to open shell.bin\n");
    kernel_panic();
  }

  size_t src_len = f_size(&shell);

  uint8_t* dest = kmalloc(src_len);
  //uint8_t dest[32*1024];
  res = f_read(&shell, dest, 2048, NULL);

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

void* kmalloc(size_t size) {
  size = (size + PAGE_SIZE-1) & ~(PAGE_SIZE-1);
  uint32_t base = kheap;
  for (uint32_t i = 0; i < size; i += PAGE_SIZE) {
    uint32_t physm = alloc_page();
    if (!physm) {
      printk("kmalloc null page\n");
      kernel_panic();
    }
    map_page(base + i, physm, 3);
  }
  kheap += size;
  return (void*)base;
}

void kfree(void *ptr) {
  uint32_t base = (uint32_t)ptr;
  for (uint32_t i = 0; i < (kheap - base); i += PAGE_SIZE) {
    free_page(virt_to_phys(base + i));
    unmap_page(base + i);
  }
  kheap = base;
}

uint32_t alloc_kstack() {
  uint32_t stop = KSTACK_TOP;
  for (int i = 0; i < (KSTACK_SIZE / PAGE_SIZE); i++) {
    uint32_t physm = alloc_page();
    if(!physm) {
      kernel_panic(); /* KP if no free pages*/
    }
    uint32_t virtm = stop - (i+1) * PAGE_SIZE;
    map_page(virtm, physm, 3);
  }
  return stop;
}

void page_init(uint32_t mbh) {
  mb_info* mb = (mb_info*)mbh; /* Multiboot header*/

  if (!(mb->flags & (1 << 6))) {
    printk(" No memory map\n");
    kernel_panic(); /* Panic if not mmap found */
  }
  
  /* Zero all */
  memset(page_dir, 0, sizeof(page_dir));

  for (int i = 0; i < 1024; i++) {
    first_page_table[i] = (i * 0x1000) | 3;
  }

  page_tables[0] = (uint32_t*)first_page_table; /* Set the first page*/

  for (int i = 0; i < 1024; i++) {
    page_tables[0][i] = (i * 0x1000) | 3; /* Set the first page*/
  }

  /* Set the first page*/
  page_dir[0] = ((uint32_t)page_tables[0]) | 3;

  memset(phys_mem_bitmap, 0xFF, sizeof(phys_mem_bitmap)); /* Set all to usable*/
  reserve_range(&page_dir, sizeof(page_dir)); /* Then reserve the important things*/
  reserve_range(&first_page_table, sizeof(first_page_table));
  reserve_range(&page_tables, sizeof(page_tables));
  reserve_range(phys_mem_bitmap, sizeof(phys_mem_bitmap));
  reserve_range(mb, sizeof(*mb));

  for (uint32_t i = 0; i < mb->mmap_len; i += sizeof(mb_mmap_entry)) {
    mb_mmap_entry *entry = (mb_mmap_entry*)(mb->mmap_addr + i);

    if (entry->type == 1) {
      /* Set all pages */
      for (uint64_t addr = entry->addr; addr < entry->addr + entry->len; addr += PAGE_SIZE) {
        uint32_t page = (addr & 0xFFFFFFFF) / PAGE_SIZE;
        clear_bit(page);
        free_pages_num++;
        pages_num++;
      }
    }
  }

  /* Mark the kernel region as used*/
  uint32_t kernel_end = ((uint32_t)&_kend) / PAGE_SIZE; 
  for (uint32_t i = 0; i <= kernel_end; i++) {
    if (i < MAX_PAGES && !test_bit(i)) {
      set_bit(i);
      free_pages_num--;
    }
  }
  /* Some how this works I guess*/
  map_page(VGA_VIRT, 0x00b8000, 3);
  vmp = (char*)VGA_PHYS; /* Set the vmp to virtual address*/
 
  /* Map the kernel*/
  uint32_t physm = (uint32_t)&_kstart;
  uint32_t virtm = KERNEL_VIRT;
  for (; physm < _kend; physm += PAGE_SIZE, virtm += PAGE_SIZE) { /* Loop through the kernel*/
    map_page(virtm, physm, 3);
  }

}

uint32_t alloc_page() {
  if (free_pages_num == 0) { /* Fast check if free pages available*/
    printk(" No free pages\n");
    return 0;
  }

  /* Search for a free page */
  for (int i = 0; i < MAX_PAGES; i++) {
    if (!test_bit(i)) {
      set_bit(i);
      free_pages_num--;
      return i * PAGE_SIZE;
    }
  }

  return 0; /* No free pages*/
}

void free_page(uint32_t addr) {
  clear_bit(addr / PAGE_SIZE);
  free_pages_num++;
}

void map_page(uint32_t virt_addr, uint32_t phys_addr, uint32_t flags) {
  uint32_t page_dir_var = virt_addr >> 22;
  uint32_t page_table_var = (virt_addr >> 12) & 0x3FF;
  if (!(page_dir[page_dir_var] & 1)) {
    uint32_t pt_phys = alloc_page();
    if(pt_phys == 0) {
      printk(" Failed allocate page on map_page\n");
      dump_pinfo();
      kernel_panic();
    }

    memset((void*)pt_phys, 0, PAGE_SIZE);

    page_dir[page_dir_var] = pt_phys | 3;
    page_tables[page_dir_var] = (uint32_t*)pt_phys;
  }

  page_tables[page_dir_var][page_table_var] = (phys_addr & 0xFFFFF000) | (flags & 0x0F) | PAGE_PRESENT;
  asm volatile(
    "invlpg (%0)" :: "r"(virt_addr)
  );
}

void unmap_page(uint32_t virt_addr) {
  uint32_t page_dir_var = virt_addr >> 22;
  uint32_t page_table_var = (virt_addr >> 12) & 0x3FF;
  page_tables[page_dir_var][page_table_var] = 0;
  asm volatile(
    "invlpg (%0)" :: "r"(virt_addr)
  );
}

void dump_pinfo() {
  printk(" Free pages: ");
  puth(free_pages_num);
  printk(" Total pages: ");
  puth(pages_num);
  newline();
}

/* Use this to reserve important things from page allocator*/
void reserve_range(void *addr, size_t size) {
  uint32_t start = (uint32_t)addr / PAGE_SIZE;
  uint32_t end   = ((uint32_t)addr + size + PAGE_SIZE - 1) / PAGE_SIZE;
  for (uint32_t i = start; i < end; i++) {
    if (!test_bit(i)) {
      set_bit(i);
      free_pages_num--;
    }
  }
}

uint32_t virt_to_phys(uint32_t virt) {
  uint32_t pd = virt >> 22;
  uint32_t pt = (virt >> 12) & 0x3FF;
  return page_tables[pd][pt] & 0xFFFFF000;
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
  for (int i = 0x0A; i < 0x0F; i++) {
    set_idt_gate(i, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);
  }
  set_idt_gate(0x11, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);
  set_idt_gate(0x15, default_isr_code, GDT_SELECTOR, GATE_INTERRUPT);

  /* Set IQRs for the PIC*/
  for (int i = 0; i < 16; i++) {
    set_idt_gate(i + 0x20, default_irq, GDT_SELECTOR, GATE_INTERRUPT);
  }

  /* Set handlers */
  set_idt_gate(0x80, syscall_dispatch, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x21, kb_isr, GDT_SELECTOR, 0x8E);
  /* Exception handlers */
  set_idt_gate(0x00, dbz_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x04, of_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x06, illop_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x08, df_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x0D, gp_handler, GDT_SELECTOR, 0x8E);
  set_idt_gate(0x0E, pf_handler, GDT_SELECTOR, 0x8E);

  /* Load the IDT */
  asm volatile("lidt %0" : : "m"(idt_ptr) : "memory");
  printk(" IDT Loaded with physical base 0x");
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

void stack_trace() {
   uint32_t addr;
  uint32_t val;
  asm volatile("mov %%esp, %0" : "=r"(addr) : ); /* Move initial address*/
  printk("--STACKTRACE--");
  for (int i = 0; i < 5; i++) {
    //asm volatile("mov *(%0), %1" : "=r"(addr), "=r"(val) :);
    puth(addr);
    printk(": ");
    puth(val);
    newline();
  }
}