#include "lansker-libc.h"
#include "../include/manuos/kernel/kernel.h"
#include "../include/manuos/kernel/video.h"
/* IO */

void putc(char c) {
  printc(c);
}

void puts(char *s) {
  prints(s);
}

void printk(char *s) {
  prints(s);
}

void puth(uint32_t n) { 
  volatile char started = 0; /* Compiler optimizations fucks up this one, use volatile here */
  for (short i = 28; i >= 0; i -= 4) {
    volatile char digit = (n >> i) & 0xF;
    if (digit > 0 || started || i == 0) {
      volatile char char_digit = (digit < 10) ? ('0' + digit) : ('A' + digit - 10);
      putc(char_digit);
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
      putc(char_digit);
      started = 1;
    }
  }
}

short strcmp(const char *str1, const char *str2) { // string compare
    while (*str1 && *str1 == *str2) {
        str1++;
        str2++;
    }
    return *str1 - *str2;
}

void strcpy(char *dest, const char *src) {
    while ((*dest = *src)) {
        dest++;
        src++;
    }
    *dest = '\0';
}

void strcat(char *dest, const char *src) {
    while (*dest) {
        dest++;
    }
    strcpy(dest, src);
}

short strlen(const char *str) {
    unsigned int i = 0;
    while (str[i]) {
        i++;
    }
    return i;
}

short startsWith(const char *str1, const char *str2) {
    while (*str2 && *str1 == *str2) {
        str1++;
        str2++;
    }
    return *str2 != '\0';
}

char *strncpy(char *dest, const char *src, int n) {
    int i = 0;
    while (src[i] && i < n) {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return dest;
}

void* memset(void* s, int c, size_t n) {
    for (size_t i = 0; i < n; i++) {
        ((char*)s)[i] = c;
    }
    return s;
}

void* memcpy(void* dest, const void* src, size_t n) {
    char* d = (char*)dest;
    char* s = (char*)src;
    for (size_t i = 0; i < n; i++) {
        d[i] = s[i];
    }
    return dest;
}

int memcmp(const void *s1, const void *s2, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (((char*)s1)[i] != ((char*)s2)[i]) {
            return ((char*)s1)[i] - ((char*)s2)[i];
        }
    }
    return 0;
}
int strncmp(const char *str1, const char *str2, size_t n) {
    for (size_t i = 0; i < n; i++) {
        if (str1[i] != str2[i]) {
            return str1[i] - str2[i];
        }
    }
    return 0;
}

char *strchr(const char *str, int c) {
    while (*str) {
        if (*str == c) {
            return (char*)str;
        }
        str++;
    }
    return NULL;
}

int atoi(const char *str) {
    int num = 0;
    while (*str) {
        num = num * 10 + (*str - '0');
        str++;
    }
    return num;
}
