%{
	#include <stdlib.h>
	#include <string.h>
	#include "setparser.tab.h"
%}

%%

[a-zA-Z] {
	yylval = toupper(yytext[0]);
	return IDENT;
}

"{" {
	
}

%%