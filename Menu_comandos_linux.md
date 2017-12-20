#!/bin/bash

echo " "
if [ $1 -z ]; 
then echo 'Debe introducir nombre de fichero o directorios con los que desea realizar la acción'
echo " "
exit 
fi

echo " "
echo ' M E N U   C O M A N D O S  L I N U X'
echo '------------------------------------------------------'
echo ' 1-Crear directorio'
echo ' 2-Copiar directorio a otro directorio'
echo ' 3-Crear fichero'
echo ' 4-Enumerar y mostrar filas de un fichero'
echo ' 5-Copiar fichero a otro fichero'
echo ' 6-Mover fichero a directorio'
echo ' 7-Borrar fichero'
echo ' 8-Borrar directorio'
echo ' 9-Contar líneas, palabras y tamaño de un fichero'
echo '10-Buscar directorios'
echo '11-Buscar ficheros'
echo '12-Añadir secuencia a fichero'
echo '13-Borrar una línea de fichero'
echo '14-Mostrar primeras y ultimas líneas de un fichero'
echo '15-Ordenar fichero por columna de mayor a menor'
echo '16-Ordenar fichero por columna de menor a mayor'
echo '17-Contador duplicados por columna de un fichero'
echo '18-Copiar columnas de un fichero a otro'
echo '19-Buscar palabra en un fichero'
echo '20-Buscar direcciones de mail en un fichero'
echo '21-Sustituir palabras o caracteres de un fichero'
echo '22-Borrar filas en blanco de un fichero'
echo '23-Borrar filas que contengan palabra o caracter tecleado'
echo '24-Comprimir ficheros'
echo '25-Listar ficheros comprimidos'
echo '26-Descomprimir ficheros'
echo '27-Encolumnar fichero .csv'
echo '28-Convertir fichero .csv en tabla sql'
echo '98-Añade directorio al final de PATH'
echo '99-Copia historial comandos'
echo 'x-Salir'

echo " "
echo 'Recuerde que el nombre de ficheros y directorios debe informarse con la ejecución del script'
echo " "
#echo 'Incluya opción y parámetros'

echo " "
echo "teclée opción a realizar con el directorio/s o fichero/s:  $1 $2 $3 $4"

read -p 'Opción menú: ' OPCION

echo " "
#echo "opción elegida: $OPCION "


case $OPCION in
    1)
        mkdir $1;;
    2)
        cp -r $1 $2;;
    3)
        touch $1;;
    4)
        cat -n $1;;
    5)
        cp -p $1 $2;;
    6)
        mv $1 $2;;
    7)
        rm $1;;
    8)
        rm -r $1;;
    9)
        wc $1;;
    10)
        find . -type d -iname  "*$1*";;
    11)
        find . -type f -iname "*$1*";;
    12)
        REGISTROS=$(wc -l $1 | tr [:blank:] '\n' | head -n1);
        seq 1 $REGISTROS > seq.$1;
        #copia de seguridad antes de realizar acción
        cp -p $1 copias.$1;
        paste -d '^' seq.$1 $1 > $1.temp;
        cp -p $1.temp $1;
        rm $1.temp seq.$1;;
    13)
        read -p 'Introduzca número de fila a borrar: ' FILA;
        #copia de seguridad antes de realizar acción
        cp -p $1 copias.$1;
        sed -i $FILA'd' $1;;
    14)
        wc $1;
        read -p 'Introduzca número de líneas a mostrar de cabecera fichero: ' NUMLIN1;
        read -p 'Introduzca número de líneas a mostrar de final fichero: ' NUMLIN2;
        head -n '+'$NUMLIN1 $1;
        tail -n '-'$NUMLIN2 $1;;
    15)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        read -p 'Introduzca número de columna: ' NUNCOL;
        sort -n  -t "$DELIMITADOR" -k $NUNCOL'r' $1 > 'sort'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero sort$(date +%d%m%y)_$1";;
    16)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        read -p 'Introduzca número de columna: ' NUNCOL;
        sort -t "$DELIMITADOR" -k $NUNCOL $1 > 'sort'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero sort$(date +%d%m%y)_$1";;
    17)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        read -p 'Introduzca número de columna: ' NUNCOL;
        (sort -bdf -t "$DELIMITADOR" -k $NUNCOL $1 | uniq -ic | sort -nr) > 'dupl'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero dupl$(date +%d%m%y)_$1";;    
    18)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        read -p 'Introduzca número/s de columna/s a copiar separadas por coma (,) y/o guión para grupo de columnas (-): ' NUNCOL;
        (cut -d "$DELIMITADOR" -f $NUNCOL $1) > 'new'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero new$(date +%d%m%y)_$1";;    
    19)
        read -p 'Introduzca palabra a buscar: ' PALABRA;
        (grep -nl $PALABRA $1) > 'selec'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero selec$(date +%d%m%y)_$1";;    
    20)
        (grep -Eio '[a-z0-9._-]+@[a-z0-9.-]+[a-z]{2,4}' $1) > 'selec'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero selec$(date +%d%m%y)_$1";;    
    21)
        read -p 'Introduzca palabra o caracter a sustituir: ' PALABRA1;
        read -p 'Introduzca palabra o Caracter por la que desea sustituir: ' PALABRA2;
        (sed "s/$PALABRA1/$PALABRA2/g" $1) > 'sust'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero sust$(date +%d%m%y)_$1";;    
    22)
        (sed -e "/^$/d" $1) > 'sust'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero sust$(date +%d%m%y)_$1";;    
    23)
        read -p 'Introduzca palabra o Caracter que contenga la/s linea/s a borrar: ' PALABRA1;
        (sed -e "/$PALABRA1/d" $1) > 'sust'$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero sust$(date +%d%m%y)_$1";;    
    24)
        read -p 'Introduzca nombre de fichero comprimido: ' FICHZIP;
        zip $FICHZIP $1;;
    25)
        unzip -l $1;;
    26)
        unzip $1;;
    27)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        csvlook -d $DELIMITADOR  $1 > col$(date +%d%m%y)_$1;
        echo "Se ha creado el fichero col$(date +%d%m%y)_$1";;  
    28)
        head -n +1 $1;
        tail -n -2 $1;    
        read -p 'Introduzca delimitador de columna: ' DELIMITADOR;
        read -p 'Introduzca base de datos donde quiere crear la tabla (ejem. postgresql): ' BD;
        csvsql -d $DELIMITADOR -i $BD  $1;;
    98)
        PATH=$(PATH):new=$1;
        #añadir directorio al principio del path 
        #PATH=$(PATH):new=$1
        tail /home/dsc/.zshrc;;
    99)
        cat .history > historial_comandos.'f'$(date +%d%m%y);
        echo "Se ha creado el fichero historial_comandos.f$(date +%d%m%y)" ;;
    x)
        echo 'Hasta pronto!';;
esac

