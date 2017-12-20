#! /bin/bash

echo "Escriba el primer numero"
read n1

echo "Escriba el segundo numero"
read n2

echo "Espere un segundo"

sleep 1

clear screen
echo "Menu"
echo "===="
echo
echo "1. Suma"
echo "2. Resta"
echo "3. Multiplicacion"
echo "4. División"
echo "0. Salir"
read opcion

case $opcion in
1) echo "suma"
let s=$n1+$n2
echo "La Suma es: $s";;
2) echo "resta"
let r=$n1-$n2
echo "La Resta es: $r";;
3) echo "Multiplicación"
let m=$n1*$n2
echo "La Multiplicación es: $m";;
4) echo "División"
let d=$n1/$n2
echo "La División es: $d";;
*) echo "Opción fuera de rango"
esac
