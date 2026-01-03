/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#pragma once

#ifndef STRING_H
#define STRING_H

#define	__need_size_t
#define __need_NULL
#include <stddef.h>

extern int strcmp(const char *str1, const char *str2);
extern int strcpy(char *dest, const char *src);
extern int strcat(char *dest, const char *src);
extern int strlen(const char *str);
extern char *strchr(const char *s, int c);

extern void* memcpy(void *dest, const void *src, size_t n);
extern void* memset(void *s, int c, size_t n);
extern int memcmp(const void *s1, const void *s2, size_t n);

#endif