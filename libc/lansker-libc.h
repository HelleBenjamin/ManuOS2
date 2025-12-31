#ifndef LANSKER_LIBC_H
#define LANSKER_LIBC_H

#if defined(__cplusplus)
extern "C" {
#endif

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long long int64_t;
typedef __SIZE_TYPE__ size_t;

#ifndef NULL
#define NULL (void *)0
#endif
#define true 1
#define false 0

#ifndef va_list
typedef __builtin_va_list va_list;
#endif
#ifndef va_start
#define va_start(ap, param) __builtin_va_start(ap, param)
#endif
#ifndef va_end
#define va_end(ap) __builtin_va_end(ap)
#endif
#ifndef va_arg
#define va_arg(ap, type) __builtin_va_arg(ap, type)
#endif



/* IO */
void putc(char c);
void puts(char *s);
void puth(uint32_t n);
void putdec(uint8_t n);
void putlong(unsigned long n);
void printk(char *s);
char getc(void);
char *gets(char *s); /* Unsafe */
char *getsn(char *s, size_t n);

/* str stuff */
short strcmp(const char *str1, const char *str2); 
void strcpy(char *dest, const char *src);
void strcat(char *dest, const char *src);
short strlen(const char *str);
short startsWith(const char *str1, const char *str2);
char *strncpy(char *dest, const char *src, int n);
void* memset(void* s, int c, size_t n);
void* memcpy(void* dest, const void* src, size_t n);
int memcmp(const void *s1, const void *s2, size_t n);
int strncmp(const char *str1, const char *str2, size_t n);
char *strchr(const char *str, int c);
int atoi(const char *str);
long int strtol(const char *str, char **endptr, int base);

#if defined(__cplusplus)
} /* extern "C" */
#endif

#endif