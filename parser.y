%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%union {
    double val;
}

%token <val> NUMBER

%type <val> E

%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%

ArithmeticExpression:
    E { printf("\nResult = %.2f\n", $1); return 0; }
;

E:
    E '+' E { $$ = $1 + $3; }
  | E '-' E { $$ = $1 - $3; }
  | E '*' E { $$ = $1 * $3; }
  | E '/' E {
        if ($3 == 0) {
            yyerror("Error: Division by zero");
            YYABORT;
        } else {
            $$ = $1 / $3;
        }
    }
  | E '%' E {
        if ((int)$3 == 0) {
            yyerror("Error: Division by zero in modulus");
            YYABORT;
        } else {
            $$ = (int)$1 % (int)$3;
        }
    }
  | '(' E ')' { $$ = $2; }
  | NUMBER { $$ = $1; }
;

%%

int main() {
    printf("Enter expression: \n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

