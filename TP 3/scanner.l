%top{
#include "tokens.h"
}
%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput
%option nounput

Letra													            [[:alpha:]]
Digito												          		[[:digit:]]
Letra_Digito												        [[:alnum:]]
Espacio														        [[:space:]]
Identificador                                                       {Letra}{Letra_Digito}*
OperadorAsignacion										            "<<"
Comentario													        "//".*
Desconocido												            [[:punct:]]{-}[();.,+\-*/%]

%%
programa 												            return PROGRAMA;
entero												            	return ENTERO;
leer														        return LEER;
escribir												            return ESCRIBIR;
fin-programa												        return FIN_PROGRAMA;
{Identificador}	                                                    return IDENTIFICADOR;
{Digito}+													        return CONSTANTE;
"+"                                                                 return '+';
"-"                                                                 return '-';
"*"                                                                 return '*';
"/"                                                                 return '/';
"("                                                                 return '(';
")"                                                                 return ')';
"."                                                                 return '.';
";"                                                                 return ';';
"%"                                                                 return '%';
","                                                                 return ',';
{OperadorAsignacion} 										        return ASIGNACION;
{Desconocido}+											            printf("Error léxico: cadena desconocida: %s\n",yytext);
{Identificador}{Desconocido}+({Letra_Digito}|{Desconocido})*		printf("Error léxico: identificador inválido: %s\n",yytext);
{Digito}+{Letra}+{Letra_Digito}*							        printf("Error léxico: constante inválida: %s\n",yytext);
{Espacio}+													        |
{Comentario}												        ;
%%
