%{
	#include <stdio.h>
	#include <stdlib.h>

	int yylex();
	void yyerror(char *);

	// we have at max 26 variable (a-z)
	int identarray[25];

	// add a value in the array
	void affectident(char id, int val){
		identarray[id - 'A'] = val;
	}

	// get a value in the array
	int getident(char id){
		return identarray[id - 'A'];
	}

	void printset(char id){
		int value = getident(id);
		int size = 32;
		int i;
		printf("{ ");
		for(i = 0; i < 32; i++) {
		    int binary = (value >> (size - i) - 1) & 1;
		    if (binary)
		    	printf("%d ", size - i);
		}
		printf(" }\n");
	}

%}

%union {
	int set;
	int val;
}

%token <val> UNION
%token <val> INTER
%token <val> DIFF
%token <val> COMP
%token EOI
%token AFFECT

%token <set> NUMBER
%token <set> IDENT

%type <set> instruction
%type <set> expression
%type <set> operande
%type <set> ensemble
%type <set> elemliste
%type <val> operateur2
%type <val> operateur1  

%start liste

%%

liste:
	/* empty */ {
		return 0;
	}
	| instruction EOI liste {

	}

instruction:
	IDENT AFFECT expression {
		affectident($1, $3);
	}
	| IDENT {
		printset($1);
	}

expression:
	operande {
		$$ = $1;
	}
	| operande operateur2 operande {
		switch($2){
			case 1:
				$$ = $1|$3;
				break;
			case 2:
				$$ = $1&$3;
				break;
			case 3:
				$$ = $1 & ~$3;
				break;
			default:
				break; 
		}
	}
	| operateur1 operande {
		$$ = ~$1;
	}

operateur2:
	UNION {
		$$ = 1;
	}
	| INTER {
		$$ = 2;
	}
	| DIFF {
		$$ = 3;
	}

operateur1:
	COMP {
	 	$$ = $1;
	}

operande:
	IDENT {
		$$ = getident($1);
	}
	| ensemble {
		$$ = $1;
	}

ensemble:
	'{' '}' {
		$$ = 0;
	}
	| '{' elemliste '}' {
		$$ = $2;
	}

elemliste:
	NUMBER {
		$$ = 1 << ($1 -1);
	}
	| NUMBER ',' elemliste {
		// un ensemble est l'union de certains ensembles élémentaires (1, 2, ... 32) 
		$$ = $1 | $3;
	}

%%

int main(){
	yyparse();
	return 1;
}