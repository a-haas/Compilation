%{
	#include <stdio.h>
%}

%%

[0-9]+	{
	printf("J'ai matché l'entier : %s\n", yytext);
}

%%

int main(int argc, char* argv[]){
	if((argc != 1) && (yyin = fopen(argv[1], "r")) == NULL){
		printf("Cannot open file\n");
		return EXIT_FAILURE;
	}
	yylex();
	return EXIT_SUCCESS;
}