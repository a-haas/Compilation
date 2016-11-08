# YACC

Yacc est un générateur de parseurs pour grammaire LALR.

## Compilation

Génération du code c `bison hello.l` puis compilation `gcc y.tab.c -ly`

## Erreurs (grammaire ambigue)

* __shift-reduce__ : erreur gentille 
* __reduce-reduce__ : erreur méchante (retravail de la grammaire nécessaire)

## Structure d'un fichier YACC

	/* Déclarations C et YACC */
	%%
	/* Règles de traduction */
	%%
	/* Fonctions C auxilaires */

### Déclarations

* Comme Lex, déclarations C entre `%{` et `%}` (en début de ligne)
* Déclarations YACC :
	* `%token` : pour définir les tokens
	* `%left` et `%right` pour gérer les priorités
	* `%type` et `%union` pour gérer les types des attributs

### Règle de tradution

	E : E '*' E {
		/* code C */
	};

	\<Non Terminal\> : \<Production (suite de terminaux et non terminaux)\> {
		\<bloc de code C\>
	}

Le bloc de code C peut avoir une valeur
* `$$` est celle du non terminal de gauche
* `$i` est celle du i-ème de la production

Le `;` arrête la séquence de production.

### Fonction C auxilaires

La fonction `yylex()` doit être définie et retourne le prochain token et peut mettre une valeur dans yylval (créée par Lex).

YACC crée la fonction `yyparse()`.

## Combiner Lex et YACC

1. Générer les .c à l'aide de `lex hello.l` et `bison -d hello.y`. 
2. Compiler grâce à la commande `gcc lex.yy.c y.tab.c -ll -ly`. 