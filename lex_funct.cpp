#include "lex_funct.hpp"

int readAttachedComment () {
    char c = 0;
    int comment_level = 1;

    std::cout << "Token class: OPEN_COMMENT" << std::endl;

    while (comment_level != 0) {
        if ((c = yyinput()) == '/') {
            if ((c = yyinput()) == '*') {
                print_msg ("Token class: OPEN_COMMENT");
                comment_level++;

                continue;
            }
        }

        if (c == '*') {
            if ((c = yyinput()) == '/') {
                print_msg ("Token class: CLOSE_COMMENT");
                comment_level--;
                
                continue;
            }
        }

        if (c == EOF) {
            //eof in comment
            return ERROR_EOF_IN_COMMENT; //change on not-null error code
        }

        if (c == '\0') {
            //eof in comment
            return ERROR_NULL_IN_COMMENT; //change on not-null error code
        }

    }
    
    return 0;
}

void readNotAttachedComment () {
    char c = yyinput();
    print_msg ("Token class: OPEN_COMMENT");

    while (c != '\n' && c != '\0') {
        c = yyinput();
    }
    
    print_msg ("Token class: CLOSE_COMMENT");
}

void print_msg (const char* my_msg, char* yytext) {
    if (yytext != nullptr) {
        std::cout << my_msg << yytext << std::endl;
    } else {
        std::cout << my_msg << std::endl;
    }
}
