%{
#include <stdlib.h>
#include <stdio.h>
extern int yylex(void);
extern int yyerror(const char *msg);
extern int yylineno;
%}
%define parse.error verbose
%token TOK_NUMBER "number"
%token TOK_IDENTIFIER "identifier"
%token TOK_AFFECTATION ":="
%token TOK_SEMI_COLON ";"
%token TOK_IF "if"
%token TOK_THEN "then"
%token TOK_ADD "+"
%token TOK_SUB "-"
%token TOK_MUL "*"
%token TOK_DIV "/"
%%
program: code;
code: code instruction | ;
instruction: affectation ;
affectation:
identifier TOK_AFFECTATION expression TOK_SEMI_COLON;
expression:
identifier |
number ;
identifier:
TOK_IDENTIFIER ;
number:
TOK_NUMBER ;
%%
/*
* file: facile.y
* version: 0.8.0
*/
int yyerror(const char *msg) {
fprintf(stderr, "Line %d: %s\n", yylineno, msg);
}
int main(int argc, char *argv[]) {
yyparse();
return EXIT_SUCCESS;
}
