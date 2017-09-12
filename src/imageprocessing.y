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
        /*calling brightness change function*/
        printf("Aguarde\n");
        printf("Chamando a a funcao Brilho\n");
        printf("A intensidade desejada será de %.2f\n", $5);
        printf("A operação será de %c\n", $4);
        /*it first opens the image file*/
        imagem I = abrir_imagem($3);
        /*then, with this file we can call the brightness fuction*/
        /*the function can be seen in lib_imageprocessing.c file*/
        brilho(&I, $4, $5);
        /*after it, we save it to the desired file*/
        salvar_imagem($1, &I);
        /*and free our memory*/
        liberar_imagem(&I);
    }
    | COLCHETE STRING COLCHETE  {
      printf("Aguarde\n");
      printf("Chamando a funcao Valor Máximo\n");
      /*first we open the image*/
      imagem I = abrir_imagem($2);
      /*then, with image file pointer we can call the function that checks
       the max pixel value*/
      float resultado = valor_maximo(&I);
      /*after it we print the value on the screen*/
      printf("O valor maximo dos pixels da imagem é de %.2f", resultado);
      /*and free our memory*/
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
