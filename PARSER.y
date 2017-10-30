%{
	#include<stdio.h>
	#include <conio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <ctype.h>
%}
%token INICIO
%token FIN
%token LEER
%token ESCRIBIR
%token ASIGNACION
%token PARENIZQUIERDO
%token PARENDERECHO
%token COMA
%token PUNTOYCOMA
%token SUMA
%token RESTA
%token IDENTIFICADOR
%token CONSTANTE
%token FDT

%start programa

%%
programa: INICIO listaSentencias FIN FDT {printf("FUNCIONA BIEN");};

listaSentencias: 
		|sentencia 
		| listaSentencias sentencia
		;

sentencia: IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA			
	| LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA	
	| ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA
	;


listaIdentificadores: IDENTIFICADOR comaIDs;

comaIDs: COMA IDENTIFICADOR
	| comaIDs COMA IDENTIFICADOR
	;

listaExpresiones: expresion
		| expresion comaExpresion
		;

comaExpresion: COMA expresion
		| comaExpresion COMA expresion
		;

expresion: primaria					
	|  primaria operadorAditivoPrimarias		
	;

operadorAditivoPrimarias: operadorAditivo primaria
			| operadorAditivoPrimarias operadorAditivo primaria
			;


primaria: IDENTIFICADOR
	| CONSTANTE 
	| PARENIZQUIERDO expresion PARENDERECHO
	;

operadorAditivo: SUMA | RESTA;

%%

int yyerror(char *s)
{
printf(" Error: %s\n",s);
}
int yywrap(void)
{
	return 1;
}
int main ()
{
	yyparse();	
}