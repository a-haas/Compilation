%{
	#include <stdio.h>
	int yylex();
%}

%%

S: C C '\n' {
	printf("Match !\n");
};

C:	'c'C { 
	printf("c \n");
}
|'d' { 
 	printf("d \n"); 
};

%%

int main(){
	return yyparse();
}

int yylex() {
	return getchar();
}