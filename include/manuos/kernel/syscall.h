#ifndef SYSCALL_H
#define SYSCALL_H

#include <stdint.h>

#define SYS_EXIT      0
#define SYS_WRITE     1
#define SYS_READ      2
#define SYS_OPEN      3
#define SYS_CLOSE     4
#define SYS_EXEC      5
#define SYS_FORK      6

/* Use these if possible*/
int sys_write(uint8_t fd, char *buf, uint32_t len);
int sys_read(uint8_t fd, char *buf, uint32_t len);

#endif