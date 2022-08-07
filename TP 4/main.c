/* 
Audino Julieta Siomara - 169.830-8
Tantucci Ignacio Javier - 160.547-1
Escobar Cabrera Deisy - 126.737-1
*/

#include <stdio.h>
#include <stdlib.h>
#include "parser.h"

int main(void)
{	
	switch( yyparse() ) {
		case 0: printf("CompilaciÃ³n terminada con Ã©xito\n");
			break;		
		case 1: printf("Errores de compilaciÃ³n\n");
			break;
		case 2: printf("Memoria ram insuficiente\n");
			break;		
	}

	printf("\nErrores sintÃ¡cticos:  %d - Errores lÃ©xicos:  %d\n", yynerrs, yylexerrs);

	return 0;		
}