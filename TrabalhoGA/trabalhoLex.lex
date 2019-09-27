
%option noyywrap

%{

#include <math.h>
#include<stdio.h>
#include <string.h>

    int in, t, j;
	char array[50][50] = {};
%}


DIGIT	[0-9]
ID	[aA-zZ][aA-zZ0-9]*
INCLUDE  ((#include)([ ])*(<)(\w|.)*(>))
COMMENTS ((\/\*)([^(\*\/)])+(\*\/))|((\/\/)(.)*(\n))
STRING ((\")(.)*(\")|(')(.)*('))
%%


%{
	//COMENTARIOS 
%}
{COMMENTS} {}

%{
	//STRING 
%}
{STRING} { printf("[string_literal, %s]\n", yytext);}

%{
	//OPERADORES LOGICOS 
	//"|" {printf("[logic_op, %s]\n", yytext);}
	//"&" {printf("[logic_op, %s]\n", yytext);}
%}
"||" {printf("[logic_op, %s]\n", yytext);}
"&&" {printf("[logic_op, %s]\n", yytext);}


%{
	//DEMAIS SINALIZADORES 
%}
"=" {printf("[equal_op, %s]\n", yytext);}
"(" {printf("[l_paren, %s]\n", yytext);}
")" {printf("[r_paren, %s]\n", yytext);}
"{" {printf("[l_bracket, %s]\n", yytext);}
"}" {printf("[r_bracket, %s]\n", yytext);}
"," {printf("[comma, %s]\n", yytext);}
";" {printf("[semicolon, %s]\n", yytext);}
"[]" {  printf("[l_squarebracket, %s]\n", "[");
		printf("[r_squarebracket, %s]\n", "]");}
"[" {printf("[l_squarebracket, %s]\n", yytext);}
"]" {printf("[r_squarebracket, %s]\n", yytext);}

%{
	//FLOAT 
%}
{DIGIT}{DIGIT}*"."{DIGIT}{DIGIT}* {printf("[num, %f]\n",atof(yytext));}

%{
	//INTEIRO 
%}
{DIGIT}+ { printf("[num, %d]\n", atoi(yytext));}

%{
	//PALAVRAS RESERVADAS 
%}
if|void|float|printf|int|string|scanf|if|return|NULL|for|{INCLUDE}	{
	printf("[reserved_word, %s]\n", yytext);
}

%{
	//IDENTIFICADORES  (fazer aqui array para buscar id que ja exista)
	
%}
{ID} {
   /* Inicializando uma matriz sem tamanho definido */
    t = 0;
    j = 0;
   for(j=0; j < in; j++){
	   if(strcmp(array[j], yytext) == 0){
		   t = 1;
		   break;
	   }
   }
   int temp;
   if(t == 0){
	 strcpy(array[in], yytext);
	 temp = in;
	 ++in;
   }
	printf("[id (%s), %d]\n", yytext,temp);
}

%{
	//OPERADORES aritimeticos 
%}
"+"|"-"|"*"|"/" {printf("[arith_op, %s]\n", yytext);}

%{
	//OPERADORES RELACIONAIS 
%}
"<"|"<="|"=="|"!="|">="|">" {printf("[relational_op, %s]\n", yytext);}

"{"[\^{}}\n]*"}"	

[ \t\n]+		

.	printf("Caractere nao reconhecido: %s\n", yytext);

%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
