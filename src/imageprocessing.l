
%{
#include <stdlib.h>
#include <string.h>
void yyerror(char *);

#include "y.tab.h"

char *p = NULL;
%}



%%

[a-z]  {
        yylval.ival = yytext[0] - 'a';
        return VAR;
       }

[0-9]+(\.[0-9]+)? {
                    yylval.fval = atof(yytext);
                    return MULTIPLY;
                  }

\" { return ASPA; }

[a-zA-Z0-9\.]+  {
        for (int i = 0; i < yyleng; i++ )
          yylval.strval[i] = yytext[i];

        yylval.strval[yyleng] = '\0';
        return STRING;
       }

[=]     {
          return IGUAL;
        }

[\*\/]     {
          yylval.ival = yytext[0];
          return VEZES;
        }

[\]\[]  {
          yylval.ival = yytext[0];
          return COLCHETE;
        }

\n   {
         return EOL;
       }

[ \t]+ ;

.     {printf("**%s**\n", yytext);
yyerror("Token nao reconhecido!\n");}

%%

int  yywrap() {
  return 1;
}
