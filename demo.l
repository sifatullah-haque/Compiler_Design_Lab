%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;

int int_count = 0;
int float_count = 0;
int keyword_count = 0;
int identifier_count = 0;
int operator_count = 0;
int symbol_count = 0;
int total_tokens = 0;
%}

%%

[0-9]+\.[0-9]+              { float_count++;   total_tokens++; printf("FLOAT: %s\n", yytext); }
[0-9]+                      { int_count++;     total_tokens++; printf("INTEGER: %s\n", yytext); }
(if|else|while|for|int|float|main)  { keyword_count++; total_tokens++; printf("KEYWORD: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*      { identifier_count++; total_tokens++; printf("IDENTIFIER: %s\n", yytext); }
[ \t\r\n]+                  { /* ignore whitespace */ }
[+\-*/%=]                   { operator_count++; total_tokens++; printf("OPERATOR: %s\n", yytext); }
.                           { symbol_count++; total_tokens++; printf("SYMBOL: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Cannot open input.txt");
        return 1;
    }

    yylex();

    printf("\n======= TOKEN SUMMARY =======\n");
    printf("Total tokens   : %d\n", total_tokens);
    printf("Integers       : %d\n", int_count);
    printf("Floats         : %d\n", float_count);
    printf("Keywords       : %d\n", keyword_count);
    printf("Identifiers    : %d\n", identifier_count);
    printf("Operators      : %d\n", operator_count);
    printf("Other Symbol  : %d\n", symbol_count);
    printf("=============================\n");

    fclose(yyin);
    return 0;
}