%{
	#include <stdio.h>
%}

voyelle [aeiouyAEIOUY]

%%

{voyelle}+ 	{
	printf("av%s", yytext);
}

%%

int main(int argc, char* argv[]){
	if(argc == 0)
		yylex();
	if((argc > 1) && (yyin = fopen(argv[1], "r")) == NULL){
		printf("Cannot open file\n");
		return EXIT_FAILURE;
	}
	yylex();
	return EXIT_SUCCESS;
}