# Introduccion a la Terminal y Linea de Comandos

## Qué es una terminal?

La terminal es un programa que recibe ordenes, las traduce a algo que el computador puede entender y, en conjunto con el sistema operativo, ejecuta lo que se ingresa, mediante una interfaz de texto (CLI).

Se hace a traves de una interfaz de texto por razones de eficiencia.

## Los Comandos

- Nombre de programa
- Modificadores: Alteran lo que el programa va a hacer
- Parámetros: Valores de entrada para el programa

`comando --flag1 --flag2 arg1 arg2`

### Algunos comandos

- `date`	muestra la fecha actual
- `echo "Mauro"`	muestra un mensaje en pantalla
- `man date`  muestra ayuda sobre un comando
- `history` 	muestra el historial de comandos ingresados
- `!<command_id>` ejecuta el comando del id asociado, que se puede consultar con `history`.

## Organizacion de Archivos

- `ls			listar archivos
- `ls -a` 	listar todos los archivos, incluso los ocultos
- `ls -l`	listar y dar detalles de archivos
- `pwd` 		identificar directorio
- `cd <path>`	navegar a otro directorio
- `cd -`		navegar al directorio anterior visitado
- `mkdir <dirname>`		crear directorio nuevo
- `cp <pathToOneFile> <newWantedPath>`	copiar un archivo
- `rm <filename>`	remover un archivo
- `mv <pathToOneFile> <newWantedPath>` 	mover un archivo
- `rmdir <dirname>` remover un directorio (siempre que esté vacío)

