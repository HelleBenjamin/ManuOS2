#include "../../include/manuos/kernel/kb.h"
#include "../../include/manuos/kernel/kernel.h"

static char scan_code_to_ascii[128] = {
  0,  27, '1', '2', '3', '4', '5', '6', '7', '8', /* 9 */
  '9', '0', '-', '=', '\b', /* Backspace */
  '\t', /* Tab */
  'q', 'w', 'e', 'r', /* 19 */
  't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', /* Enter key */
  0, /* 29   - Control */
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', /* 39 */
  '\'', '`', 0, /* Left shift */
  '\\', 'z', 'x', 'c', 'v', 'b', 'n', /* 49 */
  'm', ',', '.', '/', 0, /* Right shift */
  '*',
  0,  /* Alt */
  ' ',  /* Space bar */
  0,  /* Caps lock */
  0,  /* 59 - F1 key ... > */
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* < ... F10 */
  0,  /* 69 - Num lock*/
  0,  /* Scroll Lock */
  0,  /* Home key */
  0,  /* Up Arrow */
  0,  /* Page Up */
  '-',
  0,  /* Left Arrow */
  0,
  0,  /* Right Arrow */
  '+',
  0,  /* 79 - End key*/
  0,  /* Down Arrow */
  0,  /* Page Down */
  0,  /* Insert Key */
  0,  /* Delete Key */
  0, 0, 0,
  0,  /* F11 Key */
  0,  /* F12 Key */
  0,  /* All other keys are undefined */
};

static char scan_code_to_shifted_ascii[128] = {
  0,  27, '!', '@', '#', '$', '%', '^', '&', '*', /* 9 */
  '(', ')', '_', '+', '\b', /* Backspace */
  '\t', /* Tab */
  'Q', 'W', 'E', 'R', /* 19 */
  'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n', /* Enter key */
  0, /* 29   - Control */
  'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', /* 39 */
  '"', '~', 0, /* Left shift */
  '|', 'Z', 'X', 'C', 'V', 'B', 'N', /* 49 */
  'M', '<', '>', '?', 0, /* Right shift */
  '*',
  0,  /* Alt */
  ' ',  /* Space bar */
  0,  /* Caps lock */
  0,  /* 59 - F1 key ... > */
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* < ... F10 */
  0,  /* 69 - Num lock*/
  0,  /* Scroll Lock */
  0,  /* Home key */
  0,  /* Up Arrow */
  0,  /* Page Up */
  '-',
  0,  /* Left Arrow */
  0,
  0,  /* Right Arrow */
  '+',
  0,  /* 79 - End key*/
  0,  /* Down Arrow */
  0,  /* Page Down */
  0,  /* Insert Key */
  0,  /* Delete Key */
  0, 0, 0,
  0,  /* F11 Key */
  0,  /* F12 Key */
  0,  /* All other keys are undefined */
};

char kb_buf[KB_BUF_SIZE];
int kb_buf_head   = 0;
int kb_buf_tail   = 0;
int kb_buf_count  = 0;

/* This will be called every time when a key is pressed */
void kb_handler(void) {
  unsigned char shift = 0;
  unsigned char scancode = inb(KB_DATA_PORT);
  char c = 0;

  /* TODO: Fix shifted keys*/
  /* Check the key is shift or not */
  if (scancode == 42 || scancode == 54) {
    shift = scancode;
  } else if (scancode >= 128) {
    /* Do nothing */
    return;
  }
  if ((shift == 42) && (kb_buf_count < KB_BUF_SIZE)) {
    kb_buf[kb_buf_head] = scan_code_to_shifted_ascii[scancode];
    kb_buf_head = (kb_buf_head + 1) % KB_BUF_SIZE;
    kb_buf_count++;
  }

  if (kb_buf_count < KB_BUF_SIZE) {
    kb_buf[kb_buf_head] = scan_code_to_ascii[scancode];
    kb_buf_head = (kb_buf_head + 1) % KB_BUF_SIZE;
    kb_buf_count++;
  }
}

char getchar() {
  while (kb_buf_count == 0) {
    /* Wait until a key is pressed*/
  }

  char c = kb_buf[kb_buf_tail];
  kb_buf_tail = (kb_buf_tail + 1) % KB_BUF_SIZE;
  kb_buf_count--;
  return c;
}

char getchar_nonblock() {
  if (kb_buf_count == 0) {
    return 0;
  }

  char c = kb_buf[kb_buf_tail];
  kb_buf_tail = (kb_buf_tail + 1) % KB_BUF_SIZE;
  kb_buf_count--;
  return c;
}