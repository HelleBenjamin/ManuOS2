
#include <stdio.h>

int main(int argc, char *argv[]) {
  char str[] = "Hello World from shell!";
  char cmd[64];
  puts(str);
  /* Currently echoes input back, will add command execution later*/
  while (1) {
    puts("> ");
    gets(cmd);
    puts(cmd);
  }
  return 0;
}
