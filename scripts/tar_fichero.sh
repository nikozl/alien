#! /bin/bash
### Script para sacar informacion de un fichero que esta en un tar sin descomprimirlo ###
### En este caso, busca en el fichero centos6/EULA la cadena CentOS e imprime la primera cadena de texto ###

hola=$(tar xfO centos6.tar.gz centos6/EULA |grep CentOS |awk '{print $1}')

if [[ ! -z $hola ]]; then
 echo "No esta vacia"
 echo "$hola"
else
echo "si esta vacia"
echo "$hola"
fi

