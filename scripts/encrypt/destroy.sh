### SCRIPT QUE COJE TODAS LAS PALABRAS DE UN FICHERO CREADO PREVIAMENTE MEDIANTE EL PROGRAMA PYTHON "WORDS.PY" Y TRATA DE DESENCRIPTAR UN FICHERO ###
### AL FINAL NOS MUESTRA LAS POSIBLES OPCIONES, Y NOS ENCARGAMOS DE PROBAR LA BUENA ###

#! /bin/bash

main() {
prueba=$(cat pass.txt | while read LINE
do
echo $LINE
done)
password=(${prueba[@]})
for i in "${password[@]}"; do
openssl aes-256-cbc -d -a -in *.enc -pass pass:$i -out /root/pruebas/niko_$i
pre=$(echo $?)
 if [[ ${pre} == "0" ]]; then
# echo "la buena es:: $i"
 echo "Posibles contras: $i" >> posibles.txt
 fi 
done

echo "FIN"
cat posibles.txt
rm -rf posibles.txt
}

main "$@"
