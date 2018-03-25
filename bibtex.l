%{
#include "y.tab.h"
#include <string.h>
void yyerror(char *s);
%}

%%

"\@" 	{yylval.str = strdup(yytext);printf("Encountered @\n");return AT;}
[0-9]+ 	{yylval.str = strdup(yytext);printf("Encountered number\n");return NUMBER;}
[a-z0-9A-Z]+ { yylval.str = strdup(yytext);printf("Encountered name\n");return NAME;}

"\{" 	{yylval.str = strdup(yytext);printf("Encountered {\n");return LBRACE;}
"\}" 	{yylval.str = strdup(yytext);printf("Encountered }\n");return RBRACE;}
"\=" 	{yylval.str = strdup(yytext);printf("Encountered =\n");return EQUALS;}
"," 	{yylval.str = strdup(yytext);printf("Encountered ,\n");return COMMA;}

"\n"	{yylval.str = strdup(yytext);return NEWLINE;}
'\A'	{yylval.str = strdup(yytext);return ENDOFFILE;}
.		{ECHO; yyerror("enexpected character");}


%%

int yywrap(){return 1;}

