#include <ctype.h>
#include <stdio.h>
#include "scanner.h"

int get_token(char *buffer) {
  char a;
  int index = 0;

  while ((a = getchar()) != EOF) {
    if (isspace(a)) {
      if (index) {
        return CADENA;
      }
      continue;
    } else if (a == ',') {
      if (index) {
        ungetc(a, stdin);

        return CADENA;
      }
      buffer[0] = a;
      buffer[1] = '\0';

      return COMA;
    } else {
      buffer[index++] = a;
    }
  }

  return FDT;
}
