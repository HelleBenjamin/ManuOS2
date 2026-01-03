/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/unistd.h"

int syscall(int num, int arg1, int arg2, int arg3) {
  int ret;
  asm volatile(
    "int $0x80\n"
    : "=a"(ret)
    : "a"(num), "b"(arg1), "c"(arg2), "d"(arg3)
  );
  return ret;
}