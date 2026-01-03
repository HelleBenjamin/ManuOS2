/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

void* memcpy(void* dest, const void* src, size_t n) {
  register char* d = (char*)dest;
  register const char* s = (char*)src;
  for (size_t i = 0; i < n; i++) {
    d[i] = s[i];
  }
  return dest;
}