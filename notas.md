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

- `ls`			listar archivos
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
- `touch <filename>` crea un archivo

## Manejo de archivos

### Tipos de Archivos

- Archivos Binarios

  Archivos pensados para que sean ejecutados por un PC, si lo vas no podrás entenderlo.. Programas ejecutables y archivos de datos

- Archivos de Texto

  Son tambien archivos binarios, pero son binarios que corresponden a caracteres, entonces un editor de texto va a poder leerlos.

### Utilidades interactivas

**Interactividad**: Programas que procesan en tiempo real.

Para archivos de texto, hay dos grandes: `vim` y `nano`.

#### Utilidades batch (por lotes)

Son programas que procesan texto y emiten el resultado.

- `cat <filename>`ver todo el contenido del archivo

- `head <filename>`ver las primeras lineas del archivo.

  Modificador `-n <numfilas>` especifica el numero de lineas

- `tail <filename>`ver las ultimas lineas del archivo

- `grep <regexp> <filename>`

  Devuelve las coincidencias de un archivo con una expresion regular

- `sed`

  Tratamiento de flujos de caracteres. Utiliza expresiones regulares por ejemplo para reemplazar una expresion con otra.

  `sed 's/Hanks/Selleck/g' dump1.sql`

  sustituye Hanks por Selleck en el archivo dump1.sql

  `sed '$d' nuevasPelis.csv`

  elimina la ultima linea

- `awk`

  Tratemiento de textos estructurados (csv, tsv, etc).

  `awk -F  ';' '{print $1 }' nuevasPelis .csv`

  con `-F ';'` especifico el caracter que esta delimitando la columna. Con `'{}'` ejecuto un script, en este caso imprimo la primera columna de cada linea.

  `awk -F  ';' 'NR > 1 && $3 > 0 {print $1, $3 * $4 }' nuevasPelis.csv`	

  Se puede agregar una condicion para ejecutar el script. `NR` significa numero de la fila. (empezando por 1).

  

