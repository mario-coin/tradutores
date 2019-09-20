
%option noyywrap

%{

#include <math.h>

%}


DIGIT	[0-9]
ID	[aA-zZ][aA-zZ0-9]*
INCLUDE  ((#include)([ ])*(<)(\w|.)*(>))
COMMENTS ((\/\*)([^(\*\/)])+(\*\/))|((\/\/)(.)*(\n))

%%


%{
	//COMENTARIOS 
%}
{COMMENTS} {printf("COMMENTARIOS -> %s\n", yytext);}


%{
	//DEMAIS SINALIZADORES 
%}
"=" {printf("SINALIZADOR -> [equal, %s]\n", yytext);}
"(" {printf("SINALIZADOR -> [l_paren, %s]\n", yytext);}
")" {printf("SINALIZADOR -> [r_paren, %s]\n", yytext);}
"{" {printf("SINALIZADOR -> [l_bracket, %s]\n", yytext);}
"}" {printf("SINALIZADOR -> [r_bracket, %s]\n", yytext);}
"," {printf("SINALIZADOR -> [comma, %s]\n", yytext);}
";" {printf("SINALIZADOR -> [semicolon, %s]\n", yytext);}

%{
	//FLOAT 
%}
{DIGIT}{DIGIT}*"."{DIGIT}{DIGIT}* {printf("Numero float encontrado: %s (%f)\n", yytext, atof(yytext));}

%{
	//INTEIRO 
%}
{DIGIT}+ { printf("INTEIRO -> %s (%d)\n", yytext, atoi(yytext));}

%{
	//PALAVRAS RESERVADAS 
%}
if|void|float|printf|int|string|scanf|if|return|NULL|for|{INCLUDE}	{
	printf("PALAVRA RESERVADA -> %s\n ", yytext);
}

%{
	//IDENTIFICADORES 
%}
{ID} {printf("IDENTIFICADOR -> %s\n", yytext);}

%{
	//OPERADORES 
%}
"+"|"-"|"*"|"/" {printf("OPERADORES -> %s\n", yytext);}




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
