%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>

	#include "setparser.h"

	int yylex();
	void yyerror(char *);

	// we have at max 26 variable (a-z)
	unsigned long int identarray[25];

	// add a value in the array
	void affectident(char id, unsigned long int val){
		identarray[id - 'A'] = val;
	}

	// get a value in the array
	unsigned long int getident(char id){
		return identarray[id - 'A'];
	}

	void printset(char id){
		unsigned long int set = getident(id);
		int flag = 0;
		int i=32;
		printf("\t{ ");
		for(i>0; i--;){
			// greatest pow
			unsigned long int gpow = (unsigned long int)(pow(2, i -1)+0.5);
			if(gpow <= set){
				if(!flag){
					flag = !flag;
					printf("%d", i);
				}
				else
					printf(", %d", i);

				set -= gpow;
			}
		}
		printf(" }\n");
	}

%}

%union {
	unsigned long int set;
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
		$$ = (unsigned long int)(pow(2, $1 -1)+0.5);
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