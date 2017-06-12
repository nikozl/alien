### SCRIPT QUE COJE TODAS LAS PALABRAS DE UN FICHERO CREADO PREVIAMENTE MEDIANTE EL PROGRAMA PYTHON "WORDS.PY" Y TRATA DE DESENCRIPTAR UN FICHERO ###

#! /bin/bash

main() {
prueba=$(cat pass.txt | while read LINE
do
echo $LINE
done)
password=(${prueba[@]})
for i in "${password[@]}"; do
openssl aes-256-cbc -d -a -in *.enc -pass pass:$i -out niko
pre=$(echo $?)
 if [[ ${pre} == "0" ]]; then
 echo "la buena es:: $i"
 exit
 fi 
done
}

main "$@"
