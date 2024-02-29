%option noyywrap

%{
#include <stdio.h>
%}

DIGIT    [0-9]

TYPE_ID       [A-Z][A-Za-z0-9_]*
VAR           [a-z][A-Za-z0-9_]*

%%

{DIGIT}+    {
            printf ("Token class: DIGIT, Token value: %s\n", yytext);
            }

{DIGIT}+"."{DIGIT}* {
                    printf ("Token class: FLOAT, Token value: %s\n", yytext);
                    }

else|false|if|iF|loop|then|while|not|true|print|printl {
            printf ("Token class: KEYWORD, Token value: %s\n", yytext);
            }

"("|")"|"{"|"}"|"+"|"-"|"/"|"*"|"=" {
            printf ("Token class: SPEC_SYM, Token value: %s\n", yytext);
            }


{TYPE_ID} {
            printf ("Token class: TYPE_ID, Token value: %s\n", yytext);
          }

{VAR} {
            printf ("Token class: VAR, Token value: %s\n", yytext);
          }

[ \n\t]+ {}

%%

int main (int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen (argv[1], "r");
    } else {
        yyin = stdin;
    }

    yylex();
}

