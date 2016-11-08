%{
	#include <stdio.h>
	#include <stdlib.h>

	int yylex();
	void yyerror(char *);
%}

%union {
	int val;
}

%token <val> NUMBER

%type <val> expr

%start axiom
%left '+'
%left '*'

%%

axiom:
	expr '\n' {
		printf("%d\n", $1);
	}

expr:
	expr '+' expr {
		$$ = $1 + $3;
	}
	| expr '*' expr {
		$$ = $1 * $3;
	}
	| '(' expr ')' {
		$$ = $2;
	}
	| NUMBER {
		$$ = $1;
	}
;

%%

int main(){
	yyparse();
	return 1;
}