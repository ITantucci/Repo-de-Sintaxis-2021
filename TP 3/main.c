/* 
Audino Julieta Siomara - 169830
Tantucci Ignacio Javier - 1605471
*/

#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"

int main(void)
{
	char *token_names[] = {"Fin de Archivo", 
	"Programa", 
	"Entero", 
	"Leer",
	"Escribir",
	"Fin de programa",
	"Identificador",
	"Constante",
	"Asignacion"};
	
	TOKEN token;
	do {
		token = yylex();

		switch (token)
		{
		case IDENTIFICADOR:
		case CONSTANTE:
			printf("Token %s: lexema: %s\n", token_names[token], yytext);
			break;
		case PROGRAMA:
		case ENTERO:
		case ASIGNACION:
		case LEER:
		case ESCRIBIR:
		case FIN_PROGRAMA:
		case FDT:
			printf("Token: %s\n", token_names[token]);
			break;
		default:
			printf("Token: \'%c\'\n", token);
			break;
		}

	} while (token != FDT);
	return EXIT_SUCCESS;
}
