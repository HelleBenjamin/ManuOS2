/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/stdio.h"
#include "../include/unistd.h"
#include "../include/string.h"

int putchar(int c) {
  char ch = (char)c; 
  return write(STDOUT_FILENO, &ch, 1);
}