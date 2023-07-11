import sys
import modulo1 as ra1
import os
import time


ganadas=0
perdidas=0
empates=0
salir=False
turno=False
jugador_3enraya = False
cpu_3enraya = False

while not salir:

    lista_cuadricula = ['_']*9
    lista_check3raya=[
        (0,1,2),
        (3,4,5),
        (6,7,8),
        (0,3,6),
        (1,4,7),
        (2,5,8),
        (0,4,8),
        (2,4,6)
    ]
    lista_inputs=['1','2','3','4','5','6','7','8','9','s','S']

    vacia='_'

    juador_3enraya=False
    cpu_3enraya=False
    empate=False
    turno=ra1.devuelve_numero_random(0,9)

    if turno<5:
        turno=True
    else:
        turno=False

    while not empate:
        os.system('cls')
        ra1.marcador(ganadas, perdidas, empates)
        ra1.dibuja_cuadricula(lista_cuadricula)
        jugador_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'X')
        cpu_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'O')
        empate = ra1.check_empate(vacia, lista_cuadricula)

        if jugador_3enraya:
            print('GANA Jugador!!! 3 en Raya!')
            ganadas += 1
            break
        elif cpu_3enraya:
            print('GANA la CPU !!! 3 en Raya!')
            perdidas += 1
            break
        elif empate:
            print('Empate! ')
            empates += 1
            break





        if turno:
            turno=ra1.juega_el_jugador(lista_inputs,lista_cuadricula)
        else:

            cpu_3enraya=ra1.cpu_intenta_3_en_raya(lista_check3raya, lista_cuadricula)
            if not cpu_3enraya:
                turno=ra1.cpu_defiende(lista_check3raya, lista_cuadricula)
                if not turno:
                    tirada_random=ra1.devuelve_numero_random(0,8)
                    turno=ra1.juega_cpu_random(tirada_random,lista_cuadricula)
        
    print('\n')
    otra = str(input('Jugar otra vez? (S / N)'))
    if otra == 'S' or otra == 's':
        salir = False
    else:
        salir = True

sys.exit()