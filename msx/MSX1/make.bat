@echo off
set GAME=tictactoe

rem Le quitamos los comentarios a main.bas
java -jar tools/MSXTools/MSXTools.jar -m=d -o=src/main.bas 

move  .\main-del.bas dsk\game.bas 



rem Copiando todos los archivos.bas de la carpeta src
for /R src %%a in (*.bas) do (
    copy "%%a" dsk & echo %%a)




rem MSX 1
rem start /wait tools/emulators/openmsx/openmsx.exe -machine Sony_HB-55P -ext Sony_HBD-50 -diska %TARGET_DSK%
rem MSX2
start /wait tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska dsk
rem MSX2+
rem start /wait tools/emulators/openmsx/openmsx.exe -machine Sony_HB-F1XV -diska %TARGET_DSK%