%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;

//ekhane sob guli counter ashbe

%}

%%

//ekhane sob guli rules ashbe

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    //ekhanen file input newa lagbe
    



    printf("\n======= TOKEN SUMMARY =======\n");
    //ekhane print korbo sob kichu
    printf("=============================\n");

    fclose(yyin);
    return 0;
}