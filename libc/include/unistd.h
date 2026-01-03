/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#pragma once

#ifndef _UNISTD_H
#define _UNISTD_H

/*
  Very small POSIX API implementation.
*/

#define	__need_size_t
#define __need_NULL
#include <stddef.h>


#ifndef pid_t
#define pid_t int
#endif

#ifndef STDIN_FILENO
#define STDIN_FILENO 0
#endif
#ifndef STDOUT_FILENO
#define STDOUT_FILENO 1
#endif
#ifndef STDERR_FILENO
#define STDERR_FILENO 2
#endif

/* System calls */
#define SYS_EXIT      0
#define SYS_WRITE     1
#define SYS_READ      2
#define SYS_OPEN      3
#define SYS_CLOSE     4
#define SYS_EXEC      5
#define SYS_FORK      6

/* Syscall wrapper */
int syscall(int num, int arg1, int arg2, int arg3);

/* POSIX-compatible functions */
extern void _exit(int code);
extern int read(int fd, void *buf, size_t count);
extern int write(int fd, const void *buf, size_t count);
extern pid_t fork(void);
extern pid_t getpid(void);
extern int close(int fd);

#endif