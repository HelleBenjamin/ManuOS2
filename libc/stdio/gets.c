/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/stdio.h"
#include "../include/unistd.h"

/* Unsafe function! */
int gets(char *str) {
  char c = 0;
  int i;
  while (c != '\n') {
    read(STDIN_FILENO, &c, 1);
    str[i] = c;
    i++;
  }
  return i;
}