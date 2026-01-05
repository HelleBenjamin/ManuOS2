/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#pragma once

#ifndef STDIO_H
#define STDIO_H

extern int puts(const char *str);
extern int getchar(void);
extern int gets(char *str);
extern int printf(const char *format, ...);
extern int putchar(int c);

#endif