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
char play_player();
char play_player2();
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
char turn;
char count_win_player;
char count_win_cpu_or_player2;
char count_tied;
char game_over;
char number_players;
/*Definitons*/
void main(void) 
{
  /**
   * New game
   * 
   */
game_over:
  SetColors(15,1,1);
  FunctionKeys(0);
  count_win_player=0;
  count_win_cpu_or_player2=0;
  count_tied=0;
  number_players=0;
  //mostramos el menú de bienvenida
  show_menu();
  /**
   * New Screen
   */
new_screen:
  game_over=0;
  //Inicializamos el array
  for(char i=0;i<9;i++){
      board[i]='_';
  }
  if(generate_random_number(0,9)>6)
    turn=0;
  else
    turn=1;

  /*
  *Main loop
  */
  while(game_over==0){
    draw_board();
    if(check_3_en_raya('X')==1){
      Locate(0,17);
      printf("Player win!!");
      count_win_player++;
      WaitKey();
      goto new_screen;
    }else if(check_3_en_raya('O')==1){
      Locate(0,17);
      if(number_players==1)
        printf("MSX win!!");
      else 
        printf("Plaer 2 win!!");
      count_win_cpu_or_player2++;
      WaitKey();
      goto new_screen;
    }
    else if(check_empate()==0){
      Locate(0,17);
      printf("Tied!!");
      WaitKey();
      goto new_screen;
    }
    if(turn==0){
      turn=play_player();
    }else{
      if(number_players==1)
        turn=play_cpu();
      else
        turn=play_player2();
    }
  }//fin del while(game_over)
  goto game_over;
}

void draw_board(void){
  Cls();
  HideDisplay();
  printf("\n");
  if (number_players==1)printf("       Player: %d MSX: %d Tied: %d ",count_win_player,count_win_cpu_or_player2,count_tied);
  else printf("       Player: %d Player 2: %d Tied: %d ",count_win_player,count_win_cpu_or_player2,count_tied);
  printf("\n");
  printf("\n\r");
  printf("           _____________\n\r");
  printf("          |             |\n\r");
  printf("          |  %c   %c   %c  | 1 2 3\n\r", board[0], board[1], board[2]);
  printf("          |             |\n\r");
  printf("          |  %c   %c   %c  | 4 5 6\n\r", board[3], board[4], board[5]);
  printf("          |             |\n\r");
  printf("          |  %c   %c   %c  | 7 8 9\n\r", board[6], board[7], board[8]);
  printf("          |_____________|\n\r");
  Locate(4,20);
  printf("Remember escape to exit"); 
  ShowDisplay();
}


char play_player(){
    char lugar_elegido =0;
    char key=0;
    KillKeyBuffer();
    //while (lugar_elegido <48 || lugar_elegido>57){
    while ( key <'0' || key>'9' ){
        Locate(0,17);
        Print("Player turn");
        key=WaitKey();
        if(key==27){
          game_over=1;
          return 0;
        }
        lugar_elegido=get_number_from_char(key);
    }
    //hay que restarle 1 porque así funcionan los arrays
    if (board[lugar_elegido - 1] == '_'){
      board[lugar_elegido - 1] = 'X';      
    }else{
      //Vuelve a tirar el player ya que estaba ocupado ese lugar
      Locate(0,15);
      printf("El %d estaba ocupado",lugar_elegido);
      play_player();
    }
  return 1;
}

char play_player2(){
    char lugar_elegido =0;
    char key=0;
    KillKeyBuffer();
    //while (lugar_elegido <48 || lugar_elegido>57){
    while ( key <'0' || key>'9' ){
        Locate(0,17);
        Print("Player 2 turn");
        key=WaitKey();
        if(key==27){
          game_over=1;
          return 0;
        }
        lugar_elegido=get_number_from_char(key);
    }
    //hay que restarle 1 porque así funcionan los arrays
    if (board[lugar_elegido - 1] == '_'){
      board[lugar_elegido - 1] = 'O';      
    }else{
      //Vuelve a tirar el player ya que estaba ocupado ese lugar
      Locate(0,15);
      printf("El %d estaba ocupado",lugar_elegido);
      play_player();
    }
  return 0;
}

char play_cpu(void){
  Locate(0,17);
  printf("MSX Turn ...");
  //Pausa
  for(long i=0;i<15000;i++);
  //MSX intenta 3 en raya
  for(char i=0;i<9;i++){
    if(board[i]=='_'){
      board[i]='O';
      for (char check=0;check<9;check++){
        if(board[allowed[check][0]]=='O' && board[allowed[check][1]]=='O' && board[allowed[check][2]]=='O'){
          return 0;
        }
      }
      board[i]='_';
    }
  }

  //MSX defiende
  for(char i=0;i<9;i++){
    if(board[i]=='_'){
      board[i]='X';
      for (char check=0;check<9;check++){
        if(board[allowed[check][0]]=='X' && board[allowed[check][1]]=='X' && board[allowed[check][2]]=='X'){
          board[i]='O';
          return 0;
        }
      }
      board[i]='_';
    }
  }


  //MSX tira aleatoriamente
  char tirada_cpu=generate_random_number(0,9);
  if(board[tirada_cpu]=='_'){
    board[tirada_cpu]='O';
    return 0;
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
  Locate(13,0);
  printf("Tictactoe");  
  Locate(13,2);
  printf("MSX Spain");  
  Locate(4,10);
  printf("Press 1 player <> MSX");  
  Locate(4,12);
  printf("Press 2 player1 <> player2");  
  Locate(4,15);
  printf("Remember escape to exit"); 
  while(k!=49 && k!=50){
    k=Inkey();
    if(k==27)terminar_programa();
    if(k==49)
      number_players=1;
    else
      number_players=2;
  }
}

