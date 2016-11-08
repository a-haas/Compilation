%{
	// declarations
	#include <stdio.h>
	#include <stdlib.h>

	#define HT_SIZE 65536

	unsigned long hash(unsigned char *str);	
%}

keyword (cin|const|cout|else|if|typedef|while)
nonalpha ("+"|"-"|"*"|"/"|"%"|"!"|"&&"|"||"|"<"|"<="|">"|">="|"=="|"!="|\"|"&"|"|"|"="|"("|")"|"["|"]"|"{"|"}"|","|"'"|";")
definedid (char|int|float|void|main)
id [a-zA-Z_]([a-zA-Z_]|[0-9])*
int [0-9]+
float [0-9]+([eE][+-]?[0-9]+)?[lfLF]?\.[0-9]+([eE][+-]?[0-9]+)?[lfLF]?([fF]|[lL])?
char ('.'|'\n')
comment "/*".*"*/"

%%

{keyword}	{
	printf("keyword '%s' with hash %lu \n", yytext, hash(yytext));
}

{nonalpha} {
	printf("non alpha '%s' with hash %lu \n", yytext, hash(yytext));
}

{definedid} {
	printf("defined id '%s' with hash %lu \n", yytext, hash(yytext));
}

{comment}	{
	// do nothing here
}

{id} {
	printf("id '%s' with hash %lu \n", yytext, hash(yytext));
}

{int} {
	printf("int '%s' with hash %lu \n", yytext, hash(yytext));
}

{float} {
	printf("float '%s' with hash %lu \n", yytext, hash(yytext));	
}

{char} {
	printf("char '%s' with hash %lu \n", yytext, hash(yytext));
}

%%

/**
 *	djb2 hash function
 *  http://www.cse.yorku.ca/~oz/hash.html
 */
unsigned long hash(unsigned char *str) {
	//magic number
	unsigned long hash = 5381;
	int c;
	while (c = *str++)
		hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
	return hash%65536;
}

/**
 * Le but ici est de pouvoir créer la table des symboles de manière dynamique
 * en utilisant une fonction de hachage. Cette fonction de hachage permet ainsi
 * de générer une valeur à partir de la chaîne de caractères lue par le lexer.
 * La table de hachage ici n'est pas implémentée mais elle permettrait ainsi de
 * facilement stocker les valeurs pour la partie implémentée via YACC. La
 * taille de la table de hachage est ici définie mais est 100% arbitraire, et
 * nécessite une gestion particulière et dynamique dans le cadre d'utilisation
 * de gros programmes.
 *
 * La table des symboles devrait être initialisée avec les valeurs des
 * mot-clés définis à l'avance.
 */
int main(int argc, char* argv[]){
	if((argc > 1) && (yyin = fopen(argv[1], "r")) == NULL){
		printf("Cannot open file\n");
		return EXIT_FAILURE;
	}
	yylex();
	return EXIT_SUCCESS;
}