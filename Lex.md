# LEX

## Principe de Lex

* lecture de la spécification de l'analyseur lexical (.l)
* génération du code qui l'implémente

Structure d'un fichier Lex:
	/* définition C ou Lex */
	%%
	/* section des règles lexicales */
	%%
	/* section du code C */

## Compilation

Génération du code c `lex hello.l` puis compilation `gcc lex.yy.c -ll`

## Les sections

### Définitions

* déclarations / définitions C (pour les include, var globales, ...) entre `%{` et `%}`
* raccourcis pour les regex, à utiliser dans les regex entre `{` et `}`
* options et commandes Lex

### Règles lexicales

* liste de couples regex / bloc de code C (entre `{` et `}`)
* pas d'espace avant les regexs
* commencer à la même ligne que la regex

	[0-9]+ { /* code c */}

### Code C

C'est du code C et c'est tout.

## Fonctionnement

Lex fournit une fonction yylex() qui lance l'analyse lexicale sur le fichier ouvert pointé par la variable globale yyin (_File *_), par défaut stdin.

yylex() va parcourir le fichier et tenter de reconnaître **les plus longues séquences de caractères** correspondant à une regex.
* quand une regex est trouvé, l'action associée est exécutée
* en cas d'égalité de longueur, la 1ere regex dans la liste est choisie
* dans l'action, on peut utiliser les variables
	* `yytext` qui contient la chaîne de caractères reconnue
	* `yyleng` qui contient sa taille
* par défaut, ce qui n'est pas reconny est affiché sur stdout
* yylex se termine quand soit :
	* le fichier est parcouru entièrement
	* soit une action effectue un return
	* on a appelé la fonction yyterminate()

## Astuces

Pour ne pas avoir de problème de lecture, écriture de fichier, le mieux est de rediriger les I/O standards.

	cat in.txt | ./a.out > out.txt