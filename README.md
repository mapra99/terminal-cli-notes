# Introduccion a la Terminal y Linea de Comandos

## Qué es una terminal?

La terminal es un programa que recibe ordenes, las traduce a algo que el computador puede entender y, en conjunto con el sistema operativo, ejecuta lo que se ingresa, mediante una interfaz de texto (CLI).

Se hace a traves de una interfaz de texto por razones de eficiencia.

## Sintaxis de los Comandos

- Nombre de programa
- Modificadores (flags o tags): Alteran lo que el programa va a hacer
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

## Comunicacion y Administracion de Procesos

### Esquema basico de un Proceso

Un proceso tiene 3 flujos estándar entendidos por la terminal:

- Entrada estándar
- Salida estándar
- Error estándar

Puede haber más flujos, estos son los basicos

Los medios por defecto de entrada y salida de un proceso son los perifericos del PC.. teclado para entrada y pantalla para salida.

### Redireccionamiento de Procesos

Consiste en cambiar alguno de estos medios de entrada y salida.

- Redireccionar la entrada de un proceso para recibirla desde un archivo en vez del teclado: Operador `<`.

  `<command> < <filename>`

  Por ejemplo:

  `mysql -h 127.0.0.1 -u root -p 1234 < dump1.sql`

- Redireccionar la salida de un proceso para almacenarla en un archivo: Operador `>` o `>>`

  `<command> > <filename>`

  `<command> >> <filename>`

  `>` crea un archivo nuevo o sobreescribe el especificado, `>>` crea un archivo nuevo o escribe el especificado añadiendose al contenido existente.

  Por ejemplo:

  `ls > output.txt `

- Redireccionar la salida de un proceso para convertirlo en la entrada de otro proceso, y asi sucesivamente: Operador `|` (pipe).

  `<command1> | <command2> | <command3> | ...`

  Por ejemplo:

  `cat dump1.sql | wc -l`

### Procesos Background y Foreground

Cuando los procesos requieren tiempo para ejecutarse, se pueden enviar a un segundo plano de ejecucion (background). En la terminal se puede enviar un proceso al background agregando `&` al final.

Por ejemplo:

`mysql -h 127.0.0.1 -u root -p 1234 < dump1.sql &`

Esto envia el proceso al background, y cuando se termine la terminal notifica.

Tambien hay procesos que necesitan estar vivos constantemente, por ejemplo servidores. A esos procesos se les conoce como servicios o demons. Un proceso ingresado con un comando se puede convertir en servicio presionando `Ctrl + Z`. Se puede traer nuevamente al primer plano escribiendo el comando `fg`

#### Ver los procesos activos

`ps`  muestra los procesos que estoy ejecutando yo

`ps ax` me arroja todos los procesos del sistema, junto con informacion adicional como el archivo que se esta ejecutando.

`ps` y `ps aux` son utilidades batch, eso significa que se puede usar el pipe para relacionarlo con otros comandos, por ejemplo

`ps aux | grep ruby` muestra todos los procesos que tienen la palabra ruby en algun lado.

`top` es una utilidad interactiva que muestra los procesos que más recursos estan consumiendo, en tiempo real.

#### Detener un proceso

Los comandos `ps`, `ps aux` y `top` muestran entre otras cosas el PID (Process ID). Con este process ID se puede referenciar el proceso para detenerlo, usando el comando `kill` y `killall`.

`kill` envía por default señales a los procesos para que se detengan. Se envía una señal para que el proceso no se detenga abruptamente, sino que el proceso reciba la señal y la procese cuando sea debido. Para detener un proceso abruptamente se envia el modificador `-9` al comando:

`kill -9 <pid>`

Por otro lado, `killall` detiene el proceso, pero recibe el nombre del archivo ejecutable, en lugar del PID.

`killall ruby`

### Sistema de permisos octal

El sistema Unix tiene una arquitectura pensada para varios usuarios. Alrededor de un archivo hay 3 tipos de usuario:

- Dueño
- Grupo (Usuarios con acceso al archivo)
- Otros

En un archivo se pueden hacer 3 tipos de operación:

- Lectura (`r`)
- Escritura (`w`)
- Ejecución (`x`)

Los permisos se pueden cruzar con los tipos de usuario y generar esta matriz

