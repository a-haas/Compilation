%{
	#include <stdlib.h>
	#include "exprarithm.tab.h"
%}

%%

[0-9]+ {
	yylval.val = atoi(yytext);
	return NUMBER;
}

[()+*] {
	return yytext[0];
}

[\n] {
	return yytext[0];
}

. {
	printf("Caractère inconnu");
}

%%