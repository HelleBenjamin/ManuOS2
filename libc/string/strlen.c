/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/string.h"

int strlen(const char *str) {
  unsigned int i = 0;
  while (str[i]) {
    i++;
  }
  return i;
}