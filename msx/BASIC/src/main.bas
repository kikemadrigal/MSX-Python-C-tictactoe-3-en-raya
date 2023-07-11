1' GAME: 3 EN RAYA /TICTACTOE basic
1 'Author: MSX spain 2023'

1 'Variales:'
1 'c$(9): tablero de strings'
1 'tu=turno 0 turno player, 1 turno MSX o player 2'
1 'w0=si vale 1 es que el player hizo 3 en raya'
1 'w1=si vale 1 es que el MSX o el player 2 hizo 3 en raya'
1 'p0=lleva la puntuación del player
1 'p1=lleva la puntuación 
1 'np=número de players, se utiliza para elegir entre jugar contra el MSX o contra otro player'
1 'te=total empates, lleva la putuación de los empates de la partida
1 'em=empate, cuando em=1 hay un empate'
1 'co= solo utilizada en función dibujar tablero como ayuda 
1 '     para el desplazamiento de la x del locate'
1 'le$= variable utilizada solo en la función check 3 en raya 
1 '     para poner "X' cuando queremos comprobar elñ 3 en raya 
1 '     del player y "O" cuando comprobamos el del MSX
1 'ra= variable solo utilizada en check 3 en raya para ayuda'
1 ' 
1 '


1 ' Funciones
1 '0= inicialización'
1 '100: Main loop
1 '600: esperar a que se pulse el espacio 



1 ' *********************
1 '    Inicio juego
1 ' *********************
30 cls
1 '1000=mostrar menu
40 gosub 1000
50 tu=0:p0=0:p1=0:te=0
1 ' *********************
1 '    New screen
1 ' *********************
60 em=0:w0=0:w1=0
1 'inicializar array con '_''
80 for i=0 to 8
    90 c$(i)="_"
100 next i
1 'Si el valor que saque la función RaNDom es mayor que 5 tirará el msx'
110 if rnd(1)*10>4 then tu=1

1'************
1' Main loop  
1'************
    1'dibujamos el tablero'
    200 gosub 1200

    1' 2800 rutina para comprobar 3 en raya con el parámtero le$
    210 le$="X":gosub 2800 
    220 le$="O":gosub 2800
    1 'DEBUG'
    1 '222 locate 0,17:print "W0: "w0" W1: "w1" em: "em
    1' si w0=1 es que el player ha ganado, si w1=1 es que el MSX ha ganado
    230 if w0=1 then p0=p0+1:locate 0,17:if np=1 then print "Player win!!":gosub 600:goto 60 else print "Player 1 win!!":gosub 600:goto 60
    240 if w1=1 then p1=p1+1:locate 0,17:if np=1 then print "MSX win!!":gosub 600:goto 60 else print "Player 2 win!!":gosub 600:goto 60
    1 '4000= rutina comprobar empate'
    250 gosub 4000
    260 if em=1 then te=te+1:locate 0,17:print "Tied!!":gosub 600:goto 60

    1 'Si tu=0 entonces tira el player si no tirá el MSX o si se ha escogido en el menú 2 players (np=2) el player 2'
    270 if tu=0 then gosub 2000 else if np=1 then gosub 3000 else gosub 2100
500 goto 200

1' rutina esperar pulsar espacio
    600 locate 0,18:print "Press space to continue, esc to exit"
    610 k$=INKEY$:IF k$=CHR$(27) THEN GOTO 30
620 if strig(0)=-1 then return else goto 610



1 ' Mostrar memu'
    1000 Locate 13,0:print "3 en raya"
    1010 Locate 13,2:print "MSX Spain"
    1040 Locate 4,10:print "Press 1 player <> MSX"
    1050 Locate 4,12:print "Press 2 player1 <> player2"
    1060 k$=INKEY$: IF k$="" THEN GOTO 1060
    1070 IF k$<>"1" and k$<>"2" THEN GO TO 1060
    1080 if k$="1" then np=1 else if k$="2" then np=2
1150 RETURN




