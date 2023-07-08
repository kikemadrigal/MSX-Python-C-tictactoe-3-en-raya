//
// Fusion-C
// My First Program in C
//

#include "fusion-c/header/msx_fusion.h"
#include <stdio.h>
//rand y srand http://cplusplus.com/reference/cstdlib/rand/
#include <stdlib.h>
#include "utils.c"
/**Declarations*/
void draw_board(void);
void inicilize(void);
char play_player();
char play_cpu(void);
void terminar_programa(void);
char generate_random_number(char a, char b);
char check_empate();
void show_menu(void);
char check_3_en_raya(char player_or_cpu);
char board[9];
char allowed[8][3]={
  {0,1,2},
  {3,4,5},
  {6,7,8},
  {0,3,6},
  {1,4,7},
  {2,5,8},
  {0,4,8},
  {2,4,6}
};
//0 tira el jugador
char tirada;
char game_over;
/*Definitons*/
void main(void) 
{
game_over:
  SetColors(15,1,1);
  Locate(8,0);
  Print(" 3 en Raya");
  inicilize();

  show_menu();
 
  while(game_over==0){

    if(tirada==0){
      tirada=play_player();
    }else{
      tirada=play_cpu();
    }

    draw_board();
    if(check_3_en_raya('X')==1){
      Locate(0,0);
      printf("Jugador ganaste, pulse una tecla para continuar");
      WaitKey();
      goto game_over;
    }else if(check_3_en_raya('O')==1){
      Locate(0,0);
      printf("Cpu gana, pulse una tecla para continuar");
      WaitKey();
      goto game_over;
    }
    else if(check_empate()==0){
      Locate(0,0);
      printf("Empate, pulse una tecla para continuar");
      WaitKey();
      goto game_over;
    }
  }
  
}
void inicilize(void){
  for(char i=0;i<9;i++){
      board[i]='_';
  }
  if(generate_random_number(0,9)>6)
    tirada=0;
  else
    tirada=1;

  game_over=0;
}
 
void draw_board(void){
  Cls();
  HideDisplay();
  printf("\n");
  printf("\n");
  printf("\n");
  printf("\n\r");
  printf("  ________________\n\r");
  printf(" |                |\n\r");
  printf(" |  %c   %c   %c     | 1 2 3\n\r", board[0], board[1], board[2]);
  printf(" |                |\n\r");
  printf(" |  %c   %c   %c     | 4 5 6\n\r", board[3], board[4], board[5]);
  printf(" |                |\n\r");
  printf(" |  %c   %c   %c     | 7 8 9\n\r", board[6], board[7], board[8]);
  printf(" |________________|\n\r");
  ShowDisplay();
}


char play_player(){
    char lugar_elegido =0;
    char key=0;
    //while (lugar_elegido <48 || lugar_elegido>57){
    while (key <'0' || key>'9'){
        Locate(0,20);
        Print("Turno Jugador: pulsa del 1 al 9): ");
        key=WaitKey();
        lugar_elegido=get_number_from_char(key);
    }
    if (key == 's' || key == 'S'){
      terminar_programa();
    }




    if (board[lugar_elegido - 1] == '_'){
      board[lugar_elegido - 1] = 'X';
      //1 es que le toca a la máquina
      
    }else{
      //Vuelve a tirar el player ya que estaba ocupado ese lugar
      Locate(0,0);
      printf("El %d estaba ocupado",lugar_elegido);
      play_player();

    }
  return 1;
}

char play_cpu(void){
  char tirada_cpu=generate_random_number(0,9);
  Locate(0,20);
  printf("Turno CPU...%d",tirada_cpu);
  for(long i=0;i<10000;i++);

  if(board[tirada_cpu]=='_'){
    board[tirada_cpu]='O';
    //Ahora tira el player (0)
  }else{
    play_cpu();
  }
  return 0;
}

void terminar_programa(void){
  game_over=1;
  #ifdef __SDCC
    __asm
      ld c,#0x0
      call #0x0005
    __endasm; 
  #endif
}

char generate_random_number(char a, char b){
  //Time es un struct + typedef con 3 enteros para las horas, minutos y segundos
    //TIME tm;
    char random; 
    //GetTime obtiene la hora del MSDOS y se la asigna al struct TIME
    //GetTime(&tm); 
    //srand utiliza los segundos como semilla para generar un número aleatorio  
    //srand y rand forman parte de la librería stdlib.h normalmente utilizada para castear strings y manejar memoria dinámica         
    //srand(tm.sec);
    random = rand()%(b-a)+a;  
    return(random);
}


char check_3_en_raya(char player_or_cpu){
  //Recorremos la lista de posicioes permitidas
  for(char i=0;i<9;i++){
    if(board[allowed[i][0]]==player_or_cpu && board[allowed[i][1]]==player_or_cpu && board[allowed[i][2]]==player_or_cpu){
      return 1;
    }
  }
  return 0;
}

char check_empate(){
  char found=0;
  for(char i=0;i<9;i++){
    if(board[i]=='_'){
      found=1;
    }
  }
  return found;
}

void show_menu(void){
  Cls();
  char k=0;
  Locate(10,10);
  //PutText(100,100,"1. Jugar",0);
  Locate(12,10);
  printf("1. Jugar\n\n\n\r");  
  while(k!=49){
    k=Inkey();
  }
}

