#! /bin/bash

ips=(192.168.100.1 192.168.100.2) # ---> array de ips, separadas por un espacio entra ellas
for i in ${ips[@]};
do
nmap $i >> niko.txt # ---> Fichero donde manda la salida
done
