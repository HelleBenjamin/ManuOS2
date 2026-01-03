/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

void* memset(void* s, int c, size_t n) {
  for (size_t i = 0; i < n; i++) {
    ((char*)s)[i] = c;
  }
  return s;
}