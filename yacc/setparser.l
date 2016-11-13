%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include "setparser.tab.h"
%}

identifier [a-zA-Z]
number [1-9]|[1-2][0-9]|3[0-2]
union "union"|"UNION"
inter "inter"|"INTER"
diff "diff"|"DIFF"

%%

{identifier} {
	yylval.set = toupper(yytext[0]);
	return IDENT;
}

"{" {
	return '{';
}

"}" {
	return '}';
}

":=" {
	return AFFECT;
}

"," {
	return ',';
}

{number} {
	yylval.val = atoi(yytext);
	return NUMBER;
}

"\n" {
	return EOI;
}

{union} {
	return UNION;
}

{inter} {
	return INTER;
}

{diff} {
	return DIFF;
}

%%