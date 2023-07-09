import sys
import modulo1 as ra1
import os
import time

lista_cuadricula = ['_']*9
lista_check3raya=[
    (0,1,2),
    (3,4,5),
    (6,7,8),
    (0,3,6),
    (1,4,7),
    (2,5,8),
    (0,4,8)
]
lista_inputs=['1','2','3','4','5','6','7','8','9','s','S']

#ra1.dibuja_cuadricula(lista_cuadricula)

vacia='_'
ganadas=0
perdidas=0
empates=0
juador_3enraya=False
cpu_3enraya=False
empate=False
turno=False
numero_tirada=0

turno=ra1.devuelve_numero_random(0,9)
if turno<5:
    turno=True
else:
    turno=False

while not empate:
#while numero_tirada<9:
    numero_tirada+=1
    os.system('cls')
    ra1.dibuja_cuadricula(lista_cuadricula)
    jugador_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'X')
    cpu_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'O')
    empate = ra1.check_empate(vacia, lista_cuadricula)

    if jugador_3enraya:
        print('GANA Jugador!!! 3 en Raya!', jugador_3enraya, cpu_3enraya, empate)
        break
    elif cpu_3enraya:
        print('GANA la CPU !!! 3 en Raya!', jugador_3enraya, cpu_3enraya, empate)
        break
    elif empate:
        print('Empate! ', jugador_3enraya, cpu_3enraya, empate)
        break





    if turno:
        turno=ra1.juega_el_jugador(lista_inputs,lista_cuadricula)
    else:
        print("CPU tirando...")
        time.sleep(1)
        cpu_3enraya=ra1.cpu_intenta_3_en_raya(lista_check3raya, lista_cuadricula)
        if not cpu_3enraya:
            turno=ra1.cpu_defiende(lista_check3raya, lista_cuadricula)
            if not turno:
                tirada_random=ra1.devuelve_numero_random(0,8)
                turno=ra1.juega_cpu_random(tirada_random,lista_cuadricula)
       





    """
    os.system('cls')
    jugador_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'X')
    cpu_3enraya = ra1.checkear_3enraya(lista_check3raya, lista_cuadricula, 'O')
    empate = ra1.checkear_empate(vacia, lista_cuadricula)

    if jugador_3enraya:
        print('GANA Jugador!!! 3 en Raya!', jugador_3enraya, cpu_3enraya, empate)
        break
    elif cpu_3enraya:
        print('GANA la CPU !!! 3 en Raya!', jugador_3enraya, cpu_3enraya, empate)
        break
    elif empate:
        print('Empate! ', jugador_3enraya, cpu_3enraya, empate)
        break

    if turno:
        turno = ra1.juega_el_jugador(lista_inputs, lista_cuadricula)
    else:
        tirada_random = ra1.devuelve_numero_random(0, 8)
        turno = ra1.juega_cpu_random(tirada_random, lista_cuadricula)
    """

print("Lista vacía")
sys.exit()