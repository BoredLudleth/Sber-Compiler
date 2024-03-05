#ifndef LEX_FUNCT_HPP
#define LEX_FUNCT_HPP

#include <iostream>
#include "error_codes.hpp"

// for /* */
int readAttachedComment ();

// for --
void readNotAttachedComment ();

//template function for messages for all things
void print_msg (const char* my_msg, char* yytext = nullptr);

#endif
