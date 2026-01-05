/* SPDX-License-Identifier: GPL-2.0-or-later
 * Copyright (c) 2025-2026 Benjamin Helle
 */

#include "../include/stdio.h"
#include "../include/stdarg.h"
#include "../include/stdint.h"


int printi(int i) {
  char buf[10];
  int j = 0;
  if (i < 0) {
    putchar('-');
    i *= -1;
  }
  while (i > 0) {
    buf[j++] = i % 10 + '0';
    i /= 10;
  }
  while (j > 0) {
    putchar(buf[--j]);
  }
  return j;
}

void puth(uint32_t n) { 
  volatile char started = 0; /* Compiler optimizations fucks up this one, use volatile here */
  for (short i = 28; i >= 0; i -= 4) {
    volatile char digit = (n >> i) & 0xF;
    if (digit > 0 || started || i == 0) {
      volatile char char_digit = (digit < 10) ? ('0' + digit) : ('A' + digit - 10);
      putchar(char_digit);
      started = 1;
    }
  }
}

void putlong(unsigned long n) {
  static unsigned long powers[] = {1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1};
  short started = 0;
  for (char i = 0; i < 10; ++i) {
    char digit = 0;
    while (n >= powers[i]) {
      n -= powers[i];
      ++digit;
    }
    if (digit > 0 || started || i == 9) {
      char char_digit = '0' + digit;
      putchar(char_digit);
      started = 1;
    }
  }
}

/*int printf(const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);

  char buf[1024];
  int i = 0;

  while (*fmt != '\0') {
    if (*fmt == '%' && *(fmt + 1) != '\0') {
      ++fmt;  // advance past '%'
      char spec = *fmt;

      switch (spec) {
        case 'c': {
          char c = (char)va_arg(args, int);
          putchar(c);
          i++;
          break;
        }
        case 's': {
          char *fmt = va_arg(args, char*);
          if (fmt) {
            while (*fmt) {
              putchar(*fmt++);
              i++;
            }
          }
          break;
        }
        case 'd': {
          int num = va_arg(args, int);
          i += printi(num);  // assumes printi returns char count
          break;
        }
        case 'u': {
          unsigned int num = va_arg(args, unsigned int);
          i += printi(num);
          break;
        }
        case 'x': {
          unsigned int num = va_arg(args, unsigned int);
          putchar('0');
          putchar('x');
          i += 2;

          // Extract and print hex digits in correct order
          int shift = 28;
          int started = 0;
          for (; shift >= 0; shift -= 4) {
            unsigned int digit = (num >> shift) & 0xf;
            if (digit || started || shift == 0) {
              putchar("0123456789abcdef"[digit]);
              i++;
              started = 1;
            }
          }
          break;
        }
        case '%': {
          putchar('%');
          i++;
          break;
        }
        default: {
          putchar('%');
          putchar(spec);
          i += 2;
          break;
        }
      }
    } else {
      putchar(*fmt);
      i++;
    }
    ++fmt;
  }
 
  va_end(args);
  return 0;
}*/


/* Example taken from https://www.geeksforgeeks.org/c/how-to-write-your-own-printf-in-c/
  Im too lazy to write my own printf
  Currently doesn't work, gives page fault or illop
*/
int printf(const char* fmt, ...) {
  // initializing list pointer
  puts("Init printf\n");
  va_list ptr;
  va_start(ptr, fmt);
  puts("Done\n");

  // char array to store token
  char token[1000];
  // index of where to store the characters of fmt in
  // token
  int k = 0;

  // parsing the formatted string
  for (int i = 0; fmt[i] != '\0'; i++) {
    token[k++] = fmt[i];

    if (fmt[i + 1] == '%' || fmt[i + 1] == '\0') {
      token[k] = '\0';
      k = 0;
      if (token[0] != '%') {
        puts(token);
      }
      else {
        int j = 1;
        char ch1 = 0;

        // this loop is required when printing
        // formatted value like 0.2f, when ch1='f'
        // loop ends
        while ((ch1 = token[j++]) < 58) {
        }
        // for integers
        if (ch1 == 'i' || ch1 == 'd' || ch1 == 'u' || ch1 == 'h') {
          printi(va_arg(ptr, int));
        }
        // for characters
        else if (ch1 == 'c') {
          putchar(va_arg(ptr, int));
        }
        // for float values
        else if (ch1 == 'f') {
          /* TODO*/
        }
        else if (ch1 == 'l') {
          char ch2 = token[2];

          // for long int
          if (ch2 == 'u' || ch2 == 'd' || ch2 == 'i') {
            putlong(va_arg(ptr, long));
          }

          // for double
          else if (ch2 == 'f') {
            /*TODO*/
          }
        }
        else if (ch1 == 'L') {
          char ch2 = token[2];

          // for long long int
          if (ch2 == 'u' || ch2 == 'd' || ch2 == 'i') {
            putlong(va_arg(ptr, long long));
          }

          // for long double
          else if (ch2 == 'f') {
            /*TODO*/
          }
        }

        // for strings
        else if (ch1 == 's') {
          puts(va_arg(ptr, char*));
        }

        // print the whole token
        // if no case is matched
        else {
          puts(token);
        }
      }
    }
  }

  // ending traversal
  va_end(ptr);
  return 0;
}
