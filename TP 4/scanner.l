%top{
	#include <stdio.h>
	#include "parser.h"
    #include <strings.h>
}

%{
    char msg[200];
%}
%option outfile="scanner.c"
%option header-file="scanner.h"
%option noinput
%option nounput
%option yylineno


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
{Identificador}	                                                    {yylval = strdup(yytext); return IDENTIFICADOR;}
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
{Desconocido}+											            {yylexerrs++; sprintf(msg, "Error léxico: cadena desconocida: %s\n",yytext); yyerror(msg);}
{Identificador}{Desconocido}+({Letra_Digito}|{Desconocido})*		{yylexerrs++; sprintf(msg, "Error léxico: identificador inválido: %s\n",yytext); yyerror(msg);}
{Digito}+{Letra}+{Letra_Digito}*							        {yylexerrs++; sprintf(msg, "Error léxico: constante inválida: %s\n",yytext); yyerror(msg);}
{Espacio}+													        |
{Comentario}												        ;
%%
