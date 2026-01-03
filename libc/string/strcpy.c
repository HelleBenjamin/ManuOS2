/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

int strcpy(char *dest, const char *src) {
  while ((*dest = *src)) {
    dest++;
    src++;
  }
  *dest = '\0';
  return 0;
}