|           | Dueño | Grupo | Otros |
| --------- | ----- | ----- | ----- |
| Lectura   |       |       |       |
| Escritura |       |       |       |
| Ejecución |       |       |       |

En la terminal con el comando `ls -l` se pueden ver los permisos que tiene cada usuario sobre cada archivo:

`-rw-r--r-- 1 miguelprada staff  92 Jun 11 20:46 archivo.txt`

La combinación `-rw-r--r--` muestra los permisos sobre el archivo.

- `-` al comienzo indica que tipo de archivo es (`d` para directorio `l` para link y `-` para archivo)
- `rw-` muestra los permisos del dueño: lectura y escritura pero no ejecución
- `r--` muestra los permisos del grupo: solo lectura.
- `r--` muestra los permisos de otros: solo lectura.

#### Comandos para manipular los permisos

- `chmod` permite cambiar los permisos que hay sobre un archivo

  - Forma textual

    `chmod o-w archivo.txt` le quita (`-`) el permiso de lectura (`w`) al owner (`o`).

    `chmod +x archivo.txt` le agrega (`+`) el permiso de ejecución (`x`) a todos los archivos.

  - Forma binaria

    Los permisos son un valor binario: o se tienen o se tienen. Se puede ingresar la combinacion de permisos sobre un tipo de usuario con unos y ceros, por ejemplo:

    - Solo lectura: `r-- => 100 = 4`
    - Lectura y escritura: `rw- => 110 = 6`
    - Lectura escritura y ejecucion: `rwx => 111 = 7`

    `chmod 764 archivo.txt` genera los permisos `rwxrw-r--` a `archivo.txt`.

- `chown` modifica el owner a un archivo (requiere `sudo`)

- `chgrp` modifica el grupo a un archivo (requiere `sudo` o ser el owner).

## Utilidades avanzadas

### Compresión y Combinación de Archivos

`gzip` y `tar` son utilidades muy usadas

- `gzip`

  `gzip <filename>` para comprimir un solo archivo. Genera un archivo con extensión .gz

  `gzip -d <filename>` para descomprimirlo

- `tar`

  `tar cf backup.tar backup/*` **agrupa** todos los archivos del directorio `backup/*` y lo guarda en el archivo `backup.tar`

  `tar xf backup.tar` para desagruparlos

  `tar czf backup.tgz backup/*` **agrupa y comprime** los archivos

  `tar xzf backup.tgz` para desagruparlos y descomprimir.

### Busqueda de archivos

- `locate` busca un archivo por su nombre en todo el sistema de archivos. Se basa en una base de datos que guarda el sistema de archivos, y se debe actualizar manualmente.

  `sudo uptadedb` para actualizar la base de datos

  `locate <filename>`

- `whereis` ubica comandos.

  `whereis echo`

- `find` busca dentro de un directorio una serie de criterios

  `find . -user mauro -perm 644` busca todos los archivos y carpetas que pertenezcan al usuario mauro (`-user mauro`) y que tengan permisos de lectura y escritura para owner y solo lectura para los demás (`-perm 644`).

  `find . -type f -mtime +7` busca todos los archivos (`-type f`) que fueron modiifcados hace maximo 7 dias (`-mtime +7`)

  `find . -type f -mtime + 7 -exec cp {} ./backup/ \;`

### Interaccion con servidores web

- `curl` es basica.. hace una peticion, obtiene una respuesta y la recibe en pantalla

  `curl https://www.platzi.com`

  `curl -v https://www.platzi.com` muestra tambien la interaccion HTTP necesaria antes de tener respuesta.

  `curl -v https://www.platzi.com > /dev/null`

- `wget` es mas flexible

  `wget http://www.php.net/distributions/php/distributions`

### Acceso seguro a otras computadores

`ssh <defined_configs>`

los `<defined_configs>` estan definidos en la carpeta `.ssh/`, con la clave publica y clave privada

### Variables de entorno

- `echo $<nombreVar>` para ver el valor de una variable
- `export <varName>=<valor>`para declarar una variable de entorno
- `<varName>=<valor> <comando>` para declarar una variable solamente para la ejecucion del comando 

## Automatización de Tareas :D

La terminal permite crear scripts, agrupaciones de comandos para ejecutarse cuando se ejecute el archivo en el que se guarda el mismo.

### Programación de tareas

`at now +2 minues`

`crontab -e`

