/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

char *strchr(const char *str, int c) {
  while (*str) {
    if (*str == c) {
      return (char*)str;
    }
    str++;
  }
  return NULL;
}