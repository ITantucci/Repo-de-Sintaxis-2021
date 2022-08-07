%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
	void yyerror(const char *);
	extern int yylexerrs;
	extern int yynerrs;
}
%defines "parser.h"
%output "parser.c"

%define api.value.type {char *}
%define parse.error verbose
%start programa

%token PROGRAMA ENTERO LEER ESCRIBIR FIN_PROGRAMA IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"
%left '+' '-'
%left '*' '/' '%'
%precedence NEG

%%
programa                 : PROGRAMA IDENTIFICADOR {printf("programa %s\n", yylval);} lista-sentencias  FIN_PROGRAMA {if (yynerrs || yylexerrs) YYABORT; else YYACCEPT;}
                         ;
lista-sentencias         : %empty
                         | sentencia lista-sentencias
                         ;
sentencia                : ENTERO IDENTIFICADOR ';' { printf("entero %s\n", yylval); }
                         | LEER '(' lista-identificadores ')' ';' { printf("leer\n"); }
                         | ESCRIBIR '(' lista-expresiones ')' ';' { printf("escribir\n"); }
                         | IDENTIFICADOR "<<" expresion ';' { printf("asignaciÃ³n\n"); }
                         | error ';'
                         ;
lista-expresiones        : lista-expresiones ',' expresion
                         | expresion
                         ;
lista-identificadores    : lista-identificadores ',' IDENTIFICADOR
                         | IDENTIFICADOR
                         ;
expresion                : expresion '*' expresion { printf("multiplicaciÃ³n\n"); }
                         | expresion '/' expresion { printf("divisiÃ³n\n"); }
                         | expresion '%' expresion { printf("mÃ³dulo\n"); }
                         | expresion '+' expresion { printf("suma\n"); }
                         | expresion '-' expresion { printf("resta\n"); }
                         | '-' expresion %prec NEG { printf("inversiÃ³n\n"); }
                         | '(' expresion ')' { printf("parÃ©ntesis\n"); }
                         | IDENTIFICADOR
                         | CONSTANTE
                         ;
%%

int yylexerrs = 0;

void yyerror(const char *s){
	printf("lÃ­nea #%d: %s\n", yylineno, s);
	return;
}
