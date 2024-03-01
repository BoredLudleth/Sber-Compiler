%option noyywrap

%{
#include <stdio.h>
%}

DIGIT         [0-9]

TYPE_ID       [A-Z][A-Za-z0-9_]*
VAR           [a-z][A-Za-z0-9_]*
STRING        ["][^\0]*["]

ELSE          [Ee][Ll][Ss][Ee]
IF            [Ii][Ff]
LOOP          [Ll][Oo][Oo][Pp]
THEN          [Tt][Hh][Ee][Nn]
WHILE         [Ww][Hh][Ii][Ll][Ee]
NOT           [Nn][Oo][Tt]
PRINT         [Pp][Rr][Ii][Nn][Tt]
PRINTLN       [Pp][Rr][Ii][Nn][Tt][Ll][Nn]

TRUE          [t][Rr][Uu][Ee]
FALSE         [f][Aa][Ll][Ss][Ee]

%%
{STRING}                                            {
    printf ("Token class: STRING, Token value: %s\n", yytext);
}

{DIGIT}+                                            {
    printf ("Token class: DIGIT, Token value: %s\n", yytext);
}

{DIGIT}+"."{DIGIT}*                                 {
    printf ("Token class: FLOAT, Token value: %s\n", yytext);
}

{ELSE}|{FALSE}|{IF}|{LOOP}|{THEN}|{WHILE}|{NOT}|{TRUE}|{PRINT}|{PRINTLN} {
    printf ("Token class: KEYWORD, Token value: %s\n", yytext);
}

"("|")"|"{"|"}"|"+"|"-"|"/"|"*"|"="                 {
    printf ("Token class: SPEC_SYM, Token value: %s\n", yytext);
}


{TYPE_ID}                                           {
    printf ("Token class: TYPE_ID, Token value: %s\n", yytext);
}

{VAR}                                               {
    printf ("Token class: VAR, Token value: %s\n", yytext);
}

"/*"                                                {
    char c = 0;
    int comment_level = 1;

    printf ("Token class: OPEN_COMMENT\n");

    while (comment_level != 0) {
        if ((c = yyinput()) == '/') {
            if ((c = yyinput()) == '*') {
                printf ("Token class: OPEN_COMMENT\n");
                comment_level++;
                continue;
            }
        }

        if (c == '*') {
            if ((c = yyinput()) == '/') {
                printf ("Token class: CLOSE_COMMENT\n");
                comment_level--;
                continue;
            }
        }

        if (c == EOF) {
            break;
        }
    }
}

"--"                                                {
    char c = yyinput();
    
    printf ("Token class: OPEN_COMMENT\n");

    while (c != '\n' && c != '\0') {
        c = yyinput();
    }

    printf ("Token class: CLOSE_COMMENT\n");
}

[ \n\t]+                                            {}

%%

int main (int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen (argv[1], "r");
    } else {
        yyin = stdin;
    }

    yylex();
}

