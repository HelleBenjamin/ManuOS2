#include "../../include/manuos/kernel/kernel.h"
#include "../../include/manuos/kernel/syscall.h"
#include "../../include/manuos/kernel/video.h"
#include "../../include/manuos/kernel/kb.h"
#include "../../include/unistd.h"


int sys_write(uint8_t fd, char *buf, uint32_t len) {
  /*
    ecx = count
    edx = fd
    ebx = buf
  */

  if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
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
  
  if (fd == STDIN_FILENO) {
    int i = 0;
    asm volatile("sti");
    while (i < len) {
      asm volatile("hlt"); /* Wait for a key to be pressed */
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