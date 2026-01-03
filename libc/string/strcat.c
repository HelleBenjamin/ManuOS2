/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

int strcat(char *dest, const char *src) {
  while (*dest) {
    dest++;
  }
  strcpy(dest, src);
  return 0;
}