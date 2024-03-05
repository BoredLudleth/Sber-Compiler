%option noyywrap

%{
#include <iostream>
#include "lex_funct.hpp"
#include "error_codes.hpp"
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
    print_msg ("Token class: STRING, Token value: ", yytext);
}

{DIGIT}+                                            {
    print_msg ("Token class: DIGIT, Token value: ", yytext);
}

{DIGIT}+"."{DIGIT}*                                 {
    print_msg ("Token class: FLOAT, Token value: ", yytext);
}

{ELSE}|{FALSE}|{IF}|{LOOP}|{THEN}|{WHILE}|{NOT}|{TRUE}|{PRINT}|{PRINTLN} {
    print_msg ("Token class: KEYWORD, Token value: ", yytext);
}

"("|")"|"{"|"}"|"+"|"-"|"/"|"*"|"="                 {
    print_msg ("Token class: SPEC_SYM, Token value: ", yytext);
}


{TYPE_ID}                                           {
    print_msg ("Token class: TYPE_ID, Token value: ", yytext);
}

{VAR}                                               {
    print_msg ("Token class: VAR, Token value: ", yytext);
}

"/*"                                                {
    readAttachedComment ();
}

"--"                                                {
    readNotAttachedComment ();
}

[ \n\t]+                                            {}

%%
