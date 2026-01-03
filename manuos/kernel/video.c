#include "../../include/manuos/kernel/video.h"
#include "../../include/manuos/kernel/kernel.h"

char *vmp = (char *)VGA_VIRT;
static unsigned int current_fg;
static unsigned int current_bg;

void video_init(void) { // add more features later
  set_cursor(0);
  current_fg = COLOR_LIGHT_GRAY;
  current_bg = COLOR_BLACK;
  clear();
}

void newline(void) {
  int pos = get_cursor();
  pos = (pos / 160 + 1) * 160;
  set_cursor(pos);
}

void clear(void) {
  unsigned int j = 0;
  while(j < 80 * 25 * 2) {
    vmp[j] = ' '; // blank character
    vmp[j+1] = (current_bg << 4) |current_fg;
    j += 2;
  }
  set_cursor(0);
}

void prints(char *str) {
  unsigned int i = 0;
  int pos = get_cursor();
  while(str[i] != 0) {
    if (pos >= 80 * 25 * 2) {
      pos = scroll();
    }

    if (str[i] == '\n') {
      newline();
      i++;
      continue;
    }
    if (str[i] == 8) {
      backspace();
      i++;
      continue;
    }
    vmp[pos] = str[i];
    vmp[pos+1] = (current_bg << 4) |current_fg;
    pos += 2;
    i++;
    set_cursor(pos);
  }
}

void printslen(char *str, int len) {
  unsigned int i = 0;
  int pos = get_cursor();
  while(i < len) {
    if (pos >= 80 * 25 * 2) {
      pos = scroll();
    }
    if (str[i] == '\n') {
      newline();
      i++;
      continue;
    }
    vmp[pos] = str[i];
    vmp[pos+1] = (current_bg << 4) |current_fg;
    pos += 2;
    i++;
    set_cursor(pos);
  }
}

void printc(char c) {
  int pos = get_cursor();
  if (pos >= 80 * 25 * 2) {
    pos = scroll();
  }
  if (c == '\n') {
    newline();
    return;
  }
  vmp[pos] = c;
  vmp[pos+1] = (current_bg << 4) |current_fg;
  pos += 2;
  set_cursor(pos);
}

void printi(int i) {
  char buf[10];
  int j = 0;
  if (i < 0) {
    printc('-');
    i *= -1;
  }
  while (i > 0) {
    buf[j++] = i % 10 + '0';
    i /= 10;
  }
  while (j > 0) {
    printc(buf[--j]);
  }
}

void puth(uint32_t n) { 
  volatile char started = 0; /* Compiler optimizations fucks up this one, use volatile here */
  for (short i = 28; i >= 0; i -= 4) {
    volatile char digit = (n >> i) & 0xF;
    if (digit > 0 || started || i == 0) {
      volatile char char_digit = (digit < 10) ? ('0' + digit) : ('A' + digit - 10);
      printc(char_digit);
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
      printc(char_digit);
      started = 1;
    }
  }
}

void put_pixel(int x, int y, unsigned int color) {
  vmp[get_pos(x, y)] = ' ';
  vmp[get_pos(x, y) + 1] = color;
}


void backspace(void) {
  int pos = get_cursor();
  if (pos == 0) {
    return;
  }
  pos -= 2;
  vmp[pos] = ' ';
  vmp[pos+1] = (current_bg << 4) | current_fg;
  set_cursor(pos);

  /*if (cursor_position == 0) {
    return;
  }
  unsigned int x = (cursor_position / 2) - 1;
  unsigned int y = cursor_position / (2 * VGA_WIDTH);
  move_cursor(x, y);
  vmp[cursor_position-2] = ' ';
  vmp[cursor_position-1] = (current_bg << 4) | current_fg;
  cursor_position = cursor_position - 2;
  update_cursor();*/
}

void set_color(uint8_t fg, uint8_t bg) {
  current_fg = fg;
  current_bg = bg;
  return;
}

/* Helper functions */
int get_pos(int x, int y) {
  return (y * 80 * 2) + x;
}

int get_row(int pos) {
  return pos / (80 * 2);
}

int get_cursor() {
  outb(0x3D4, 0x0F);
  int pos = inb(0x3D5);
  outb(0x3D4, 0x0E);
  pos |= inb(0x3D5) << 8;
  return pos * 2;
}

void set_cursor(int pos) {
  pos /= 2;
  outb(0x3D4, 0x0F);
  outb(0x3D5, (uint8_t)(pos & 0xFF));
  outb(0x3D4, 0x0E);
  outb(0x3D5, (uint8_t)((pos >> 8) & 0xFF));  
}

int scroll() {
  /* 
    Should only shift vga[x][1] -> vga[x][0],
    then clear the bottom row,
    then cursor_position_y -= 1 row
  */
  int pos = get_cursor();
  for (int i = 0; i < 80 * 25 * 2; ++i) {
    vmp[i] = vmp[i + 80 * 2];
  }
  for (int i = 0; i < 80; ++i) {
    vmp[get_pos(i, 25) * 2] = ' ';
    vmp[get_pos(i, 25) * 2 + 1] = (current_bg << 4) | current_fg;
  }

  return pos - 80 * 2; /* New cursor position */
}