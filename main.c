#include <stdio.h>
#include "scanner.h"

int main(void) {
  char buffer[256];
  char token;

  while ((token = get_token(buffer)) != FDT) {
    if (token == COMA) {
      printf("Separador: %s \n ",buffer);
    } else if (token == CADENA) {
      printf("Cadena: %s \n ",buffer);
    }
  }
  printf("Fin de texto: \n");
}
