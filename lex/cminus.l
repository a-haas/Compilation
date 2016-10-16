%{
	#include <stdio.h>
	#include <stdlib.h>
%}

keyword (cin|const|cout|else|if|typedef|while)
nonalpha ("+"|"-"|"*"|"/"|"%"|"!"|"&&"|"||"|"<"|"<="|">"|">="|"=="|"!="|\"|"&"|"|"|"="|"("|")"|"["|"]"|"{"|"}"|","|"'"|";")
definedid (char|int|float|void|main)
id [a-zA-Z_]([a-zA-Z_]|[0-9])*
int [0-9]+
float [0-9]+([eE][+-]?[0-9]+)?[lfLF]?\.[0-9]+([eE][+-]?[0-9]+)?[lfLF]?([fF]|[lL])?
char ('.'|'\n')

%%

{keyword}	{
	printf("keyword");
}

{nonalpha} {
	printf("nonalpha");
}

{definedid} {
	printf("definedid");
}

{id} {
	printf("id");
}

{int} {
	printf("int");
}

{float} {
	printf("float");	
}

{char} {
	printf("char");
}

%%

int main(int argc, char* argv[]){
	if(argc == 1)
		yylex();
	if((argc > 2) && (yyin = fopen(argv[1], "r")) == NULL){
		printf("Cannot open file\n");
		return EXIT_FAILURE;
	}
	yylex();
	return EXIT_SUCCESS;
}