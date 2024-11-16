%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%

[0-9]+"."[0-9]+    { yylval.val = atof(yytext); return NUMBER; }
[0-9]+             { yylval.val = atoi(yytext); return NUMBER; }
[ \t]+             ;
\n                 return 0;
.                  return yytext[0];

%%

int yywrap() {
    return 1;
}

