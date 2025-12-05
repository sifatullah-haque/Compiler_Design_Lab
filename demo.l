%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;

//ekhane sob guli counter ashbe
int int_count = 0;
int float_count = 0;

%}

%%

//ekhane sob guli rules ashbe
[0-9]+\.[0-9]+              { float_count++;   total_tokens++; printf("FLOAT: %s\n", yytext); }
[0-9]+                      { int_count++;     total_tokens++; printf("INTEGER: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    //ekhanen file input newa lagbe

    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Cannot open input.txt");
        return 1;
    }

    yylex();
    



    printf("\n======= TOKEN SUMMARY =======\n");
    //ekhane print korbo sob kichu
    printf("Total tokens   : %d\n", total_tokens);
    printf("Integers       : %d\n", int_count);
    printf("=============================\n");

    fclose(yyin);
    return 0;
}