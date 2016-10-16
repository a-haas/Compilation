%{
	#include <stdio.h>
	int cpt = 0;
%}

%%

[^ \t\n]+	{
	cpt++;
}
\n 	{}
.	{}

%%

int main(int argc, char* argv[]){
	if(argc == 0)
		yylex();
	if((argc > 1) && (yyin = fopen(argv[1], "r")) == NULL){
		printf("Cannot open file\n");
		return EXIT_FAILURE;
	}
	yylex();
	printf("%d\n", cpt);
	return EXIT_SUCCESS;
}