1 ' dibuja tablero'
    1200 cls
    1210 locate 2,3:if np=1 then print "Player: "p0" MSX: "p1" tied:"te else  print "player1: "p0" player2: "p1" tied:"te
    1220 co=0
    1 'Dubjos líneas verticales y horizontales'
    1225 for i=8 to 13: locate 10,i:print "|":locate 18,i:print "|":next i
    1226 for i=10 to 18: locate i,7:print "-":locate i,14:print "-":next i
    1240 for i=0 to 8
        1' el 2+ es la separación que kiero dejar a la izquierda y el *2 es para que no salgan juntas las letras
        1250 if i<3 then locate 20,8: print "1 2 3":                          locate (6+co+i)*2,8
        1255 if i>=3 and i<6 then locate 20,10: print "4 5 6": co=(6+(i-3))*2: locate co,10 
        1260 if i>=6 and i<9 then locate 20,12: print "7 8 9": co=(6+(i-6))*2:locate co,12
        1270 print c$(i)
    1280 next i
1290 return 



1'Tira el player
    2000 locate 0,17:if np=1 then print "Player turn" else print "Player 1 turn"
    2010 k$=INKEY$
    1' si es la tecla escape volvemos a empezar
    2020 IF k$=CHR$(27) THEN GOTO 30
    1' si no es del 1 al 9 volvemos a capturar otra tecla
    2030 IF k$<"0" OR k$>"9" OR k$="" THEN GOTO 2000
    1' a la tecla pulsa la converimos en entero y espués le restamos 1 (porque así trabajan los arrays)
    2040 se=VAL(k$):se=se-1
    1 '2041 locate 0,0:print se:gosub 600
    2050 if c$(se)="_" then c$(se)="X" else locate 0,15:print "Ocupada, prueba otra vez":for i=0 to 500: next i:locate 0,15:print "                          ":goto 2000
    1 'Ponemos que ahora es el turno del MSX'
    2060 tu=1
    2070 locate 0,15:print "            "
2090 return


1 'Tira el player 2'
    2100 locate 0,17:print "Player 2 turn"
    2110 k$=INKEY$
    1' si es la tecla escape volvemos a empezar
    2120 IF k$=CHR$(27) THEN GOTO 30
    1' si no es del 1 al 9 volvemos a capturar otra tecla
    2130 IF k$<"0" OR k$>"9" OR k$="" THEN GOTO 2110
    2140 se=VAL(k$):se=se-1
    2150 if c$(se)="_" then c$(se)="O" else locate 0,15:print "Ocupada, prueba otra vez":for i=0 to 500: next i:locate 0,15:print "                          ":goto 2110
    1 'Ponemos que ahora es el turno del player 1'
    2160 tu=0
    2170 locate 0,15:print "            "
2190 return

1' check 3 e raya
1' comprobar 3 en raya según el valor de le$
1 'Necesita el parámetro de lr$'
    2800 ra=0
    2810 if c$(0)=le$ and c$(1)=le$ and c$(2)=le$ then ra=1
    2820 if c$(3)=le$ and c$(4)=le$ and c$(5)=le$ then ra=1
    2830 if c$(6)=le$ and c$(7)=le$ and c$(8)=le$ then ra=1
    2840 if c$(0)=le$ and c$(3)=le$ and c$(6)=le$ then ra=1
    2850 if c$(1)=le$ and c$(4)=le$ and c$(7)=le$ then ra=1
    2860 if c$(2)=le$ and c$(5)=le$ and c$(8)=le$ then ra=1
    2870 if c$(0)=le$ and c$(4)=le$ and c$(8)=le$ then ra=1
    2880 if c$(6)=le$ and c$(4)=le$ and c$(2)=le$ then ra=1
    2885 if ra=1 then if le$="X" then w0=1 else if le$="O" then w1=1
2890 return

1 'cpu intenta 3 en raya'
    3000 locate 0,17:print "MSX turn..."
    3010 for i=0 to 9
        3030 if c$(i)="_" then c$(i)="O": le$="O":gosub 2800:c$(i)="_"
        3040 if w1=1 then c$(i)="O":tu=0:return
    3050 next i
    1 '3060 if w1=0 then gosub 3100
    3060 gosub 3100
3090 return

1 'cpu defiende 3 en raya'
    3100 for i=0 to 9
        3120 if c$(i)="_" then c$(i)="X": le$="X":gosub 2800:c$(i)="_"
        3130 if w0=1 then w0=0:c$(i)="O":tu=0:return
    3140 next i
    3150 gosub 3900
3190 return 


1 'Tira el msx aleatoriamente
    3900 se=rnd(1)*9
    3910 if c$(se)="_" then c$(se)="O" else goto 3900
    1' ponemos que ahora es el turno del player 
    3940 tu=0 
3990 return


1'comprobar empate
    4000 em=1
    4040 for i=0 to 8
        4050 if c$(i)="_" then em=0
    4060 next i
4090 return


