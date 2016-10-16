%{
	#include <stdio.h>
%}

%%

\n 	{
	printf("<br>");
}

\t 	{
	printf("tab recognized");
	printf("&nbsp;&nbsp;&nbsp;&nbsp;");
}

[ ]	{
	printf("&nbsp;");
}

[<]	{
	printf("&lsaquo;");
}

[>]	{
	printf("&rsaquo;");
}

(asm|auto|break|catch|case|char|class|const|continue|default|delete|do|double|else|enum|extern|float|for|friend|goto|if|inline|int|long|new|operator|overload|private|protected|public|register|return|short|signed|sizeof|static|struct|switch|this|template|typedef|union|unsigned|virtual|void|volatile|while)	{
	printf("<b>%s</b>", yytext);
}

[^  \t\n<>]+	{
	printf("%s", yytext);
}

%%

int main(int argc, char* argv[]){
	// cat <file.c>|./a.out > <file.html>
	yylex();
	return EXIT_SUCCESS;
}