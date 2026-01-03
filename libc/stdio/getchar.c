/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/stdio.h"
#include "../include/unistd.h"
#include "../include/string.h"

int getchar(void) {
  int c = 0;
  return read(STDIN_FILENO, &c, 1);
}