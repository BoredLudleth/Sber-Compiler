%option noyywrap

%{
#include <iostream>
%}

DIGIT         [0-9]

TYPE_ID       [A-Z][A-Za-z0-9_]*
VAR           [a-z][A-Za-z0-9_]*
STRING        ["][^\0"<<EOF>>]*["]

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
    std::cout << "Token class: STRING, Token value: " << yytext << std::endl;
}

{DIGIT}+                                            {
    std::cout << "Token class: DIGIT, Token value: " << yytext << std::endl;
}

{DIGIT}+"."{DIGIT}*                                 {
    std::cout << "Token class: FLOAT, Token value: " << yytext << std::endl;
}

{ELSE}|{FALSE}|{IF}|{LOOP}|{THEN}|{WHILE}|{NOT}|{TRUE}|{PRINT}|{PRINTLN} {
    std::cout << "Token class: KEYWORD, Token value: " << yytext << std::endl;
}

"("|")"|"{"|"}"|"+"|"-"|"/"|"*"|"="                 {
    std::cout << "Token class: SPEC_SYM, Token value: " << yytext << std::endl;
}


{TYPE_ID}                                           {
    std::cout << "Token class: TYPE_ID, Token value: " << yytext << std::endl;
}

{VAR}                                               {
    std::cout << "Token class: VAR, Token value: " << yytext << std::endl;
}

"/*"                                                {
    char c = 0;
    int comment_level = 1;

    std::cout << "Token class: OPEN_COMMENT" << std::endl;

    while (comment_level != 0) {
        if ((c = yyinput()) == '/') {
            if ((c = yyinput()) == '*') {
                printf ("Token class: OPEN_COMMENT\n");
                std::cout << "Token class: OPEN_COMMENT" << std::endl;
                comment_level++;
                continue;
            }
        }

        if (c == '*') {
            if ((c = yyinput()) == '/') {
                printf ("Token class: CLOSE_COMMENT\n");
                std::cout << "Token class: CLOSE_COMMENT" << std::endl;
                comment_level--;
                continue;
            }
        }

        if (c == EOF) {
            //eof in comment
            break;
        }
    }
}

"--"                                                {
    char c = yyinput();
    std::cout << "Token class: OPEN_COMMENT" << std::endl;
    printf ("Token class: OPEN_COMMENT\n");

    while (c != '\n' && c != '\0') {
        c = yyinput();
    }
    
    std::cout << "Token class: CLOSE_COMMENT" << std::endl;
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

