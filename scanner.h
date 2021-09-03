#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED

enum tokenType {
  FDT,
  CADENA,
  COMA
};
int get_token(char *buffer);

#endif
