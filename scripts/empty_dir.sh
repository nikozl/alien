#! /bin/bash

### Script que busca en un directorio (en este caso BASEDIR) carpetas vacias y crea un fichero oculto por cada carpeta vacia ###

set -e
set -x

BASEDIR=/home/niko/py

find_empty_dir() {
empty=$(find ${BASEDIR} -type d -empty)
for i in ${empty[@]};
do
touch $i/.keep
done
}

find_empty_dir "$@"
