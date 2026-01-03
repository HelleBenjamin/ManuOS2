/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/unistd.h"

int read(int fd, void *buf, size_t count) {
  syscall(SYS_READ, (int)buf, (int)count, (int)fd);
}