#ifndef VIDEO_H
#define VIDEO_H

/* Video driver */

#include <stdint.h>

extern char *vmp;

#define VGA_WIDTH     80
#define VGA_HEIGHT    25

#define VGA_PORT_CTRL 0x3D4
#define VGA_PORT_DATA 0x3D5

enum {
  COLOR_BLACK = 0,
  COLOR_BLUE,
  COLOR_GREEN,
  COLOR_CYAN,
  COLOR_RED,
  COLOR_MAGENTA,
  COLOR_YELLOW,
  COLOR_LIGHT_GRAY,
  COLOR_GRAY = 8,
  COLOR_LIGHT_BLUE,
  COLOR_LIGHT_GREEN,
  COLOR_LIGHT_CYAN,
  COLOR_LIGHT_RED,
  COLOR_LIGHT_MAGENTA,
  COLOR_LIGHT_YELLOW,
  COLOR_WHITE
};


void video_init();
void clear(void);
void printc(char c);
void prints(char *str);
void printslen(char *str, int len);
void printi(int i);
void puth(uint32_t n);
void putdec(uint8_t n);
void putlong(unsigned long n);
void set_color(uint8_t fg, uint8_t bg);
void put_pixel(int x, int y, unsigned int color);
unsigned int get_pixel(int x, int y);
void newline(void);
void update_cursor();
void backspace(void);

/*New functions */
int get_pos(int x, int y);
int get_row(int pos);
int get_cursor(void);
void set_cursor(int pos);
int scroll(void);

#endif