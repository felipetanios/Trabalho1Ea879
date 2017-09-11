%{
#include <stdio.h>
#include "imageprocessing.h"
#include <FreeImage.h>

void yyerror(char *c);
int yylex(void);

%}
%union {
  char    strval[50];
  int     ival;
  float   fval;
}
%token <strval> STRING
%token <ival> VAR IGUAL EOL ASPA  VEZES COLCHETE
%token <fval> MULTIPLY
%left SOMA

%%

PROGRAMA:
        PROGRAMA EXPRESSAO EOL
        |
        ;

EXPRESSAO:
    | STRING IGUAL STRING VEZES MULTIPLY  {
        printf("Aguarde\n");
        printf("Chamando a a funcao Brilho\n");
        printf("A intensidade desejada será de %.2f\n", $5);
        printf("A operação será de %c\n", $4);
        imagem I = abrir_imagem($3);
        brilho(&I, $4, $5);
        salvar_imagem($1, &I);
        liberar_imagem(&I);
    }
    | COLCHETE STRING COLCHETE  {
      printf("Aguarde\n");
      printf("Chamando a funcao Valor Máximo\n");
      imagem I = abrir_imagem($2);
      float resultado = valor_maximo(&I);
      printf("O valor maximo dos pixels da imagem é de %.2f", resultado);
      liberar_imagem(&I);
    }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  FreeImage_Initialise(0);
  yyparse();
  return 0;

}
