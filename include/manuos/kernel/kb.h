#ifndef KB_H
#define KB_H

#define KB_DATA_PORT 0x60
#define KB_CMD_PORT  0x64
#define KB_BUF_SIZE   64

int kb_init(void);
void kb_handler(void);
char getchar(void);

#endif