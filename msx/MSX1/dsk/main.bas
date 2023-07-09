1' GAME: 3 EN RAYA /TICTACTOE basic
1 'Author: MSX spain 2023'

1 'Variales:'
1 'c$(9): tablero de strings'
1 'ti=determina si la tirada es del player'
1 'tu=turno 0 turno player, 1 turno MSX'
1 'w0=si vale 1 es que el player hizo 3 en raya'
1 'w1=si vale 1 es que el MSX hizo 3 en raya'
1 'em=empate, cuando em=1 hay un empate'
1 'co= solo utilizada en función dibujar tablero como ayuda 
1 '     para el desplazamiento de la x del locate'
1 'le$= variable utilizada solo en la función check 3 en raya 
1 '     para poner "X' cuando queremos comprobar elñ 3 en raya 
1 '     del player y "O" cuando comprobamos el del MSX
1 'ra= variable solo utilizada en check 3 en raya para ayuda'
1' i1=variable utilizada en intenta cpu 3 en raya



1 ' Funciones
1 '0= inicialización'
1 '100: Main loop
1 '600: esperar a que se pulse el espacio 


1 'Inicialize'
10 color 15,1,1:key off
1 '0 le toca tirar al player, 1 le toca tirar al msx'
20 dim c$(9)


1 ' *********************
1 '    Inicio juego
1 ' *********************
30 tu=0:em=0:w0=0:w1=0:i1=0
1 'inicializar array con '_''
40 for i=0 to 8
    50 c$(i)="_"
60 next i
70 cls
1 '1000=mostrar menu
80 gosub 1000
1 'Si el valor que saque la función RaNDom es mayor que 5 tirará el msx'
90 if rnd(1)*10>4 then tu=1

1'************
1' Main loop  
1'************
    1'dibujamos el tablero'
    100 gosub 1200

    1' 2100 rutina para comprobar 3 en raya con el parámtero le$
    120 le$="X":gosub 2100 
    130 le$="O":gosub 2100
    1' si w0=1 es que el player ha ganado, si w1=1 es que el MSX ha ganado
    200 if w0=1 then locate 0,15:print "Player gana, pulse espacio para empezar":gosub 600:goto 30
    210 if w1=1 then locate 0,15:print "MSX gana, pulse espacio para empezar":gosub 600:goto 30

    1 '4000= rutina comprobar empate'
    220 gosub 4000
    230 if em=1 then locate 0,15:print "Empate, pulse espacio para empezar":gosub 600:goto 30

    1 'Si tu=0 entonces tira el player si no tirá el MSX'
    240 if tu=0 then gosub 2000 else gosub 3000

500 goto 100

1' rutina esperar pulsar espacio
600 if strig(0)=-1 then return else goto 600



1 ' Mostrar memu'
    1000 Locate 10,0:print "3 en raya"
    1010 Locate 10,2:print "MSX Spain"
    1040 Locate 4,10:print "1 jugar contra MSX"
    1050 Locate 4,12:print "2 jugador1 contra jugador2"
    1060 k$=INKEY$: IF k$="" THEN GOTO 1060
    1070 IF k$<>"1" THEN GO TO 1060
1150 RETURN




1 ' dibuja tablero'
    1200 cls
    1205 locate 10,0:print "3 en raya"
    1210 co=0
    1215 locate 2,4:print "-----------------"
    1220 for i=0 to 8
        1' el 2+ es la separación que kiero dejar a la izquierda y el *2 es para que no salgan juntas las letras
        1230 if i<3 then locate 12,6: print "1 2 3":                          locate (2+co+i)*2,6
        1250 if i>=3 and i<6 then locate 12,8: print "4 5 6": co=(2+(i-3))*2: locate co,8 
        1260 if i>=6 and i<9 then locate 12,10: print "7 8 9": co=(2+(i-6))*2:locate co,10
        1270 print c$(i)
    1280 next i
    1285 locate 2,12:print "-----------------"
1290 return 



1'Tira el player
    2000 locate 0,15:print "Turno player"
    2010 LET k$=INKEY$
    1' si es la tecla escape volvemos a empezar
    2020 IF k$=CHR$(27) THEN GOTO 30
    1' si no es del 1 al 9 volvemos a capturar otra tecla
    2030 IF k$<"0" OR k$>"9" OR k$="" THEN GOTO 2000
    1' a la tecla pulsa la converimos en entero y espués le restamos 1 (porque así trabajan los arrays)
    2040 se=VAL(k$):se=se-1
    2050 if c$(se)="_" then c$(se)="X" else locate 0,15:print "Ocupada, prueba otra vez":for i=0 to 500: next i:locate 0,15:print "                          ":goto 2000
    1 'Ponemos que ahora es el turno del MSX'
    2060 tu=1
    2070 locate 0,15:print "            "
2090 return

1' check 3 e raya
1' comprobar 3 en raya según el valor de le$
1 'Necesita el parámetro de lr$'
    2100 ra=0
    2110 if c$(0)=le$ and c$(1)=le$ and c$(2)=le$ then ra=1
    2120 if c$(3)=le$ and c$(4)=le$ and c$(5)=le$ then ra=1
    2130 if c$(6)=le$ and c$(7)=le$ and c$(8)=le$ then ra=1
    2140 if c$(0)=le$ and c$(3)=le$ and c$(6)=le$ then ra=1
    2150 if c$(1)=le$ and c$(4)=le$ and c$(7)=le$ then ra=1
    2160 if c$(2)=le$ and c$(5)=le$ and c$(8)=le$ then ra=1
    2170 if c$(0)=le$ and c$(4)=le$ and c$(8)=le$ then ra=1
    2180 if ra=1 then if le$="X" then w0=1 else if le$="O" then w1=1
2190 return

1 'cpu intenta 3 en raya'
    3000 locate 0,15:print "Turno MSX..."
    3010 for i=0 to 9
        3020 if c$(i)="_" then c$(i)="O": le$="O":gosub 2100:c$(i)="_"
        3030 if w1=1 then c$(i)="O":return
    3050 next i
    3060 if w1=0 then gosub 3100
3090 return

1 'cpu defiende 3 en raya'
    3100 d1=0
    3110 for i=0 to 9
        3120 if c$(i)="_" then c$(i)="X": le$="X":gosub 2100:c$(i)="_"
        3130 if w0=1 then d1=1:w0=0:c$(i)="O":tu=0:return
    3140 next i
    3150 if d1=0 then gosub 3900
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


