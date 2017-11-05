%{
	#include<stdio.h>
	#include <conio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <ctype.h>
%}
%union{int dval}
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
programa: INICIO listaSentencias FIN FDT {printf("Funciona bien");};

listaSentencias: sentencia
		| sentencia listaSentencias
		;

sentencia: IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA			
	| LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA	
	| ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA	
	;


listaIdentificadores:  IDENTIFICADOR
			| IDENTIFICADOR COMA listaIdentificadores
			;

listaExpresiones: expresion				
		| expresion COMA listaExpresiones	
		;

expresion: primaria				
	|  primaria SUMA expresion	
	|  primaria RESTA expresion	
	;


primaria: IDENTIFICADOR
	| CONSTANTE 
	| PARENIZQUIERDO expresion PARENDERECHO
	;


%%

FILE *yyin;
int yyerror(char *s)
{
printf(" Error: %s\n",s);
}
int yywrap(void)
{
	return 1;
}
int main (int argc, char* argv[])
{
	char nombreArchivo[50];
	strcpy(nombreArchivo,argv[1]);
	yyin = fopen(nombreArchivo,"rb");
	if(yyin)
	{
		yyparse();	
	}
	
}