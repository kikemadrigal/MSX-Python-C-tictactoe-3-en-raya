import random
import sys
import time

#lc lista cuadrícula
def dibuja_cuadricula(lc):
    print('\n')
    print('___________________________                    ')
    print('                         ''                    ')
    print('     {}     {}     {}    ''    1     2     3   '.format(lc[0],lc[1],lc[2]))
    print('                         ''                    ')
    print('     {}     {}     {}    ''    4     5     6   '.format(lc[3],lc[4],lc[5]))
    print('                         ''                    ')
    print('     {}     {}     {}    ''    7     8     9   '.format(lc[6],lc[7],lc[8]))
    print('__________________________                   ')

def marcador(ganadas, perdidas, empates):
    print('\n')
    print('Marcador: Jugador: {}  CPU: {}  Empates: {} '.format(ganadas, perdidas, empates))

def devuelve_numero_random(cero, ocho):
    return random.randint(cero, ocho)

def juega_el_jugador(lista_inputs, lista_cuadricula):
    tirada = ''

    while tirada not in lista_inputs:
        tirada = str(input('Turno Jugador: '))

    if tirada == 's' or tirada == 'S':
        sys.exit()

    tirada = int(tirada)
    if lista_cuadricula[tirada - 1] == '_':
        lista_cuadricula[tirada - 1] = 'X'
        #false es que le toca a la máquina
        return False
    else:
        print('Casilla ocupada')
        time.sleep(1)
        return True

def cpu_intenta_3_en_raya(lista_check3raya, lista_cuadricula):
    print("CPU tirando...")
    time.sleep(1)
    for i in range(9):
        if lista_cuadricula[i] == '_':
            lista_cuadricula[i] = 'O'
            for check in lista_check3raya:
               if lista_cuadricula[check[0]] == 'O' and lista_cuadricula[check[1]] == 'O' and lista_cuadricula[check[2]] == 'O':
                   return True
            lista_cuadricula[i]='_'
    return False

def cpu_defiende(lista_check3raya, lista_cuadricula):
    for i in range(9):
        if lista_cuadricula[i] == '_':
            lista_cuadricula[i] = 'X'
            for check in lista_check3raya:
                if lista_cuadricula[check[0]] == 'X' and lista_cuadricula[check[1]] == 'X' and lista_cuadricula[check[2]] == 'X':
                    lista_cuadricula[i] = 'O'
                    return True
            lista_cuadricula[i]='_'
    return False



def juega_cpu_random(tirada_random, lista_cuadricula):
    if lista_cuadricula[tirada_random] == '_':
        lista_cuadricula[tirada_random] = 'O'
        return True

    return False

def checkear_3enraya(lista_check3raya, lista_cuadricula, xo):
    for i in lista_check3raya:
        if lista_cuadricula[i[0]] == xo and lista_cuadricula[i[1]] == xo and lista_cuadricula[i[2]] == xo:
            return True

    return False
"""
def check_empate(vacia, lista_cuadricula):
    for i in lista_cuadricula:
        if i == '_':
            return False

    return True
"""
def check_empate(vacia, lista_cuadricula):
    if vacia not in lista_cuadricula:
        return True
    return False

