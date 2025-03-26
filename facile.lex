%{
#include <assert.h>
#define TOK_IF 258
#define TOK_THEN 259
#define TOK_FOR 260
#define TOK_NOT 261
%}
%%
if {
assert(printf("'if' found"));
return TOK_IF;
}
then {
assert(printf("'then' found"));
return TOK_THEN;
}

for {
assert(printf("'for' found"));
return TOK_FOR;
}

not {
assert(printf("'not' found"));
return TOK_NOT;
}

[ab]*a[ab]*b[ab]*b[ab]*a assert(printf("'abba' found")); return yytext[0];
%%
/*
* file: facile.lex
*/
