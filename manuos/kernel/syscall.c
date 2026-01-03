#include "../../include/manuos/kernel/kernel.h"
#include "../../include/manuos/kernel/syscall.h"
#include "../../include/manuos/kernel/video.h"
#include "../../include/manuos/kernel/kb.h"



int sys_write(uint8_t fd, char *buf, uint32_t len) {
  /*
    ecx = count
    edx = fd
    ebx = buf
  */

  if (fd == 1 || fd == 2) {
    printslen(buf, len);
    return len;
  } else { /* Add other logic here */
    return -1;
  }
}

int sys_read(uint8_t fd, char *buf, uint32_t len) {
  /*
    ecx = count
    edx = fd
    ebx = buf
  */
  
  if (fd == 0) {
    int i = 0;
    asm volatile("sti"); /* Enable interrupts so keyboard input works*/
    while (i < len) {
      char c = getchar();
      if (c != 0) {
        printc(c); /* Echo it */
        buf[i] = c;
        i++;
      }
    }
    asm volatile("cli");
    return i;
  } else { /* Add other logic here */
    return -1;
  }
}