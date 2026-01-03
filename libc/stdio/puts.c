/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/stdio.h"
#include "../include/unistd.h"
#include "../include/string.h"

int puts(const char *str) {
  size_t len = strlen(str);
  return write(STDOUT_FILENO, str, len);
}